#!/usr/bin/env python3
"""
Audit inbound docs links from hedera.com (or any external site) against:
  1. docs.json `redirects` (with :slug* wildcard support)
  2. Actual .mdx files on disk in this repo

Reports each inbound URL as one of:
  OK_FILE       — resolves directly to an .mdx file
  OK_REDIRECT   — matches a redirect rule in docs.json
  BROKEN        — would 404 (no file, no redirect match)

Three input modes:
  --crawl URL        Crawl a live site for links to docs.hedera.com
  --grep DIR         Grep a local checkout (hedera.com repo) for docs links
  --file PATH        Read a newline-delimited list of URLs from a file

Usage examples:
  ./audit-inbound-links.py --crawl https://hedera.com --depth 2
  ./audit-inbound-links.py --grep ../hedera.com
  ./audit-inbound-links.py --file inbound-links.txt
  ./audit-inbound-links.py --file -          # read from stdin

Output: a table on stdout, plus exit 1 if any BROKEN entries are found.
Add --json for machine-readable output.
"""

from __future__ import annotations

import argparse
import json
import os
import re
import subprocess
import sys
import urllib.parse
import urllib.request
from collections import deque
from html.parser import HTMLParser
from pathlib import Path

DOCS_HOST = "docs.hedera.com"
REPO_ROOT = Path(__file__).resolve().parent.parent
DOCS_JSON = REPO_ROOT / "docs.json"


# ── Path classification ─────────────────────────────────────────────────────

def load_redirects() -> list[tuple[re.Pattern, str]]:
    """Compile each docs.json redirect source into a regex."""
    with open(DOCS_JSON) as f:
        cfg = json.load(f)
    compiled = []
    for entry in cfg.get("redirects", []):
        src = entry["source"]
        dst = entry["destination"]
        # Convert Mintlify-style `:slug*` (greedy wildcard) and `:slug` (single segment)
        # into anchored regex patterns. After re.escape, `:slug*` becomes `:slug\*`
        # (colon is NOT escaped; only `*` is), so match the escaped form.
        pattern = re.escape(src)
        pattern = re.sub(r":[a-zA-Z_]+\\\*", ".*", pattern)   # :slug* -> .*
        pattern = re.sub(r":[a-zA-Z_]+", "[^/]+", pattern)    # :slug  -> single segment
        compiled.append((re.compile(f"^{pattern}/?$"), dst))
    return compiled


def file_exists_for_path(url_path: str) -> bool:
    """Return True if url_path maps to an .mdx file on disk."""
    p = url_path.strip("/").split("?")[0].split("#")[0]
    if not p:
        p = "index"
    candidates = [
        REPO_ROOT / f"{p}.mdx",
        REPO_ROOT / p / "index.mdx",
    ]
    return any(c.exists() for c in candidates)


def classify(url_path: str, redirects: list[tuple[re.Pattern, str]]) -> tuple[str, str]:
    """Return (status, detail) for a single docs.hedera.com path.

    Order:
      1. Legacy `/hedera/...` paths: prefer a redirect match over the on-disk file,
         since the `hedera/` directory is being phased out by the revamp.
      2. Everything else: prefer file on disk, fall back to redirect, else BROKEN.
    """
    clean = url_path.split("?")[0].split("#")[0]
    is_legacy = clean.startswith("/hedera/") or clean == "/hedera"

    if is_legacy:
        for pattern, dst in redirects:
            if pattern.match(clean):
                return ("OK_REDIRECT", f"→ {dst}")
        if file_exists_for_path(clean):
            return ("OK_FILE", f"{clean} (legacy, no redirect — add one!)")
        return ("BROKEN", clean)

    if file_exists_for_path(clean):
        return ("OK_FILE", clean)
    for pattern, dst in redirects:
        if pattern.match(clean):
            return ("OK_REDIRECT", f"→ {dst}")
    return ("BROKEN", clean)


# ── Input modes ─────────────────────────────────────────────────────────────

class LinkExtractor(HTMLParser):
    def __init__(self) -> None:
        super().__init__()
        self.hrefs: list[str] = []

    def handle_starttag(self, tag: str, attrs: list[tuple[str, str | None]]) -> None:
        if tag != "a":
            return
        for k, v in attrs:
            if k == "href" and v:
                self.hrefs.append(v)


