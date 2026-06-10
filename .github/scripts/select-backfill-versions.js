#!/usr/bin/env node
// Determines which upstream releases are missing from the release-notes page.
// Prints the missing stable versions newer than the latest documented one,
// oldest-first, one per line. The caller adds them in that order so the newest
// ends up at the top of the page.
//
// Works for both page styles:
//   - mirror node:    "## [v0.155.1](...)"
//   - consensus node: "### [**Build 0.74.0**](...)"
//
// Usage:
// node select-backfill-versions.js --target path/to/notes.mdx --releases releases.json
//
// releases.json is the output of:
//   gh release list --repo <repo> --exclude-pre-releases --exclude-drafts --json tagName

'use strict';

const fs = require('fs');

// Matches the newest documented version in either heading style.
const HEADING_REGEX = /^(?:## \[v|### \[\*\*Build )(\d+\.\d+\.\d+)\b/m;

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

function normalizeVersion(tag) {
  return String(tag || '').trim().replace(/^v/i, '');
}

// Only stable X.Y.Z releases — drop anything with a prerelease suffix.
function isStable(version) {
  return /^\d+\.\d+\.\d+$/.test(version);
}

function compareVersions(a, b) {
  const pa = a.split('.').map(Number);
  const pb = b.split('.').map(Number);

  for (let i = 0; i < 3; i += 1) {
    if (pa[i] !== pb[i]) return pa[i] - pb[i];
  }

  return 0;
}

function main() {
  const args = parseArgs(process.argv);
  const target = args.target;
  const releasesPath = args.releases;

  if (!target || !releasesPath) {
    throw new Error(
      'Usage: node select-backfill-versions.js --target path/to/notes.mdx --releases releases.json'
    );
  }

  const content = fs.readFileSync(target, 'utf8');

  // The latest documented version is the first version heading on the page.
  const headingMatch = content.match(HEADING_REGEX);
  if (!headingMatch) {
    throw new Error(`Could not find a documented version heading in ${target}.`);
  }
  const documentedLatest = headingMatch[1];

  let releases;
  try {
    releases = JSON.parse(fs.readFileSync(releasesPath, 'utf8'));
  } catch (error) {
    throw new Error(`Could not parse releases JSON from "${releasesPath}": ${error.message}`);
  }

  if (!Array.isArray(releases)) {
    throw new Error(`Expected releases JSON to be an array, got ${typeof releases}.`);
  }

  const missing = releases
    .map(release => normalizeVersion(release.tagName))
    .filter(isStable)
    .filter(version => compareVersions(version, documentedLatest) > 0)
    .sort(compareVersions); // oldest first

  for (const version of missing) {
    console.log(version);
  }
}

try {
  main();
} catch (error) {
  console.error(`ERROR: ${error.message}`);
  process.exit(1);
}
