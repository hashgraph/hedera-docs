#!/usr/bin/env python3
"""fix-inbound-links.py — Rewrite legacy /hedera/ in-body links to new paths.

Source of truth for the mapping is revamp/build-link-map.sh (which replays
migrate.sh's explicit-then-directory precedence). This script:
  - builds the legacy_url -> new_url table fresh (subprocess),
  - rewrites markdown `](...)` and HTML `href="..."` links that target either
    /hedera/...  OR  https://docs.hedera.com/hedera/...  (latter -> relative),
  - preserves #anchors verbatim and each file's exact newlines / trailing-newline
    (only link substrings are touched; newlines elsewhere are never modified),
  - leaves any unmapped target untouched and reports it,
  - is idempotent (only /hedera/ targets match; new paths never re-match).

Default is DRY RUN. Pass --apply to write. Use file_exists_for_path-style
resolution from audit-inbound-links.py for the post-run audit (separate step).
"""
import argparse, os, re, subprocess, sys, tempfile
from collections import defaultdict

REPO = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
DIRS = ["learn", "evm", "native", "operators", "reference", "solutions", "support"]
ABS_PREFIX_RE = r'https?://docs\.hedera\.com'

# group1 = the link-opening token we keep; group2 = the url (path or absolute)
R_MD   = re.compile(r'(\]\()((?:' + ABS_PREFIX_RE + r')?/hedera/[^)\s"\'<>]*)')
R_HREF = re.compile(r'(href=")((?:' + ABS_PREFIX_RE + r')?/hedera/[^"]*)')


def build_map():
    """Run build-link-map.sh and return {legacy_url: new_url}, erroring on collision."""
    res = subprocess.run([os.path.join(REPO, "revamp", "build-link-map.sh")],
                         capture_output=True, text=True)
    if res.returncode != 0:
        sys.exit(f"build-link-map.sh failed:\n{res.stderr}")
    m = {}
    for line in res.stdout.splitlines():
        if not line.strip():
            continue
        legacy, new = line.split("\t")
        if legacy in m and m[legacy] != new:
            sys.exit(f"COLLISION: {legacy} -> {m[legacy]} and {new}")
        m[legacy] = new
    sys.stderr.write(f"loaded {len(m)} mappings\n")
    return m


def resolve(url, mapping):
    """url is the raw link target (may have domain, trailing slash, #anchor).
    Returns (new_url_with_anchor, was_absolute) or (None, was_absolute)."""
    was_abs = bool(re.match(ABS_PREFIX_RE, url))
    body = re.sub(r'^' + ABS_PREFIX_RE, '', url)   # strip domain -> /hedera/...
    path, sep, anchor = body.partition('#')
    if path != '/hedera' and path.endswith('/'):
        path = path.rstrip('/')
    new = mapping.get(path)
    if new is None:
        return None, was_abs
    return new + (sep + anchor if sep else ''), was_abs


def process_text(text, mapping, stats, relpath):
    """Return rewritten text. Mutates stats."""
    def repl(match):
        opener, url = match.group(1), match.group(2)
        new, was_abs = resolve(url, mapping)
        if new is None:
            stats["unmapped"][url] += 1
            stats["unmapped_files"].setdefault(url, set()).add(relpath)
            return match.group(0)            # leave untouched
        stats["rewritten"] += 1
        if was_abs:
            stats["abs_converted"] += 1
        if '#' in url:
            stats["with_anchor"] += 1
        return opener + new

    text = R_MD.sub(repl, text)
    text = R_HREF.sub(repl, text)
    return text


def iter_mdx():
    for d in DIRS:
        for root, _, files in os.walk(os.path.join(REPO, d)):
            for f in files:
                if f.endswith(".mdx"):
                    yield os.path.join(root, f)


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--apply", action="store_true", help="write changes (default: dry run)")
    ap.add_argument("--show-diff", action="store_true", help="print a per-file before/after sample")
    args = ap.parse_args()

    mapping = build_map()
    stats = {"rewritten": 0, "abs_converted": 0, "with_anchor": 0,
             "unmapped": defaultdict(int), "unmapped_files": {}, "files_changed": 0}
    changed_files = []

    for path in iter_mdx():
        # newline='' preserves \r\n and trailing-newline state; only link substrings change
        with open(path, "r", encoding="utf-8", newline="") as fh:
            orig = fh.read()
        if "/hedera/" not in orig:
            continue
        new = process_text(orig, mapping, stats, os.path.relpath(path, REPO))
        if new != orig:
            changed_files.append((path, orig, new))
            stats["files_changed"] += 1
            if args.apply:
                d = os.path.dirname(path)
                fd, tmp = tempfile.mkstemp(dir=d, suffix=".tmp")
                with os.fdopen(fd, "w", encoding="utf-8", newline="") as out:
                    out.write(new)
                os.replace(tmp, path)

    print("\n=== fix-inbound-links %s ===" % ("APPLY" if args.apply else "DRY RUN"))
    print(f"files changed:        {stats['files_changed']}")
    print(f"links rewritten:      {stats['rewritten']}")
    print(f"  of those absolute:  {stats['abs_converted']}  (docs.hedera.com -> relative)")
    print(f"  of those w/ anchor: {stats['with_anchor']}")
    n_unmapped = sum(stats["unmapped"].values())
    print(f"unmapped (untouched): {n_unmapped}  ({len(stats['unmapped'])} unique targets)")
    if stats["unmapped"]:
        print("\n--- UNMAPPED targets (left as-is, need review) ---")
        for url, n in sorted(stats["unmapped"].items(), key=lambda x: -x[1]):
            files = ", ".join(sorted(stats["unmapped_files"][url])[:3])
            print(f"  [{n:3}x] {url}   (e.g. {files})")

    if args.show_diff and changed_files:
        import difflib
        path, orig, new = changed_files[0]
        print(f"\n--- sample diff: {os.path.relpath(path, REPO)} ---")
        diff = difflib.unified_diff(orig.splitlines(), new.splitlines(),
                                    lineterm="", n=0)
        for ln in list(diff)[:40]:
            print(ln)


if __name__ == "__main__":
    main()
