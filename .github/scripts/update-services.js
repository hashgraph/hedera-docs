#!/usr/bin/env node
/**
 * Robust update-services.js
 * Fetch all releases from GitHub, diff against services.md, and insert missing builds.
 * Supports pagination, dry-run, verbose, backups, and error handling.
 * Ensures sections and builds are ordered descending, removes duplicate headers,
 * cleans up bullet formatting, and collapses excess blank lines.
 *
 * Usage:
 *   CONSENSUS_TOKEN=ghp_xxx node update-services.js --md-path path/to/services.md [--dry-run] [--verbose] [--include-prereleases]
 */

const https = require("https");
const fs = require("fs");
const path = require("path");
const os = require("os");
const { spawnSync } = require("child_process");

// Parse CLI arguments
const args = process.argv.slice(2).reduce((acc, cur, idx, arr) => {
  if (cur.startsWith("--")) {
    const key = cur.slice(2);
    const next = arr[idx + 1];
    acc[key] = next && !next.startsWith("--") ? next : true;
  }
  return acc;
}, {});

const mdPath = args["md-path"];
const dryRun = Boolean(args["dry-run"]);
const verbose = Boolean(args["verbose"]);
const includePrereleases = Boolean(args["include-prereleases"]);
const token = process.env.CONSENSUS_TOKEN;

function log(...msgs) {
  if (verbose) console.log("[verbose]", ...msgs);
}

if (!mdPath) {
  console.error("error: missing --md-path");
  process.exit(1);
}
if (!token) {
  console.error("error: missing CONSENSUS_TOKEN env var");
  process.exit(1);
}

// Semver compare: a > b => 1, a < b => -1, equal => 0
function compareVersions(a, b) {
  const pa = a.split(".").map(Number);
  const pb = b.split(".").map(Number);
  for (let i = 0; i < Math.max(pa.length, pb.length); i++) {
    const na = pa[i] || 0;
    const nb = pb[i] || 0;
    if (na > nb) return 1;
    if (na < nb) return -1;
  }
  return 0;
}

// Fetch a single page of releases
function fetchPage(page, per_page = 100) {
  const options = {
    hostname: "api.github.com",
    path: `/repos/hiero-ledger/hiero-consensus-node/releases?per_page=${per_page}&page=${page}`,
    method: "GET",
    headers: {
      "User-Agent": "node.js",
      Authorization: `token ${token}`,
      Accept: "application/vnd.github.v3+json",
    },
  };
  return new Promise((resolve, reject) => {
    const req = https.request(options, (res) => {
      let data = "";
      res.on("data", (chunk) => (data += chunk));
      res.on("end", () => {
        if (res.statusCode >= 200 && res.statusCode < 300) {
          try {
            const parsedData = JSON.parse(data);
            resolve({ data: parsedData, headers: res.headers });
          } catch (e) {
            reject(new Error("Invalid JSON from GitHub"));
          }
        } else {
          reject(new Error(`GitHub API ${res.statusCode}: ${data}`));
        }
      });
    });
    req.on("error", reject);
    req.end();
  });
}

// Fetch all releases with pagination
async function fetchAllReleases() {
  let page = 1;
  const all = [];
  while (true) {
    log(`fetching page ${page}`);
    const { data: list, headers } = await fetchPage(page);
    if (!Array.isArray(list) || list.length === 0) break;
    all.push(...list);
    const linkHeader = headers.link;
    if (linkHeader && linkHeader.includes('rel="next"')) {
      page++;
    } else {
      break;
    }
  }
  return all.filter((r) => r.tag_name && (includePrereleases || !r.prerelease));
}

