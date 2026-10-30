#!/usr/bin/env node
// Syncs the docs with the latest stable release of one hiero-ledger SDK and
// writes a review report used as the body of the automated PR.
//
// Usage:
//   node sdk-sync.js --sdk java [--from 2.76.0] [--report report.md]
//
// State lives in .github/sdk-sync/<sdk>.json: the SDK version the docs were last
// reviewed against, plus the package identity seen at that version. Merging the
// sync PR is what advances it. When a newer stable release exists, this script:
//  1. bumps explicit install pins in the docs to the latest version
//  2. diffs the public Transaction/Query classes and their methods between the
//     two tags (from the source trees, not the changelog), and cross-references
//     every change against the docs
//  3. flags breaking/deprecation notes from every release in between
//  4. flags a package rename upstream, and retired identifiers still in the docs
//  5. writes the new state and the report
//
// Requires Node 22+ (global fetch). Set GH_TOKEN to avoid API rate limits.
// Writes changed/from/to/name to $GITHUB_OUTPUT when running in Actions.

'use strict';

const fs = require('fs');
const os = require('os');
const path = require('path');
const SOURCES = require('./lib/sdk-sources');
const {
  ROOT,
  STABLE_TAG,
  parseArgs,
  compareVersions,
  setOutput,
  rawFile,
  mapLimit,
  stableReleases,
  classInventory,
  loadIgnore,
  listFiles,
  buildDocsIndex,
  pagesMentioning,
  methodDocumented,
} = require('./lib/sdk-common');

const STATE_DIR = path.join(ROOT, '.github/sdk-sync');
// Non-MDX files that pin an SDK version (the CI harness that runs the docs examples).
const EXTRA_PIN_FILES = ['.github/scripts/java-gradle-bootstrap.sh'];
// GitHub caps PR bodies at 65,536 characters.
const MAX_REPORT = 60000;

// ── API surface diff ──────────────────────────────────────────────────────

async function diffApi(sdk, fromTag, toTag, warnings) {
  const [before, after] = await Promise.all([classInventory(sdk, fromTag), classInventory(sdk, toTag)]);

  if (before.truncated || after.truncated) {
    warnings.push('The upstream source tree listing was truncated, so the class diff may be incomplete.');
  }
  if (after.classes.size === 0) {
    warnings.push(
      `No Transaction/Query source files matched at ${toTag}. The SDK layout may have changed; ` +
        'update `classFile` in `.github/scripts/lib/sdk-sources.js`.'
    );
  }

  const added = [...after.classes.keys()].filter(name => !before.classes.has(name)).sort();
  const removed = [...before.classes.keys()].filter(name => !after.classes.has(name)).sort();
  // Same class, different blob: the only files worth downloading.
  const modified = [...after.classes.keys()].filter(
    name => before.classes.has(name) && before.classes.get(name).sha !== after.classes.get(name).sha
  );

  const methodChanges = (
    await mapLimit(modified, 8, async name => {
      const [oldSource, newSource] = await Promise.all([
        rawFile(sdk.repo, fromTag, before.classes.get(name).path),
        rawFile(sdk.repo, toTag, after.classes.get(name).path),
      ]);
      if (oldSource === null || newSource === null) return null;

      const oldMethods = sdk.methods(oldSource, name);
      const newMethods = sdk.methods(newSource, name);
      const newlyDeprecated = new Set([...(newMethods.deprecated || [])].filter(m => oldMethods.has(m)));
      const addedMethods = [...newMethods].filter(m => !oldMethods.has(m)).sort();
      const removedMethods = [...oldMethods].filter(m => !newMethods.has(m) && !newlyDeprecated.has(m)).sort();
      const deprecatedMethods = [...newlyDeprecated].sort();
      if (!addedMethods.length && !removedMethods.length && !deprecatedMethods.length) return null;

      return {
        name,
        path: after.classes.get(name).path,
        added: addedMethods,
        removed: removedMethods,
        deprecated: deprecatedMethods,
      };
    })
  )
    .filter(Boolean)
    .sort((a, b) => a.name.localeCompare(b.name));

  // Leave out APIs the docs deliberately don't cover (.github/sdk-sync/ignore.json).
  const ignore = loadIgnore();
  const kept = name => !ignore.isClassIgnored(name);
  const keptMethods = (methods, className) => methods.filter(m => !ignore.isMethodIgnored(m, className));
  const shownMethodChanges = methodChanges
    .filter(change => kept(change.name))
    .map(change => ({
      ...change,
      added: keptMethods(change.added, change.name),
      removed: keptMethods(change.removed, change.name),
      deprecated: keptMethods(change.deprecated, change.name),
    }))
    .filter(change => change.added.length || change.removed.length || change.deprecated.length);

  return {
    added: added.filter(kept).map(name => ({ name, path: after.classes.get(name).path })),
    removed: removed.filter(kept).map(name => ({ name, path: before.classes.get(name).path })),
    modifiedCount: modified.length,
    methodChanges: shownMethodChanges,
  };
}

