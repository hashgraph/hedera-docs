// Shared helpers for the SDK docs sync scripts (sdk-sync.js, sdk-coverage.js,
// sdk-draft-docs.js): GitHub access, release lookup, and the docs index used to
// check whether an SDK class or method is mentioned in the docs.

'use strict';

const fs = require('fs');
const path = require('path');

const ROOT = path.resolve(__dirname, '../../..');
// Historical changelogs and generated API references are never edited or scanned.
const EXCLUDED_PATHS = new Set(['node_modules', '.git', 'networks/release-notes', 'reference']);
const STABLE_TAG = /^v?(\d+)\.(\d+)\.(\d+)$/;

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

function compareVersions(a, b) {
  const pa = a.split('.').map(Number);
  const pb = b.split('.').map(Number);
  for (let i = 0; i < 3; i++) {
    if (pa[i] !== pb[i]) return pa[i] - pb[i];
  }
  return 0;
}

function normalize(identifier) {
  return identifier.toLowerCase().replace(/_/g, '');
}

function setOutput(values) {
  if (!process.env.GITHUB_OUTPUT) return;
  const lines = Object.entries(values).map(([key, value]) => `${key}=${value}`);
  fs.appendFileSync(process.env.GITHUB_OUTPUT, lines.join('\n') + '\n');
}

// ── GitHub ────────────────────────────────────────────────────────────────

async function gh(endpoint) {
  const headers = { Accept: 'application/vnd.github+json', 'User-Agent': 'hedera-docs-sdk-sync' };
  if (process.env.GH_TOKEN) headers.Authorization = `Bearer ${process.env.GH_TOKEN}`;

  const res = await fetch(`https://api.github.com/${endpoint}`, { headers });
  if (!res.ok) throw new Error(`GET ${endpoint} failed: ${res.status} ${await res.text()}`);
  return res.json();
}

async function rawFile(repo, tag, file) {
  const res = await fetch(`https://raw.githubusercontent.com/${repo}/${tag}/${file}`);
  if (res.status === 404) return null;
  if (!res.ok) throw new Error(`Fetching ${repo}@${tag}:${file} failed: ${res.status}`);
  return res.text();
}

async function mapLimit(items, limit, fn) {
  const results = new Array(items.length);
  let next = 0;
  const workers = Array.from({ length: Math.min(limit, items.length) }, async () => {
    while (next < items.length) {
      const i = next++;
      results[i] = await fn(items[i]);
    }
  });
  await Promise.all(workers);
  return results;
}

// Stable releases only (no drafts, prereleases, or suffixed tags), oldest first.
async function stableReleases(repo) {
  const releases = [];

  for (let page = 1; page <= 5; page++) {
    const batch = await gh(`repos/${repo}/releases?per_page=100&page=${page}`);
    releases.push(...batch);
    if (batch.length < 100) break;
  }

  return releases
    .filter(r => !r.draft && !r.prerelease && STABLE_TAG.test(r.tag_name))
    .map(r => ({
      tag: r.tag_name,
      version: r.tag_name.replace(/^v/, ''),
      url: r.html_url,
      date: (r.published_at || '').slice(0, 10),
      body: r.body || '',
    }))
    .sort((a, b) => compareVersions(a.version, b.version));
}

async function sourceTree(repo, tag) {
  return gh(`repos/${repo}/git/trees/${encodeURIComponent(tag)}?recursive=1`);
}

// Public Transaction/Query classes at a tag: className -> { path, sha }.
async function classInventory(sdk, tag) {
  const tree = await sourceTree(sdk.repo, tag);
  const classes = new Map();

  for (const entry of tree.tree) {
    if (entry.type !== 'blob') continue;
    const match = entry.path.match(sdk.classFile);
    if (!match) continue;
    const name = sdk.className ? sdk.className(match[1]) : match[1];
    classes.set(name, { path: entry.path, sha: entry.sha });
  }

  return { classes, truncated: tree.truncated, paths: tree.tree.filter(e => e.type === 'blob').map(e => e.path) };
}

// APIs that should never be reported or drafted (.github/sdk-sync/ignore.json).
// Method entries match by "name", or by "contains" for a whole family across SDKs
// (for example every hook method, whatever each SDK calls it). A method entry with
// "class" applies to that class only.
function loadIgnore() {
  const ignore = JSON.parse(fs.readFileSync(path.join(ROOT, '.github/sdk-sync/ignore.json'), 'utf8'));
  const classes = new Set((ignore.classes || []).map(entry => normalize(entry.name)));
  const rules = (ignore.methods || []).map(entry => ({
    name: entry.name && normalize(entry.name),
    contains: entry.contains && normalize(entry.contains),
    cls: entry.class && normalize(entry.class),
  }));
  return {
    isClassIgnored: name => classes.has(normalize(name)),
    isMethodIgnored: (name, className) =>
      rules.some(
        rule =>
          (!rule.cls || (className && rule.cls === normalize(className))) &&
          ((rule.name && rule.name === normalize(name)) || (rule.contains && normalize(name).includes(rule.contains)))
      ),
  };
}

