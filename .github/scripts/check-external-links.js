#!/usr/bin/env node
// Check every external link in the docs and report the ones that are broken
// or that redirect somewhere else.
//
// Why this exists: `mint broken-links` only validates internal links. External
// links rot silently: a provider moves its docs, a site is retired, or a URL
// starts redirecting to something unrelated (one /support redirect ended up
// downloading a zip file). This runs on a schedule so rot shows up as a
// failed check instead of a reader bug report.
//
// What it checks:
//   - http(s) links in .mdx files (markdown links, href attributes, autolinks,
//     and the `url:` front matter used by external nav pages)
//   - external redirect destinations in docs.json
// What it skips:
//   - networks/release-notes/ (historical record, left as published)
//   - pages with `hidden: true` in front matter (out of nav, parked pending
//     a rewrite or removal)
//   - fenced code blocks and inline code (endpoints and samples, not links)
//   - placeholders (<YOUR_API_KEY>, ${VAR}, {id}) and localhost URLs
//   - patterns listed in .github/link-check-ignore.txt
//
// Results:
//   broken      4xx (except 401/403/405/429), DNS or connection failure.
//               These fail the run.
//   redirected  resolves, but to a different URL than the one in the docs.
//               Reported, does not fail the run.
//   unverified  401/403/405/429, a 5xx that persists after retries, or a
//               non-standard status: the site blocks automated requests,
//               needs auth, or is having an outage, so a person has to check.
//               Reported, does not fail the run.
//
// Requests are paced per host (GitHub answers bursts with 429/503), and 429,
// 502, 503 and 504 are retried with backoff before a result is recorded.
//
// Usage: node --max-http-header-size=81920 .github/scripts/check-external-links.js [--fail-on=broken|none]
// The larger header limit is needed for YouTube and Google, whose response
// headers exceed Node's 16 KB default (fetch fails with UND_ERR_HEADERS_OVERFLOW).
// Writes a markdown report to $GITHUB_STEP_SUMMARY when set, else to stdout.

'use strict';

const fs = require('fs');
const path = require('path');
const { execFileSync } = require('child_process');

const ROOT = path.resolve(__dirname, '..', '..');
const IGNORE_FILE = path.join(ROOT, '.github', 'link-check-ignore.txt');
const EXCLUDED_DIRS = ['networks/release-notes/'];
const CONCURRENCY = 12;
const PER_HOST = { 'github.com': 2, 'raw.githubusercontent.com': 2 };
const PER_HOST_DEFAULT = 4;
const RETRY_STATUSES = [429, 502, 503, 504];
const RETRY_DELAYS_MS = [3000, 10000, 30000];
const TIMEOUT_MS = 20000;
const MAX_REDIRECTS = 10;
const USER_AGENT =
  'Mozilla/5.0 (Macintosh; Intel Mac OS X 14_0) AppleWebKit/605.1.15 ' +
  '(KHTML, like Gecko) Version/17.0 Safari/605.1.15';

const failOn = (process.argv.find((a) => a.startsWith('--fail-on=')) || '--fail-on=broken').split('=')[1];

function loadIgnorePatterns() {
  if (!fs.existsSync(IGNORE_FILE)) return [];
  return fs
    .readFileSync(IGNORE_FILE, 'utf8')
    .split(/\r?\n/)
    .map((l) => l.trim())
    .filter((l) => l && !l.startsWith('#'))
    .map((l) => new RegExp(l, 'i'));
}

function listMdxFiles() {
  const out = execFileSync('git', ['ls-files', '*.mdx'], { cwd: ROOT, encoding: 'utf8' });
  return out
    .split('\n')
    .filter(Boolean)
    .filter((f) => !EXCLUDED_DIRS.some((d) => f.startsWith(d)));
}

// Replace code with spaces of the same length so line numbers stay correct.
function blankCode(text) {
  const blank = (m) => m.replace(/[^\n]/g, ' ');
  return text.replace(/(^|\n)(\s*)(```|~~~)[\s\S]*?\n\s*\3[^\n]*/g, blank).replace(/`[^`\n]*`/g, blank);
}

const LINK_PATTERNS = [
  /\]\(\s*<?(https?:\/\/[^)\s>]+)>?(?:\s+"[^"]*")?\s*\)/g, // [text](url) and [text](<url> "title")
  /href\s*=\s*["'{]\s*["']?(https?:\/\/[^"'}\s]+)/g, // href="url" and href={"url"}
  /<(https?:\/\/[^>\s]+)>/g, // <url> autolinks
  /^url:\s*["']?(https?:\/\/[^"'\s]+)/gm, // front matter url: on external nav pages
];