// ── Pins, release notes, identity ─────────────────────────────────────────

function bumpPins(sdk, latest, files) {
  const changes = [];

  for (const file of files) {
    const pins = sdk.pins.filter(pin => pin.file.test(file));
    if (pins.length === 0) continue;

    const abs = path.join(ROOT, file);
    const original = fs.readFileSync(abs, 'utf8');
    const previous = new Set();
    let count = 0;
    let updated = original;

    for (const pin of pins) {
      updated = updated.replace(pin.regex, (match, prefix, version) => {
        if (compareVersions(version, latest) >= 0) return match;
        previous.add(version);
        count++;
        return prefix + latest;
      });
    }

    if (updated !== original) {
      fs.writeFileSync(abs, updated, 'utf8');
      changes.push({ file, previous: [...previous], count });
    }
  }

  return changes;
}

// Release-note lines a reviewer must not miss: anything under a "Breaking" or
// "Deprecat..." heading, plus any line calling out a breaking change or deprecation.
function releaseNoteFlags(release, repo) {
  const flags = [];
  let flaggedSection = false;

  for (const line of release.body.split(/\r?\n/)) {
    const heading = line.match(/^#+\s+(.*)$/);
    if (heading) {
      flaggedSection = /breaking|deprecat|removed/i.test(heading[1]);
      continue;
    }

    const text = line.replace(/^\s*[-*]\s+/, '').trim();
    if (!text || /^```/.test(text)) continue;

    const isBullet = /^\s*[-*]\s+/.test(line);
    const callsOut = /\bbreaking\b|\bdeprecat|^\w+(\([^)]*\))?!:/i.test(text);

    if ((flaggedSection && isBullet) || callsOut) {
      flags.push(neutralize(text.length > 400 ? `${text.slice(0, 400)}…` : text, repo));
    }
  }

  return flags;
}

// Keep upstream release text from pinging people or auto-linking to this repo's issues.
function neutralize(text, repo) {
  return text
    .replace(/(^|[^\w`/])@([A-Za-z0-9][\w-]*)/g, '$1@\u200b$2')
    .replace(/(^|[\s(])#(\d+)\b/g, `$1[#$2](https://github.com/${repo}/issues/$2)`);
}

async function upstreamIdentity(sdk, tag) {
  const text = await rawFile(sdk.repo, tag, sdk.identity.file);
  if (text === null) return null;
  try {
    return sdk.identity.parse(text) || null;
  } catch {
    return null;
  }
}

function legacyUsage(sdk, index) {
  return sdk.legacy
    .map(({ find, use }) => ({
      find,
      use,
      pages: [...index.entries()].filter(([, page]) => page.text.includes(find)).map(([page]) => page),
    }))
    .filter(entry => entry.pages.length > 0);
}

// ── Report ────────────────────────────────────────────────────────────────

const code = value => `\`${value}\``;
const pageList = pages => pages.map(code).join(', ');

function buildReport(ctx) {
  const { sdk, key, from, latest, releases, pins, api, flags, identity, legacy, index, warnings } = ctx;
  const repoUrl = `https://github.com/${sdk.repo}`;
  const src = (tag, file) => `${repoUrl}/blob/${tag}/${file}`;
  const out = [];

  out.push(`## ${sdk.name} docs sync: v${from.version} → v${latest.version}`, '');
  out.push(
    `Source of truth: [${sdk.repo}](${repoUrl}) · ` +
      `[Compare ${from.tag}...${latest.tag}](${repoUrl}/compare/${from.tag}...${latest.tag})`,
    ''
  );

  if (releases.length > 0) {
    out.push(`**Releases covered:** ${releases.map(r => `[${r.tag}](${r.url}) (${r.date})`).join(', ')}`, '');
  }

  for (const warning of warnings) out.push(`> [!WARNING]`, `> ${warning}`, '');

  if (identity.renamed) {
    out.push(
      '> [!CAUTION]',
      `> **Package renamed upstream:** ${code(identity.previous)} → ${code(identity.current)} ` +
        `(read from ${code(sdk.identity.file)}). Update install instructions, imports, and pins across the docs, ` +
        'then add the new coordinates to `pins` and the old ones to `legacy` in `.github/scripts/lib/sdk-sources.js`.',
      ''
    );
  }

  const undocumentedClasses = api ? api.added.filter(c => pagesMentioning(index, c.name).length === 0) : [];
  const methodGaps = api ? api.methodChanges.length : 0;

  out.push('### Summary', '', '| Check | Result |', '| --- | --- |');
  out.push(
    `| Install pins bumped to v${latest.version} | ${
      pins.length ? `${pins.reduce((n, p) => n + p.count, 0)} in ${pins.length} file(s)` : 'none needed'
    } |`
  );
  if (api) {
    out.push(`| New Transaction/Query classes | ${api.added.length} (${undocumentedClasses.length} not in docs) |`);
    out.push(`| Removed classes | ${api.removed.length} |`);
    out.push(`| Classes with public method changes | ${methodGaps} (of ${api.modifiedCount} modified files) |`);
  }
  out.push(`| Breaking/deprecation notes in releases | ${flags.reduce((n, f) => n + f.lines.length, 0)} |`);
  out.push(`| Retired identifiers still in docs | ${legacy.length ? legacy.map(l => code(l.find)).join(', ') : 'none'} |`);
  out.push('');

  if (pins.length > 0) {
    out.push('### Install pins updated (automated)', '');
    for (const pin of pins) {
      out.push(`- ${code(pin.file)}: ${pin.previous.join(', ')} → ${latest.version} (${pin.count})`);
    }
    out.push('');
  }

  if (flags.length > 0) {
    out.push('### Breaking changes and deprecations (from release notes)', '');
    for (const flag of flags) {
      out.push(`**[${flag.tag}](${flag.url})**`, '');
      for (const line of flag.lines) out.push(`- [ ] ${line}`);
      out.push('');
    }
  }

  if (api && (api.added.length || api.removed.length || api.methodChanges.length)) {
    out.push(`### API surface changes (${from.tag} → ${latest.tag})`, '');
    out.push('_Diffed from the SDK source trees. Each item needs a reviewer decision: document it, or tick it as not needed._', '');

    if (api.added.length > 0) {
      out.push('#### New classes', '');
      for (const cls of api.added) {
        const pages = pagesMentioning(index, cls.name);
        out.push(
          `- [ ] [${code(cls.name)}](${src(latest.tag, cls.path)}): ` +
            (pages.length ? `mentioned in ${pageList(pages.slice(0, 5))}` : '**not mentioned anywhere in the docs**')
        );
      }
      out.push('');
    }

    if (api.removed.length > 0) {
      out.push('#### Removed classes', '');
      for (const cls of api.removed) {
        const pages = pagesMentioning(index, cls.name);
        out.push(
          `- [ ] ${code(cls.name)}: ` +
            (pages.length ? `**still referenced in** ${pageList(pages)}` : 'not referenced in the docs')
        );
      }
      out.push('');
    }

    if (api.methodChanges.length > 0) {
      out.push('#### Method changes', '');
      for (const change of api.methodChanges) {
        const pages = pagesMentioning(index, change.name);
        out.push(
          `- [ ] [${code(change.name)}](${src(latest.tag, change.path)}) ` +
            (pages.length ? `(reference page: ${code(pages[0])})` : '(class not in docs)')
        );
        if (change.added.length) {
          const items = change.added.map(m =>
            pages.length && methodDocumented(index, pages, m) ? code(m) : `${code(m)} **(not in docs)**`
          );
          out.push(`  - Added: ${items.join(', ')}`);
        }
        for (const [label, methods] of [['Removed', change.removed], ['Deprecated', change.deprecated]]) {
          if (!methods.length) continue;
          const items = methods.map(m =>
            pages.length && methodDocumented(index, pages, m) ? `${code(m)} **(still in docs)**` : code(m)
          );
          out.push(`  - ${label}: ${items.join(', ')}`);
        }
      }
      out.push('');
    }
  }

  if (legacy.length > 0) {
    out.push('### Retired identifiers still in the docs (not auto-fixed)', '');
    out.push('_Some mentions may be intentional (migration notes). Fix the rest here or in a follow-up._', '');
    for (const entry of legacy) {
      out.push(`- ${code(entry.find)} → ${code(entry.use)}: ${pageList(entry.pages)}`);
    }
    out.push('');
  }

  out.push(
    '### Review checklist',
    '',
    `- [ ] Read the [release notes](${repoUrl}/releases) for every release covered above`,
    '- [ ] Resolve each API and breaking-change item above (push doc fixes to this branch)',
    '- [ ] Update code examples whose APIs changed, and keep the EVM-address terminology rules in `CLAUDE.md`',
    '- [ ] Run `mint broken-links` locally',
    '',
    `Merging this PR records v${latest.version} as the reviewed ${sdk.name} version in ${code(
      `.github/sdk-sync/${key}.json`
    )}.`
  );

  return out.join('\n') + '\n';
}

// ── Main ──────────────────────────────────────────────────────────────────

async function main() {
  const args = parseArgs(process.argv);
  const key = args.sdk;
  const sdk = SOURCES[key];

  if (!sdk) {
    throw new Error(`Usage: node sdk-sync.js --sdk <${Object.keys(SOURCES).join('|')}> [--from X.Y.Z] [--report file]`);
  }

  const statePath = path.join(STATE_DIR, `${key}.json`);
  const state = JSON.parse(fs.readFileSync(statePath, 'utf8'));
  const fromVersion = (args.from || state.version).replace(/^v/, '');

  if (!STABLE_TAG.test(fromVersion)) {
    throw new Error(`Invalid baseline version "${fromVersion}". Expected X.Y.Z.`);
  }

  const releases = await stableReleases(sdk.repo);
  if (releases.length === 0) throw new Error(`No stable releases found for ${sdk.repo}.`);

  const latest = releases[releases.length - 1];
  const from = releases.find(r => r.version === fromVersion) || { version: fromVersion, tag: `v${fromVersion}` };
  const hasNewRelease = compareVersions(latest.version, from.version) > 0;
  const covered = releases.filter(
    r => compareVersions(r.version, from.version) > 0 && compareVersions(r.version, latest.version) <= 0
  );

  const pages = listFiles();
  const pins = bumpPins(sdk, latest.version, [...pages, ...EXTRA_PIN_FILES]);

  const current = await upstreamIdentity(sdk, latest.tag);
  const identity = {
    previous: state.package,
    current: current || state.package,
    renamed: Boolean(current && state.package && current !== state.package),
  };

  if (!hasNewRelease && pins.length === 0 && !identity.renamed) {
    console.log(`${sdk.name}: docs are in sync with v${latest.version}. Nothing to do.`);
    setOutput({ changed: 'false' });
    return;
  }

  const warnings = [];
  if (!current) {
    warnings.push(`Could not read the package name from ${code(sdk.identity.file)} at ${latest.tag}.`);
  }

  const api = hasNewRelease ? await diffApi(sdk, from.tag, latest.tag, warnings) : null;
  const flags = covered
    .map(release => ({ tag: release.tag, url: release.url, lines: releaseNoteFlags(release, sdk.repo) }))
    .filter(flag => flag.lines.length > 0)
    .reverse();
  // Index after bumping pins so the report reflects the updated pages.
  const index = buildDocsIndex(pages);
  const legacy = legacyUsage(sdk, index);

  const report = buildReport({ sdk, key, from, latest, releases: covered, pins, api, flags, identity, legacy, index, warnings });
  const reportPath = args.report || path.join(process.env.RUNNER_TEMP || os.tmpdir(), `sdk-sync-${key}.md`);
  const bodyPath = reportPath.replace(/(\.md)?$/, '.body.md');
  fs.writeFileSync(reportPath, report, 'utf8');
  fs.writeFileSync(
    bodyPath,
    report.length > MAX_REPORT
      ? report.slice(0, MAX_REPORT) +
          '\n\n_Report truncated. The full report is attached to the workflow run as an artifact._\n'
      : report,
    'utf8'
  );

  if (!args.from || compareVersions(latest.version, state.version) > 0) {
    fs.writeFileSync(
      statePath,
      JSON.stringify({ ...state, version: latest.version, package: identity.current }, null, 2) + '\n',
      'utf8'
    );
  }

  console.log(
    `${sdk.name}: v${from.version} → v${latest.version}. ` +
      `${pins.length} pinned file(s) updated` +
      (api
        ? `, ${api.added.length} new / ${api.removed.length} removed classes, ${api.methodChanges.length} with method changes`
        : '') +
      `. Report: ${reportPath}`
  );

  setOutput({
    changed: 'true',
    name: sdk.name,
    from: from.version,
    to: latest.version,
    report: reportPath,
    body: bodyPath,
  });
}

main().catch(error => {
  console.error(`ERROR: ${error.message}`);
  process.exit(1);
});