// Build markdown snippet for a release, cleaning up headings
function buildSnippet(release) {
  const version = release.tag_name;
  const url = release.html_url;
  // remove any "What's Changed" headings
  const raw = (release.body || "").split(/\r?\n/);
  const cleaned = raw
    .filter((line) => !/^#+\s*what'?s changed\s*$/i.test(line))
    .map((line) => line.trim())
    .filter((line) => line);
  const bulletized = cleaned.map((line) => `* ${line}`).join("\n");
  const [major, minor] = version.replace(/^v/, "").split(".");
  return `### [Build ${version}](${url})

<details>
<summary><strong>What's Changed</strong></summary>

${bulletized}

**Full Changelog**: [v${major}.${minor}.0...${version}](https://github.com/hiero-ledger/hiero-consensus-node/compare/v${major}.${minor}.0...${version})

</details>
`;
}

// Insert snippet into content under the correct section
function insertSnippet(content, snippet, version) {
  const [major, minor] = version.replace(/^v/, "").split(".");
  const header = `## Release v${major}.${minor}`;
  const regex = new RegExp(
    `(${header}[\s\S]*?)(?=(## Release v\\d+\\.\\d+|$))`
  );
  if (regex.test(content)) {
    return content.replace(
      regex,
      `$1

${snippet}`
    );
  }
  return (
    content.trimEnd() +
    `

${header}

${snippet}`
  );
}

// Sort build blocks within a section descending, join with two newlines
function sortSectionBuilds(sectionText) {
  const marker = "### [Build ";
  const idx = sectionText.indexOf(marker);
  if (idx === -1) return sectionText;
  const prefix = sectionText.slice(0, idx).trimEnd();
  const buildsText = sectionText.slice(idx);
  const blocks = buildsText
    .split(/(?=### \[Build )/g)
    .map((b) => b.trim())
    .filter((b) => b);
  blocks.sort((a, b) => {
    const va = a.match(/### \[Build v?(.*?)\]/)[1];
    const vb = b.match(/### \[Build v?(.*?)\]/)[1];
    return compareVersions(vb, va);
  });
  return `${prefix}

${blocks.join("\n\n")}`;
}

// Reorder and merge all sections descending by version, then sort builds
function reorderSections(content) {
  const splitRegex = /(?=^## Release v\d+\.\d+)/m;
  const parts = content.split(splitRegex);
  const header = parts.shift();

  const map = new Map();
  parts.forEach((sec) => {
    const m = sec.match(/^## Release v(\d+\.\d+)/);
    if (!m) return;
    const ver = m[1];
    const trimmed = sec.trim();
    if (!map.has(ver)) map.set(ver, trimmed);
    else {
      const body = trimmed.replace(/^## Release v\d+\.\d+/, "").trim();
      if (body) map.set(ver, map.get(ver) + "\n\n" + body);
    }
  });

  const sorted = Array.from(map.keys()).sort((a, b) => compareVersions(b, a));

  let out = header.trimEnd() + "\n";
  sorted.forEach((ver) => {
    let sec = map.get(ver);
    sec = sortSectionBuilds(sec);
    out += sec + "\n\n";
  });

  return out.trimEnd().replace(/\n{3,}/g, "\n\n");
}

(async () => {
  const filePath = path.resolve(mdPath);
  if (!fs.existsSync(filePath)) {
    console.error(`error: file not found at ${filePath}`);
    process.exit(1);
  }
  const backup = `${filePath}.${Date.now()}.bak`;
  fs.copyFileSync(filePath, backup);
  log(`backup created at ${backup}`);

  let content = fs.readFileSync(filePath, "utf8");
  const existing = content
    .split(/\r?\n/)
    .filter((line) => line.startsWith("### [Build "))
    .map((line) => line.match(/\[Build v?(.*?)\]/)[1]);

  let releases;
  try {
    releases = await fetchAllReleases();
  } catch (err) {
    console.error("error fetching releases:", err.message);
    process.exit(1);
  }

  const fetched = releases.map((r) => r.tag_name.replace(/^v/, ""));
  const missing = [...new Set(fetched)]
    .filter((v) => !existing.includes(v))
    .sort(compareVersions)
    .reverse();

  if (!missing.length) {
    console.log("✅ no missing builds to insert");
    return;
  }

  missing.forEach((ver) => {
    const rel = releases.find((r) => r.tag_name.replace(/^v/, "") === ver);
    if (!rel) return;
    content = insertSnippet(content, buildSnippet(rel), ver);
    console.log(`inserted build v${ver}`);
  });

  content = reorderSections(content);
  log("sections and builds reordered, cleaned");

  if (dryRun) {
    const tmp = path.join(os.tmpdir(), "services.tmp.md");
    fs.writeFileSync(tmp, content, "utf8");
    const diff = spawnSync("diff", ["-u", backup, tmp], { encoding: "utf8" });
    console.log(diff.stdout || "no differences");
    fs.unlinkSync(tmp);
    return;
  }

  try {
    fs.writeFileSync(filePath, content, "utf8");
    console.log(`✅ updated with builds: ${missing.join(", ")}`);
  } catch (err) {
    console.error("error writing file:", err.message);
    process.exit(1);
  }
})();
