#!/usr/bin/env node
// Generates and prepends a mirror node release notes MDX entry.
// Usage:
// node mirror-node-release-entry.js --version X.Y.Z --release-json release.json --target path/to/mirror-node.mdx

'use strict';

const fs = require('fs');

const REPO_URL = 'https://github.com/hiero-ledger/hiero-mirror-node';
const GITHUB_URL = 'https://github.com';

// The only categories rendered as accordions on this page, in this order.
// The release body also emits "Breaking Changes" (rewritten as editorial prose
// by a human), "Deployments", and "Contributors" — all intentionally dropped.
const RENDER_CATEGORIES = ['Enhancements', 'Bug Fixes', 'Dependency Upgrades'];

const ANCHOR_REGEX = /^##\s+Latest Releases\s*\r?\n/m;

function parseArgs(argv) {
  const parsed = {};

  for (let i = 2; i < argv.length; i += 2) {
    const key = argv[i];
    const value = argv[i + 1];

    if (!key || !key.startsWith('--')) {
      throw new Error(`Invalid argument "${key || ''}". Expected --key value.`);
    }

    if (!value || value.startsWith('--')) {
      throw new Error(`Missing value for argument "${key}".`);
    }

    parsed[key.slice(2)] = value;
  }

  return parsed;
}

function normalizeVersion(input) {
  const raw = String(input || '').trim();
  const version = raw.replace(/^v/i, '');

  if (!/^\d+\.\d+\.\d+(-[0-9A-Za-z.-]+)?$/.test(version)) {
    throw new Error(`Invalid version "${raw}". Expected X.Y.Z or vX.Y.Z.`);
  }

  return version;
}

function linkAuthor(bullet) {
  return bullet.replace(
    /\bby @([A-Za-z0-9](?:[A-Za-z0-9-]*[A-Za-z0-9])?)\s*$/,
    (match, handle) => `by [@${handle}](${GITHUB_URL}/${handle})`
  );
}

function escapeRegExp(value) {
  return value.replace(/[.*+?^${}()|[\]\\]/g, '\\$&');
}

