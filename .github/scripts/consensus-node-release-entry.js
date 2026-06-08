#!/usr/bin/env node
// Generates and inserts a consensus node release notes build block.
// Usage:
// node consensus-node-release-entry.js --version X.Y.Z --release-json release.json --target path/to/services.mdx [--status-json status.json]
//
// Consensus node release notes nest per-build changelog blocks under a
// human-curated "## Release vX.Y" minor section. This script owns the
// mechanical build block. When the minor section does not yet exist (a new
// minor release), it scaffolds a stub section with placeholder editorial
// content for a human to fill in.

'use strict';

const fs = require('fs');

const REPO_URL = 'https://github.com/hiero-ledger/hiero-consensus-node';
const GITHUB_URL = 'https://github.com';

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

function escapeRegExp(value) {
  return value.replace(/[.*+?^${}()|[\]\\]/g, '\\$&');
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

// Link a trailing "by @user" handle to the contributor's GitHub profile.
function linkAuthor(bullet) {
  return bullet.replace(
    /\bby @([A-Za-z0-9](?:[A-Za-z0-9-]*[A-Za-z0-9])?)\s*$/,
    (match, handle) => `by [@${handle}](${GITHUB_URL}/${handle})`
  );
}

// Parse the release body into ordered [category, bullets[]] pairs, preserving
// the order categories appear in the release body.
function parseReleaseBody(body) {
  const categories = [];
  let current = null;

  for (const line of body.split(/\r?\n/)) {
    // Category headers are level-2 ("## Features"). Ignore the top-level
    // "# Release Notes" title and anything deeper.
    const headerMatch = line.match(/^##\s+(.+?)\s*$/);

    if (headerMatch) {
      current = { title: headerMatch[1].trim(), bullets: [] };
      categories.push(current);
      continue;
    }

    if (current && /^[-*]\s+/.test(line)) {
      // Strip the bullet marker and collapse internal runs of whitespace
      // (the release body sometimes has stray double spaces before PR links).
      const bullet = line
        .replace(/^[-*]\s+/, '')
        .replace(/[ \t]{2,}/g, ' ')
        .trimEnd();

      if (bullet.trim()) {
        current.bullets.push(`  * ${linkAuthor(bullet)}`);
      }
    }
  }

  return categories.filter(category => category.bullets.length > 0);
}

function buildChangelogBlock(version, tagUrl, categories) {
  const categoryBlocks = categories
    .map(category => `### **${category.title}**\n\n${category.bullets.join('\n')}`)
    .join('\n\n');

  return [
    `### [**Build ${version}**](${tagUrl})`,
    '',
    `<Accordion title="What's Changed">`,
    '',
    categoryBlocks,
    '',
    `  **Full Release Notes**: [**v${version}**](${tagUrl})`,
    '',
    `</Accordion>`,
    '',
  ].join('\n');
}

const MONTHS = [
  'JANUARY', 'FEBRUARY', 'MARCH', 'APRIL', 'MAY', 'JUNE',
  'JULY', 'AUGUST', 'SEPTEMBER', 'OCTOBER', 'NOVEMBER', 'DECEMBER',
];

// Format an ISO timestamp as the page's date style, e.g. "JUNE 10, 2026".
function formatStatusDate(iso) {
  const date = new Date(iso);
  if (Number.isNaN(date.getTime())) return null;
  return `${MONTHS[date.getUTCMonth()]} ${date.getUTCDate()}, ${date.getUTCFullYear()}`;
}

// Read the Hedera status page's scheduled-maintenances payload, if provided.
function readStatusMaintenances(path) {
  if (!path) return null;
  try {
    const data = JSON.parse(fs.readFileSync(path, 'utf8'));
    return Array.isArray(data.scheduled_maintenances) ? data.scheduled_maintenances : null;
  } catch (error) {
    return null;
  }
}

// Find the upgrade-window date for a given network + version from the status
// maintenances. Matches names like "Mainnet Upgrade to v0.74" (-> 0.74.0) or
// "Testnet Upgrade to v0.74.0". Returns { date, completed } or null.
function findUpgradeDate(maintenances, network, version) {
  if (!maintenances) return null;

  const matches = [];
  for (const m of maintenances) {
    const name = m.name || '';
    if (!name.toLowerCase().includes(network.toLowerCase())) continue;
    if (!/upgrade/i.test(name)) continue;

    const versionMatch = name.match(/v?(\d+\.\d+(?:\.\d+)?)/);
    if (!versionMatch) continue;

    let found = versionMatch[1];
    if (/^\d+\.\d+$/.test(found)) found += '.0'; // normalize minor-only to X.Y.0
    if (found !== version) continue;

    const iso = m.scheduled_for || m.created_at;
    if (iso) matches.push({ iso, completed: m.status === 'completed' });
  }

  if (matches.length === 0) return null;

  // Prefer the most recent matching window.
  matches.sort((a, b) => new Date(b.iso) - new Date(a.iso));
  const date = formatStatusDate(matches[0].iso);
  return date ? { date, completed: matches[0].completed } : null;
}

// Render a network status line. Completed upgrades use <Check>/"UPDATED";
// upcoming ones use <Info>/"UPDATE". Falls back to a TODO when the status page
// has no date for this version yet.
function networkBlock(label, info) {
  if (!info) {
    return [`<Info>`, `  **${label} UPDATE: TODO**`, `</Info>`];
  }
  if (info.completed) {
    return [`<Check>`, `  **${label} UPDATED: ${info.date}**`, `</Check>`];
  }
  return [`<Info>`, `  **${label} UPDATE: ${info.date}**`, `</Info>`];
}

function buildStubMinorSection(minor, version, changelogBlock, maintenances) {
  const mainnet = findUpgradeDate(maintenances, 'Mainnet', version);
  const testnet = findUpgradeDate(maintenances, 'Testnet', version);

  return [
    `## Release v${minor}`,
    ...networkBlock('MAINNET', mainnet),
    ...networkBlock('TESTNET', testnet),
    '',
    `<!-- highlights: TODO - add a "### Release highlights" paragraph and a "What's new in Release v${minor}?" accordion above the build block -->`,
    '',
    changelogBlock,
  ].join('\n');
}

function main() {
  const args = parseArgs(process.argv);

  const version = normalizeVersion(args.version);
  const releaseJsonPath = args['release-json'];
  const target = args.target;
  // Optional: Hedera status page scheduled-maintenances JSON, used to fill in
  // mainnet/testnet upgrade dates when scaffolding a new minor section.
  const maintenances = readStatusMaintenances(args['status-json']);

  if (!releaseJsonPath || !target) {
    throw new Error(
      'Usage: node consensus-node-release-entry.js --version X.Y.Z --release-json release.json --target path/to/services.mdx [--status-json status.json]'
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

  // Idempotency: bail if this build is already documented.
  const duplicateBuildRegex = new RegExp(
    `^### \\[\\*\\*Build ${escapeRegExp(version)}\\*\\*\\]`,
    'm'
  );

  if (duplicateBuildRegex.test(existingContent)) {
    console.log(`Build ${version} already exists in ${target}. Skipping.`);
    return;
  }

  const categories = parseReleaseBody(body);

  if (categories.length === 0) {
    throw new Error(
      `No bullets parsed from release body for v${version}.\n` +
        `The upstream release body format may have changed. Review manually:\n${body.slice(0, 500)}`
    );
  }

  const changelogBlock = buildChangelogBlock(version, tagUrl, categories);

  const [major, minorPart] = version.split('.');
  const minor = `${major}.${minorPart}`;

  // Locate the "## Release vX.Y" minor section for this build.
  const sectionRegex = new RegExp(`^## Release v${escapeRegExp(minor)}\\+?\\s*$`, 'm');
  const sectionMatch = existingContent.match(sectionRegex);

  let updated;

  if (sectionMatch && sectionMatch.index !== undefined) {
    // Existing minor section: insert the build block at the top of its build
    // list, after the editorial content and before the first existing build.
    const sectionStart = sectionMatch.index + sectionMatch[0].length;
    const rest = existingContent.slice(sectionStart);

    const firstBuildInSection = rest.search(/^### \[\*\*Build /m);
    const nextMinorSection = rest.search(/^## Release v/m);

    let insertOffset;

    if (
      firstBuildInSection !== -1 &&
      (nextMinorSection === -1 || firstBuildInSection < nextMinorSection)
    ) {
      // Insert just before the first build in this section.
      insertOffset = sectionStart + firstBuildInSection;
      const insertText = `${changelogBlock}\n`;
      updated =
        existingContent.slice(0, insertOffset) + insertText + existingContent.slice(insertOffset);
    } else {
      // Section has editorial content but no builds yet (or the next thing is a
      // new minor section). Insert right after the editorial content.
      insertOffset = nextMinorSection !== -1 ? sectionStart + nextMinorSection : existingContent.length;
      const insertText = `\n${changelogBlock}\n`;
      updated =
        existingContent.slice(0, insertOffset) + insertText + existingContent.slice(insertOffset);
    }

    console.log(`Inserted Build ${version} into existing "## Release v${minor}" section.`);
  } else {
    // New minor: scaffold a stub section at the top, before the newest existing
    // "## Release v" heading.
    const firstSectionIndex = existingContent.search(/^## Release v/m);

    if (firstSectionIndex === -1) {
      throw new Error(`Could not find any "## Release v" section in ${target} to anchor the new minor section.`);
    }

    const stubSection = buildStubMinorSection(minor, version, changelogBlock, maintenances);
    updated =
      existingContent.slice(0, firstSectionIndex) +
      `${stubSection}\n\n` +
      existingContent.slice(firstSectionIndex);

    console.log(
      `Created stub "## Release v${minor}" section for new minor release and inserted Build ${version}. ` +
        `Mainnet/testnet dates pulled from the status page when available; release highlights are left TODO for manual completion.`
    );
  }

  writeFile(target, updated);

  const totalBullets = categories.reduce((sum, category) => sum + category.bullets.length, 0);
  console.log(
    `Wrote Build ${version} to ${target} (${totalBullets} bullets across ${categories.length} categories).`
  );
}

try {
  main();
} catch (error) {
  console.error(`ERROR: ${error.message}`);
  process.exit(1);
}
