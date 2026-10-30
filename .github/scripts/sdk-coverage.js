#!/usr/bin/env node
// Lists SDK APIs that the docs do not cover yet, at each SDK's latest stable
// release, for the drafting step (sdk-draft-docs.js) to work through.
//
// Usage:
//   node sdk-coverage.js --out gaps.json [--summary gaps.md]
//
// Two kinds of gap, measured against the docs as they are now (not against a
// version diff, so the existing backlog and new releases are handled the same way):
//  - new-class:       a public Transaction/Query class that no SDK reference page
//                     (native/, outside the tutorials) mentions
//  - missing-methods: setter-style methods (set*/add*/clear*) of a documented
//                     class that its reference pages never mention. Measured on the
//                     JS and Java SDKs, whose names the docs' method tables use.
//
// Entries in .github/sdk-sync/ignore.json are skipped. Set GH_TOKEN to avoid API
// rate limits.

'use strict';

const fs = require('fs');
const path = require('path');
const SOURCES = require('./lib/sdk-sources');
const {
  ROOT,
  parseArgs,
  normalize,
  setOutput,
  rawFile,
  mapLimit,
  stableReleases,
  classInventory,
  loadIgnore,
  listFiles,
  buildDocsIndex,
  isNativeReferencePath,
  documentsClass,
  pagesMentioning,
  methodDocumented,
} = require('./lib/sdk-common');

// SDKs whose method names the docs' method tables follow.
const METHOD_SDKS = ['js', 'java'];
const SETTER_STYLE = /^(set|add|clear)[A-Z]/;

async function main() {
  const args = parseArgs(process.argv);
  if (!args.out) throw new Error('Usage: node sdk-coverage.js --out gaps.json [--summary gaps.md]');

  const ignore = loadIgnore();
  const index = buildDocsIndex(listFiles());
  const referencePages = name =>
    pagesMentioning(index, name).filter(page => isNativeReferencePath(page) && documentsClass(page, index.get(page), name));

  // Latest stable release and class inventory for every SDK.
  const sdks = {};
  for (const [key, sdk] of Object.entries(SOURCES)) {
    const releases = await stableReleases(sdk.repo);
    const latest = releases[releases.length - 1];
    const inventory = await classInventory(sdk, latest.tag);
    sdks[key] = { repo: sdk.repo, tag: latest.tag, classes: inventory.classes };
  }

  // Every SDK that ships each class, keyed by normalized class name.
  const byClass = new Map();
  for (const [key, info] of Object.entries(sdks)) {
    for (const [name, { path: file }] of info.classes) {
      const id = normalize(name);
      if (ignore.isClassIgnored(name)) continue;
      if (!byClass.has(id)) byClass.set(id, { className: name, sources: [] });
      byClass.get(id).sources.push({ sdk: key, path: file });
    }
  }

  const items = [];

  for (const [id, entry] of byClass) {
    const pages = referencePages(entry.className);

    if (pages.length === 0) {
      items.push({ id: `class:${id}`, kind: 'new-class', className: entry.className, sources: entry.sources });
      continue;
    }

    const methodSources = entry.sources.filter(s => METHOD_SDKS.includes(s.sdk));
    const missing = new Map();

    await mapLimit(methodSources, 4, async source => {
      const text = await rawFile(sdks[source.sdk].repo, sdks[source.sdk].tag, source.path);
      if (text === null) return;

      for (const method of SOURCES[source.sdk].methods(text, entry.className)) {
        if (!SETTER_STYLE.test(method) || ignore.isMethodIgnored(method, entry.className)) continue;
        // Check the class's own reference page only: a sibling page that mentions the
        // class and a same-named method of another class must not count.
        if (methodDocumented(index, [pages[0]], method)) continue;
        const key = normalize(method);
        if (!missing.has(key)) missing.set(key, { name: method, sdks: [] });
        missing.get(key).sdks.push(source.sdk);
      }
    });

    if (missing.size > 0) {
      items.push({
        id: `methods:${id}`,
        kind: 'missing-methods',
        className: entry.className,
        page: pages[0],
        methods: [...missing.values()].sort((a, b) => a.name.localeCompare(b.name)),
        sources: entry.sources,
      });
    }
  }

  // New pages first (most SDKs first), then method gaps (largest first).
  items.sort((a, b) => {
    if (a.kind !== b.kind) return a.kind === 'new-class' ? -1 : 1;
    const weight = item => (item.kind === 'new-class' ? item.sources.length : item.methods.length);
    return weight(b) - weight(a) || a.className.localeCompare(b.className);
  });

  const output = {
    sdks: Object.fromEntries(Object.entries(sdks).map(([key, info]) => [key, { repo: info.repo, tag: info.tag }])),
    items,
  };
  fs.writeFileSync(args.out, JSON.stringify(output, null, 2) + '\n', 'utf8');

  const newClasses = items.filter(item => item.kind === 'new-class');
  const methodItems = items.filter(item => item.kind === 'missing-methods');
  const methodCount = methodItems.reduce((n, item) => n + item.methods.length, 0);

  if (args.summary) {
    const lines = [
      '## SDK docs coverage',
      '',
      `**${newClasses.length}** classes with no reference page, **${methodCount}** methods missing from ` +
        `**${methodItems.length}** reference pages.`,
      '',
    ];
    if (newClasses.length) {
      lines.push('### Classes with no reference page', '');
      for (const item of newClasses) lines.push(`- \`${item.className}\` (${item.sources.map(s => s.sdk).join(', ')})`);
      lines.push('');
    }
    if (methodItems.length) {
      lines.push('### Methods missing from reference pages', '');
      for (const item of methodItems) {
        lines.push(`- \`${item.className}\` on \`${item.page}\`: ${item.methods.map(m => `\`${m.name}\``).join(', ')}`);
      }
      lines.push('');
    }
    fs.writeFileSync(args.summary, lines.join('\n'), 'utf8');
  }

  console.log(
    `${newClasses.length} classes with no reference page, ${methodCount} methods missing from ${methodItems.length} pages. ` +
      `Wrote ${args.out}.`
  );
  setOutput({ gaps: String(items.length) });
}

main().catch(error => {
  console.error(`ERROR: ${error.message}`);
  process.exit(1);
});