function escapeMdxAttribute(value) {
  return value
    .replace(/&/g, '&amp;')
    .replace(/"/g, '&quot;')
    .replace(/</g, '&lt;')
    .replace(/>/g, '&gt;');
}

function readFile(path) {
  try {
    return fs.readFileSync(path, 'utf8');
  } catch (error) {
    throw new Error(`Could not read "${path}": ${error.message}`);
  }
}

function writeFile(path, content) {
  try {
    fs.writeFileSync(path, content, 'utf8');
  } catch (error) {
    throw new Error(`Could not write "${path}": ${error.message}`);
  }
}

// The release body opens with a prose summary before the first `## Category`
// header. Copy it verbatim (minus a leading `# ...` title) as the entry's
// summary paragraph — markdown-escaped punctuation is unescaped to match the page.
function extractSummary(body) {
  const summaryLines = [];

  for (const line of body.split(/\r?\n/)) {
    if (/^##\s/.test(line)) break; // stop at the first category header
    if (/^#\s/.test(line)) continue; // skip a leading H1 title (e.g. "# Release Notes")
    summaryLines.push(line);
  }

  return summaryLines
    .join('\n')
    .replace(/\\([^A-Za-z0-9])/g, '$1')
    .trim();
}

function parseReleaseBody(body) {
  const blocks = new Map();
  let currentCategory = null;

  for (const line of body.split(/\r?\n/)) {
    const headerMatch = line.match(/^##\s+(.+?)\s*$/);

    if (headerMatch) {
      currentCategory = headerMatch[1].trim();

      if (!blocks.has(currentCategory)) {
        blocks.set(currentCategory, []);
      }

      continue;
    }

    if (currentCategory && /^[-*]\s+/.test(line)) {
      // Normalize a release-body bullet to this page's style:
      //  - strip the leading marker
      //  - reduce PR links `[#NNN](url)` to the plain `#NNN` ref the page uses
      //  - unescape markdown-escaped punctuation (e.g. `\_` -> `_`)
      const bullet = linkAuthor(
        line
          .replace(/^[-*]\s+/, '')
          .replace(/\\([^A-Za-z0-9])/g, '$1')
          .trimEnd()
      );

      if (bullet.trim()) {
        blocks.get(currentCategory).push(`  * ${bullet}`);
      }
    }
  }

  return blocks;
}

function buildCategoryOrder(blocks) {
  // Only the canonical accordion categories, in canonical order, that have
  // content. Everything else in the body (Breaking Changes, Deployments,
  // Contributors, anything new) is intentionally not rendered as an accordion.
  const orderedCategories = RENDER_CATEGORIES.filter(
    category => blocks.has(category) && blocks.get(category).length > 0
  );

  return { orderedCategories };
}

function main() {
  const args = parseArgs(process.argv);

  const version = normalizeVersion(args.version);
  const releaseJsonPath = args['release-json'];
  const target = args.target;

  if (!releaseJsonPath || !target) {
    throw new Error(
      'Usage: node mirror-node-release-entry.js --version X.Y.Z --release-json release.json --target path/to/mirror-node.mdx'
    );
  }

  const releaseJson = readFile(releaseJsonPath);
  const existingContent = readFile(target);

  let release;

  try {
    release = JSON.parse(releaseJson);
  } catch (error) {
    throw new Error(`Could not parse release JSON from "${releaseJsonPath}": ${error.message}`);
  }

  const expectedTag = `v${version}`;
  const tagName = typeof release.tagName === 'string' ? release.tagName : expectedTag;

  if (tagName !== expectedTag) {
    throw new Error(`Release tag mismatch. Expected "${expectedTag}", got "${tagName}".`);
  }

  const body = typeof release.body === 'string' ? release.body : '';
  const tagUrl =
    typeof release.url === 'string' && release.url.length > 0
      ? release.url
      : `${REPO_URL}/releases/tag/${expectedTag}`;

  const duplicateHeadingRegex = new RegExp(`^## \\[v${escapeRegExp(version)}\\]`, 'm');

  if (duplicateHeadingRegex.test(existingContent)) {
    console.log(`v${version} entry already exists in ${target}. Skipping.`);
    return;
  }

  const blocks = parseReleaseBody(body);
  const { orderedCategories } = buildCategoryOrder(blocks);

  const totalBullets = orderedCategories.reduce(
    (sum, category) => sum + blocks.get(category).length,
    0
  );

  if (totalBullets === 0) {
    throw new Error(
      `No bullets parsed from release body for v${version}.\n` +
        `The upstream release body format may have changed. Review manually:\n${body.slice(0, 500)}`
    );
  }

  const accordions = orderedCategories
    .map(category => {
      const title = escapeMdxAttribute(category);
      return `<Accordion title="${title}">\n${blocks.get(category).join('\n')}\n</Accordion>`;
    })
    .join('\n\n');

  const warnings = [];

  // Breaking Changes are rewritten as editorial prose by a human, not rendered
  // as an accordion. If the body has a Breaking Changes section, flag it.
  if (blocks.has('Breaking Changes')) {
    warnings.push(
      '<!-- TODO: this release has Breaking Changes in the upstream notes — add a "### Breaking Changes" prose section above the accordions. -->'
    );
  }

  // The entry opens with the release's own summary prose, copied verbatim from
  // the body. If the body has no preamble (e.g. a small patch release), omit it
  // entirely — no placeholder.
  const summary = extractSummary(body);

  const parts = [`## [v${version}](${tagUrl})`, ''];
  if (summary) parts.push(summary, '');
  if (warnings.length > 0) parts.push(...warnings, '');
  parts.push(accordions, '', '');

  const entry = parts.join('\n');

  const anchorMatch = existingContent.match(ANCHOR_REGEX);

  if (!anchorMatch || anchorMatch.index === undefined) {
    throw new Error(`Could not find "## Latest Releases" anchor in ${target}.`);
  }

  const insertPosition = anchorMatch.index + anchorMatch[0].length;
  const updated =
    existingContent.slice(0, insertPosition) +
    '\n' +
    entry +
    existingContent.slice(insertPosition);

  writeFile(target, updated);

  console.log(
    `Prepended v${version} entry to ${target} (${totalBullets} bullets across ${orderedCategories.length} categories).`
  );
}

try {
  main();
} catch (error) {
  console.error(`ERROR: ${error.message}`);
  process.exit(1);
}