def crawl(start_url: str, depth: int, same_host_only: bool = True) -> set[str]:
    """BFS crawl, collecting absolute URLs that point at docs.hedera.com."""
    parsed_start = urllib.parse.urlparse(start_url)
    start_host = parsed_start.netloc
    seen_pages: set[str] = set()
    docs_links: set[str] = set()
    queue: deque[tuple[str, int]] = deque([(start_url, 0)])

    while queue:
        url, d = queue.popleft()
        if url in seen_pages:
            continue
        seen_pages.add(url)
        try:
            req = urllib.request.Request(url, headers={"User-Agent": "docs-audit/1.0"})
            with urllib.request.urlopen(req, timeout=15) as resp:
                ctype = resp.headers.get("Content-Type", "")
                if "html" not in ctype.lower():
                    continue
                body = resp.read().decode("utf-8", errors="ignore")
        except Exception as e:
            print(f"  ! fetch failed {url}: {e}", file=sys.stderr)
            continue

        ex = LinkExtractor()
        ex.feed(body)
        for href in ex.hrefs:
            absolute = urllib.parse.urljoin(url, href)
            p = urllib.parse.urlparse(absolute)
            if p.netloc == DOCS_HOST:
                docs_links.add(absolute)
            elif d < depth and (not same_host_only or p.netloc == start_host):
                if p.scheme in ("http", "https"):
                    queue.append((absolute, d + 1))
    return docs_links


def grep_repo(dir_path: Path) -> set[str]:
    """Grep a local checkout for docs.hedera.com URLs."""
    pat = r"https?://docs\.hedera\.com[^\s\"'<>)]*"
    try:
        out = subprocess.check_output(
            ["grep", "-rEho", pat, str(dir_path)],
            stderr=subprocess.DEVNULL,
        ).decode("utf-8", errors="ignore")
    except subprocess.CalledProcessError:
        out = ""
    return {line.strip().rstrip(".,;:'\")") for line in out.splitlines() if line.strip()}


def read_file(path: str) -> set[str]:
    stream = sys.stdin if path == "-" else open(path)
    return {line.strip() for line in stream if line.strip() and not line.startswith("#")}


# ── Main ────────────────────────────────────────────────────────────────────

def main() -> int:
    ap = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    src = ap.add_mutually_exclusive_group(required=True)
    src.add_argument("--crawl", metavar="URL", help="Crawl a live site for links to docs.hedera.com")
    src.add_argument("--grep", metavar="DIR", help="Grep a local checkout for docs.hedera.com URLs")
    src.add_argument("--file", metavar="PATH", help="Read URLs from a file (use '-' for stdin)")
    ap.add_argument("--depth", type=int, default=2, help="Crawl depth (default 2)")
    ap.add_argument("--json", action="store_true", help="Emit JSON instead of a table")
    ap.add_argument("--only-broken", action="store_true", help="Print only BROKEN entries")
    args = ap.parse_args()

    if args.crawl:
        print(f"Crawling {args.crawl} (depth={args.depth})…", file=sys.stderr)
        urls = crawl(args.crawl, args.depth)
    elif args.grep:
        print(f"Grepping {args.grep}…", file=sys.stderr)
        urls = grep_repo(Path(args.grep))
    else:
        urls = read_file(args.file)

    print(f"Found {len(urls)} unique docs.hedera.com URLs", file=sys.stderr)

    redirects = load_redirects()
    results = []
    for url in sorted(urls):
        path = urllib.parse.urlparse(url).path or "/"
        status, detail = classify(path, redirects)
        results.append({"url": url, "path": path, "status": status, "detail": detail})

    if args.only_broken:
        results = [r for r in results if r["status"] == "BROKEN"]

    if args.json:
        json.dump(results, sys.stdout, indent=2)
        sys.stdout.write("\n")
    else:
        widths = {"status": 12, "path": 60}
        print(f"{'STATUS':<{widths['status']}} {'PATH':<{widths['path']}} DETAIL")
        print("-" * (widths["status"] + widths["path"] + 20))
        for r in results:
            print(f"{r['status']:<{widths['status']}} {r['path'][:widths['path']]:<{widths['path']}} {r['detail']}")

    counts = {"OK_FILE": 0, "OK_REDIRECT": 0, "BROKEN": 0}
    for r in results:
        counts[r["status"]] = counts.get(r["status"], 0) + 1
    print("", file=sys.stderr)
    print(f"Summary: {counts['OK_FILE']} OK_FILE, {counts['OK_REDIRECT']} OK_REDIRECT, {counts['BROKEN']} BROKEN", file=sys.stderr)
    return 1 if counts["BROKEN"] else 0


if __name__ == "__main__":
    sys.exit(main())