// ── Docs index ────────────────────────────────────────────────────────────

function listFiles(dir = ROOT, rel = '') {
  const files = [];

  for (const entry of fs.readdirSync(dir, { withFileTypes: true })) {
    const relPath = rel ? `${rel}/${entry.name}` : entry.name;
    if (EXCLUDED_PATHS.has(relPath) || entry.name.startsWith('.')) continue;

    if (entry.isDirectory()) {
      files.push(...listFiles(path.join(dir, entry.name), relPath));
    } else if (entry.name.endsWith('.mdx')) {
      files.push(relPath);
    }
  }

  return files;
}

function identifierCounts(text) {
  const counts = new Map();
  for (const [token] of text.matchAll(/[A-Za-z_][A-Za-z0-9_]*/g)) {
    const key = normalize(token);
    counts.set(key, (counts.get(key) || 0) + 1);
  }
  return counts;
}

// page -> { text, tokens, headingTokens, isReference }
function buildDocsIndex(pages) {
  const index = new Map();

  for (const page of pages) {
    const text = fs.readFileSync(path.join(ROOT, page), 'utf8');
    const headings = text.match(/^#{1,4}\s.*$/gm) || [];
    index.set(page, {
      text,
      tokens: identifierCounts(text),
      headingTokens: identifierCounts(headings.join('\n')),
      // SDK reference pages carry a Constructor/Methods table; tutorials do not.
      isReference: headings.some(h => /^#+\s+(Methods|Constructor)\b/.test(h)),
    });
  }

  return index;
}

// SDK reference pages live under native/, outside the tutorials.
function isNativeReferencePath(page) {
  return page.startsWith('native/') && !page.startsWith('native/tutorials/');
}

// Whether a page actually documents a class rather than mentioning it in passing:
// it is named after the class, has a heading naming it, constructs it in code, or
// carries a methods table and mentions the class more than once.
function documentsClass(name, page, className) {
  const key = normalize(className);
  return (
    path.basename(name, '.mdx').replace(/-/g, '') === key ||
    page.headingTokens.has(key) ||
    page.text.includes(`new ${className}(`) ||
    page.text.includes(`New${className}(`) ||
    page.text.includes(`${className}::new(`) ||
    (page.isReference && page.tokens.get(key) > 1)
  );
}

// Pages mentioning an identifier, likely reference page first: a file named after the
// class beats a heading naming it, which beats code constructing it, which beats a
// method table (only when the class appears more than in passing), which beats
// living under native/, which beats raw mentions.
function pagesMentioning(index, identifier) {
  const key = normalize(identifier);
  const fileKey = name => path.basename(name, '.mdx').replace(/-/g, '');
  const constructs = text =>
    text.includes(`new ${identifier}(`) || text.includes(`New${identifier}(`) || text.includes(`${identifier}::new(`);
  const score = (name, page) =>
    (fileKey(name) === key ? 800 : 0) +
    (page.headingTokens.has(key) ? 400 : 0) +
    (constructs(page.text) ? 300 : 0) +
    (page.isReference && page.tokens.get(key) > 1 ? 200 : 0) +
    (isNativeReferencePath(name) ? 100 : 0) +
    Math.min(page.tokens.get(key), 99);

  return [...index.entries()]
    .filter(([, page]) => page.tokens.has(key))
    .sort((a, b) => score(b[0], b[1]) - score(a[0], a[1]))
    .map(([name]) => name);
}

// Method names differ by SDK (setTokenName, SetTokenName, set_token_name, tokenName),
// so a method counts as documented if any accessor-style variant appears on the page.
function methodDocumented(index, pages, method) {
  const base = normalize(method).replace(/^(set|get)(?=.)/, '');
  const variants = [normalize(method), base, `set${base}`, `get${base}`];
  return pages.some(page => variants.some(v => index.get(page).tokens.has(v)));
}

module.exports = {
  ROOT,
  STABLE_TAG,
  parseArgs,
  compareVersions,
  normalize,
  setOutput,
  gh,
  rawFile,
  mapLimit,
  stableReleases,
  sourceTree,
  classInventory,
  loadIgnore,
  listFiles,
  buildDocsIndex,
  isNativeReferencePath,
  documentsClass,
  pagesMentioning,
  methodDocumented,
};