function cleanUrl(raw) {
  return raw
    .replace(/&#x26;|&#38;|&amp;/gi, '&')
    .replace(/[.,;:!?*]+$/, '');
}

function isPlaceholder(url) {
  return (
    /[<>{}$]|YOUR_|%3CYOUR/i.test(url) ||
    /^https?:\/\/(localhost|127\.0\.0\.1|0\.0\.0\.0|\[::1\])([:/]|$)/i.test(url) ||
    /^https?:\/\/([^/]*\.)?(example\.(com|org|net))([:/]|$)/i.test(url)
  );
}

function isHidden(text) {
  const fm = text.match(/^---\r?\n([\s\S]*?)\r?\n---/);
  return Boolean(fm && /^hidden:\s*true\s*$/m.test(fm[1]));
}

const skippedHidden = [];

function collectLinks(ignore) {
  const links = new Map(); // url -> Set("file:line")
  const add = (url, where) => {
    url = cleanUrl(url);
    if (isPlaceholder(url) || ignore.some((re) => re.test(url))) return;
    if (!links.has(url)) links.set(url, new Set());
    links.get(url).add(where);
  };

  for (const file of listMdxFiles()) {
    const source = fs.readFileSync(path.join(ROOT, file), 'utf8');
    if (isHidden(source)) {
      skippedHidden.push(file);
      continue;
    }
    const text = blankCode(source);
    for (const re of LINK_PATTERNS) {
      re.lastIndex = 0;
      let m;
      while ((m = re.exec(text))) {
        const line = text.slice(0, m.index).split('\n').length;
        add(m[1], `${file}:${line}`);
      }
    }
  }

  const docsJson = JSON.parse(fs.readFileSync(path.join(ROOT, 'docs.json'), 'utf8'));
  for (const r of docsJson.redirects || []) {
    if (/^https?:\/\//.test(r.destination) && !r.destination.includes(':slug')) {
      add(r.destination, `docs.json redirect ${r.source}`);
    }
  }
  return links;
}

// Two URLs count as the same page if they differ only in scheme upgrade,
// host case, a leading "www.", a trailing slash, or the fragment.
function normalize(url) {
  try {
    const u = new URL(url);
    const host = u.hostname.toLowerCase().replace(/^www\./, '');
    const p = u.pathname.replace(/\/+$/, '') || '/';
    return `${host}${p}${u.search}`;
  } catch {
    return url;
  }
}

const hostSlots = new Map(); // host -> { active, queue }

async function withHostSlot(url, fn) {
  const host = new URL(url).hostname.toLowerCase();
  const limit = PER_HOST[host] || PER_HOST_DEFAULT;
  if (!hostSlots.has(host)) hostSlots.set(host, { active: 0, queue: [] });
  const slot = hostSlots.get(host);
  if (slot.active >= limit) await new Promise((resolve) => slot.queue.push(resolve));
  slot.active++;
  try {
    return await fn();
  } finally {
    slot.active--;
    const nextWaiter = slot.queue.shift();
    if (nextWaiter) nextWaiter();
  }
}

const sleep = (ms) => new Promise((resolve) => setTimeout(resolve, ms));

async function requestOnce(url) {
  const controller = new AbortController();
  const timer = setTimeout(() => controller.abort(), TIMEOUT_MS);
  try {
    const res = await fetch(url, {
      method: 'GET',
      redirect: 'manual',
      signal: controller.signal,
      headers: { 'User-Agent': USER_AGENT, Accept: 'text/html,application/xhtml+xml,*/*;q=0.8' },
    });
    if (res.body) res.body.cancel().catch(() => {});
    return res;
  } finally {
    clearTimeout(timer);
  }
}

// One request, paced per host, retried with backoff on rate limits, momentary
// server errors, timeouts and resets. Throws only if every attempt threw.
async function request(url) {
  let lastError;
  for (let attempt = 0; attempt <= RETRY_DELAYS_MS.length; attempt++) {
    try {
      const res = await withHostSlot(url, () => requestOnce(url));
      if (!RETRY_STATUSES.includes(res.status) || attempt === RETRY_DELAYS_MS.length) return res;
      const retryAfter = Number(res.headers.get('retry-after'));
      await sleep(Number.isFinite(retryAfter) && retryAfter > 0 ? Math.min(retryAfter * 1000, 60000) : RETRY_DELAYS_MS[attempt]);
    } catch (err) {
      lastError = err;
      if (attempt === RETRY_DELAYS_MS.length) break;
      await sleep(RETRY_DELAYS_MS[attempt]);
    }
  }
  throw lastError;
}

// Fragments are never sent to the server, so carry the original one over to
// the final URL. Otherwise "update to the final URL" would drop the anchor.
function withFragment(final, original) {
  const hash = original.includes('#') ? original.slice(original.indexOf('#')) : '';
  return hash && !final.includes('#') ? final + hash : final;
}

async function check(url) {
  const result = await follow(url);
  return { ...result, final: withFragment(result.final, url) };
}

async function follow(url) {
  let current = url;
  for (let hop = 0; hop <= MAX_REDIRECTS; hop++) {
    let res;
    try {
      res = await request(current);
    } catch (err) {
      const cause = (err && err.cause && (err.cause.code || err.cause.message)) || (err && err.name) || 'error';
      return { status: 'broken', code: cause, final: current };
    }
    if (res.status >= 300 && res.status < 400 && res.headers.get('location')) {
      current = new URL(res.headers.get('location'), current).toString();
      continue;
    }
    const code = res.status;
    if (code >= 200 && code < 300) {
      const moved = normalize(current) !== normalize(url);
      return { status: moved ? 'redirected' : 'ok', code, final: current };
    }
    if ([401, 403, 405, 429].includes(code) || code >= 500 || code < 100) {
      return { status: 'unverified', code, final: current };
    }
    return { status: 'broken', code, final: current };
  }
  return { status: 'broken', code: 'too many redirects', final: current };
}

async function runPool(items, worker) {
  const results = new Array(items.length);
  let next = 0;
  const lanes = Array.from({ length: Math.min(CONCURRENCY, items.length) }, async () => {
    while (next < items.length) {
      const i = next++;
      results[i] = await worker(items[i]);
    }
  });
  await Promise.all(lanes);
  return results;
}

function formatWhere(set, max = 5) {
  const all = [...set].sort();
  const shown = all.slice(0, max).map((w) => `\`${w}\``).join('<br>');
  return all.length > max ? `${shown}<br>…and ${all.length - max} more` : shown;
}

function escapeCell(s) {
  return String(s).replace(/\\/g, '\\\\').replace(/\|/g, '\\|');
}

async function main() {
  const ignore = loadIgnorePatterns();
  const links = collectLinks(ignore);
  const urls = [...links.keys()].sort();
  const results = await runPool(urls, check);

  const rows = { broken: [], redirected: [], unverified: [] };
  urls.forEach((url, i) => {
    const r = results[i];
    if (r.status !== 'ok') rows[r.status].push({ url, ...r, where: links.get(url) });
  });

  const lines = [];
  lines.push('# External link check', '');
  lines.push(
    `Checked ${urls.length} unique external URLs: ` +
      `${rows.broken.length} broken, ${rows.redirected.length} redirected, ` +
      `${rows.unverified.length} unverified.`,
    ''
  );
  if (skippedHidden.length) {
    lines.push(`Skipped ${skippedHidden.length} hidden page(s): ${skippedHidden.map((f) => `\`${f}\``).join(', ')}`, '');
  }

  if (rows.broken.length) {
    lines.push('## Broken', '', '| URL | Result | Found in |', '|---|---|---|');
    for (const r of rows.broken) lines.push(`| ${escapeCell(r.url)} | ${escapeCell(r.code)} | ${formatWhere(r.where)} |`);
    lines.push('');
  }
  if (rows.redirected.length) {
    lines.push('## Redirected', '', 'Update these to the final URL, after checking it is still the right page.', '');
    lines.push('| URL | Now resolves to | Found in |', '|---|---|---|');
    for (const r of rows.redirected) lines.push(`| ${escapeCell(r.url)} | ${escapeCell(r.final)} | ${formatWhere(r.where)} |`);
    lines.push('');
  }
  if (rows.unverified.length) {
    lines.push('## Unverified', '', 'These sites block automated requests or need auth. Check them in a browser.', '');
    lines.push('<details><summary>Show unverified URLs</summary>', '', '| URL | Status | Found in |', '|---|---|---|');
    for (const r of rows.unverified) lines.push(`| ${escapeCell(r.url)} | ${escapeCell(r.code)} | ${formatWhere(r.where, 2)} |`);
    lines.push('', '</details>', '');
  }

  const report = lines.join('\n');
  if (process.env.GITHUB_STEP_SUMMARY) fs.appendFileSync(process.env.GITHUB_STEP_SUMMARY, report + '\n');
  console.log(report);

  for (const r of rows.broken) {
    const first = [...r.where][0] || '';
    const m = first.match(/^(.+\.mdx):(\d+)$/);
    const loc = m ? ` file=${m[1]},line=${m[2]}` : '';
    console.log(`::error${loc}::Broken external link ${r.url} (${r.code})`);
  }

  if (failOn === 'broken' && rows.broken.length) process.exit(1);
}

main().catch((err) => {
  console.error(err);
  process.exit(2);
});
