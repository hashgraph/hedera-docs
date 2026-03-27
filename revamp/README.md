# Hedera Documentation Revamp

This directory contains all tooling, planning, and registries for restructuring the Hedera documentation from its current flat `hedera/` layout into a persona-driven 7-tab structure.

**Branch:** All revamp work lives on the `dev` branch. The `main` branch continues to serve the live `hedera/` docs as-is. See [Branch Strategy](#branch-strategy) below.

---

## Current Status (as of 2026-03-27)

| Metric | Value |
|--------|-------|
| Total pages in new structure | 600 |
| Pages migrated from `hedera/` | 533 (100% coverage) |
| Pages protected (dev-authored, have hedera/ source) | 1 |
| Pages dev-authored (no hedera/ source) | 4 |
| Placeholder pages remaining | 59 |
| Sidebar fixup entries | 31 |
| verify.sh checks | 12 (all passing) |

**What's complete:**
- 7-tab navigation wired in `docs.json` with all groups and pages
- 100% of `hedera/` pages mapped and migrated to correct tabs
- `sidebarTitle: Overview` eliminated from all destination files
- Learn / Getting Started section fully written (4 pages)
- Migration tooling: `migrate.sh`, `verify.sh`, `create-placeholders.sh`, `merge-main.sh`
- Automated systems: protected pages, sidebar fixups, sync log
- Global nav anchors: Status, Discord, Playground, Blog

**What still needs content written** (59 placeholder pages):
- See `.claude/reports/planning/revamp-gap-analysis.md` for the full list by tab and priority

---

## Directory Contents

| File | Purpose |
|------|---------|
| `plan.md` | Full revamp plan: persona model, tab architecture, content mapping, user journeys |
| `merge-main.sh` | **Use this instead of `git merge main`** — safely merges origin/main into dev, auto-resolves docs.json conflict, reports new pages needing attention |
| `migrate.sh` | Migration script: copies `hedera/` → new structure, strips/injects sidebarTitles, updates `docs.json`, appends to sync log |
| `create-placeholders.sh` | Creates "Coming Soon" placeholder pages for new content that doesn't exist in `hedera/` |
| `verify.sh` | Validation script: 12 checks covering JSON, nav integrity, coverage, orphans, protected pages, sidebar fixups, nav parity |
| `docs.json` | The new Mintlify navigation config (7-tab structure) — installed as the root `docs.json` by `migrate.sh` |
| `protected-pages.txt` | Registry of dev-authored pages that must NOT be overwritten by migration |
| `sidebar-fixups.txt` | Registry of pages needing a meaningful `sidebarTitle` injected after migration (replaces generic "Overview") |
| `sync-log.md` | Append-only log of every `migrate.sh` run — tracks which `main` commit dev is synced to |
| `README.md` | This file |

---

## Branch Strategy

| Branch | Purpose | Source of truth |
|--------|---------|----------------|
| `main` | Production docs, served live | `hedera/` directory |
| `dev` | Revamp in progress | `learn/`, `evm/`, `native/`, `operators/`, `reference/`, `solutions/`, `support/` directories |

`hedera/` exists on **both** branches. When content is updated on `main`, you run `merge-main.sh` then `migrate.sh` to propagate changes into the new structure. See [Keeping Dev in Sync with Main](#keeping-dev-in-sync-with-main).

**Rules:**
- Never edit files under `hedera/` on the `dev` branch — edit on `main`, then sync
- Never run `migrate.sh` on `main` — it only applies to `dev`
- Never delete `hedera/` on `dev` — it's the migration source

---

## New Structure

The revamp reorganizes 500+ pages from `hedera/` into 7 persona-driven tabs:

```
learn/          # Core concepts, getting started, networks (for everyone)
evm/            # Smart contracts, ERC tokens, tools, integrations (for EVM devs)
native/         # SDK reference, tutorials, integrations (for JS/Java/Go devs)
operators/      # Mirror nodes, JSON-RPC relay, consensus nodes (for infra ops)
reference/      # REST API, Protobuf API, HCS gRPC, Status API (for everyone)
solutions/      # Tokenization studios, governance, sustainability, tools
support/        # FAQs, contributing guide, style guide, glossary
```

See `plan.md` for the full architecture, persona model, and content mapping rationale.

---

## Dev-Authored Pages

Some pages in the new structure have no equivalent in `hedera/` and were written directly on `dev`. These are never at risk from migration (no mapping exists for them) and do not need to be in `protected-pages.txt`.

| Page | Status |
|------|--------|
| `learn/getting-started/index.mdx` | ✅ Written — section hub with guided 4-step journey |
| `learn/getting-started/what-is-hedera.mdx` | ✅ Written — Hashgraph, services, FAQ |
| `learn/getting-started/why-hedera.mdx` | ✅ Written — performance, fees, governance, comparison table |
| `learn/getting-started/choose-your-path.mdx` | ✅ Written — EVM vs Native SDK persona funnel |

**Protected pages** (have a `hedera/` source but are manually maintained on `dev`) are tracked separately in `protected-pages.txt`. Currently:

| Page | Source | Reason |
|------|--------|--------|
| `learn/index.mdx` | `hedera/readme.mdx` | Fully rewritten as Learn tab landing — stale `hedera/` links replaced with new 7-tab paths |

---

## Running Locally

```bash
# Requires Node.js 22 (NOT 25+)
nvm use 22
npx mintlify dev
```

The dev server starts at `localhost:3000`. All 7 tabs are visible in the left nav.

---

## Workflow

### Initial Setup (one-time)

```bash
# Preview what will happen (no files modified)
./revamp/migrate.sh --dry-run

# Run for real
./revamp/migrate.sh

# Create placeholder pages for new content
./revamp/create-placeholders.sh

# Validate everything
./revamp/verify.sh
```

### Keeping Dev in Sync with Main

When new commits land on `main`, use `merge-main.sh` — **do not use `git merge main` directly**.

#### Why not `git merge main`?

`dev`'s `docs.json` is the 7-tab revamp nav. `main`'s `docs.json` is the production nav. They are structurally incompatible and **always conflict** on every merge. `merge-main.sh` auto-resolves this conflict correctly (keeps dev's version) and also detects new pages that need attention.

#### Standard sync workflow

```bash
# 1. Check what's coming in (safe, no changes)
./revamp/merge-main.sh --dry-run

# 2. If new hedera/ pages are reported, handle them FIRST (see below)
#    Then run the real merge:
./revamp/merge-main.sh

# 3. Propagate content changes to the revamp structure
./revamp/migrate.sh

# 4. Handle any warnings in migrate.sh output:
#    ⚠ FIXUP-CHANGED  — source content changed; verify sidebarTitle still accurate:
./revamp/migrate.sh --ack-fixup=<source>   # or --ack-fixup=all

#    ⚠ PROTECTED-CHANGED  — protected page source changed; review + acknowledge:
./revamp/migrate.sh --ack=<source>

# 5. Validate all 12 checks pass
./revamp/verify.sh

# 6. Commit
git add -A
git commit -S -s -m "docs: sync dev with main (<short-hash> — <brief description>)"
```

#### migrate.sh output symbols

| Symbol | Meaning |
|--------|---------|
| `+ NEW` | New file copied to the correct destination |
| `~ UPDATE` | Existing destination overwritten with latest content |
| `= SAME` | Source and destination match, skipped |
| `? UNMAPPED` | New file with no mapping rule — add one (see [Handling Unmapped Files](#handling-unmapped-files)) |
| `! ORPHAN` | Destination whose source was deleted — run `--clean` |
| `⚠ PROTECTED-CHANGED` | Protected page's source changed — review manually |
| `⚠ FIXUP-CHANGED` | Sidebar-fixup source changed — verify sidebarTitle |
| `⚠ New/updated via directory rule` | A new or changed file was placed by a directory fallback rule — verify it's in revamp/docs.json nav |

> **On UPDATE count:** `migrate.sh` compares *transformed* source content to the destination (CRLF normalization + sidebarTitle strip + fixup injection applied before comparing). This means files only show as `UPDATE` when the actual source content changed — not when the only difference is formatting transforms. A clean run with no upstream changes shows `0 updated, N unchanged`.

#### Handling new pages from main

When `--dry-run` or `merge-main.sh` reports new hedera/ pages, you need to handle them **before or immediately after** the merge:

1. **Add an explicit mapping** in `revamp/migrate.sh` → `get_explicit_mapping()`:
   ```bash
   "hedera/path/to/new-page.mdx") echo "native/section/new-page.mdx" ;;
   ```
   If the file falls under an already-mapped directory (e.g., `hedera/sdks-and-apis/hedera-api/basic-types/`), the directory rule handles it automatically — no explicit mapping needed.

2. **Add the destination to `revamp/docs.json` nav** in the appropriate tab/group.

3. **Optionally add a sidebarTitle fixup** in `revamp/sidebar-fixups.txt` if the page title is long or generic:
   ```
   $(git hash-object hedera/path/to/new-page.mdx)|hedera/path/to/new-page.mdx|dest/path.mdx|Short Label
   ```

4. Re-run `./revamp/migrate.sh` — the new page is picked up as a NEW file.

---

## How the Migration Script Works

### 3-Layer Mapping Strategy

**Layer 1 — Explicit File Mappings** (`get_explicit_mapping()`):
For individual files that move across tabs or need specific renaming.
```bash
"hedera/core-concepts/smart-contracts.mdx") echo "learn/core-concepts/services/smart-contracts.mdx" ;;
```

**Layer 2 — Directory Rules** (`get_directory_mapping()`):
For bulk sections where files keep their names but change their path prefix. **Automatically picks up new files** added under those paths.
```bash
if [[ "$src" == hedera/sdks-and-apis/hedera-api/basic-types/* ]]; then
    echo "reference/protobuf/basic-types/${src#hedera/sdks-and-apis/hedera-api/basic-types/}"; return
fi
```
> Rules are checked in order — more specific prefixes must come before general ones.
>
> When a new or changed file lands via a Layer 2 rule, migrate.sh warns `⚠ New/updated via directory rule` and lists it. This only fires on actual new/updated files — stable, already-mapped pages are silent. If you see this warning, verify the destination appears in `revamp/docs.json` nav, then run `./revamp/verify.sh`.

**Layer 3 — Additional Copies** (`get_additional_destinations()`):
For files that must exist in multiple locations (e.g., testnet faucet page appears under both `evm/quickstart/` and `learn/getting-started/`).

### Sync Behavior

| Source State | Destination State | Action |
|---|---|---|
| New file, no dest | — | **COPY** (new file created) |
| File changed | Dest exists, different content | **UPDATE** (overwrite + transform) |
| File unchanged | Dest is up to date (transforms already applied) | **SKIP** |
| File deleted | Dest still exists | **ORPHAN** (report, or remove with `--clean`) |
| File has no mapping | — | **UNMAPPED** (script exits with error) |
| File is in `protected-pages.txt` | — | **SKIP** (never overwrite, warns if source changed) |

### Post-Copy Transformations

After every file copy (and also on UNCHANGED files to catch late-added fixup entries):

1. **Strip `sidebarTitle: Overview`** — removed from all destination files. Handles both quoted (`"Overview"`) and unquoted forms, and CRLF line endings in `hedera/` source files (BSD `sed` fails on CRLF; Python handles it correctly).
2. **Inject meaningful sidebarTitle** — if the source is in `sidebar-fixups.txt`, the correct label is injected after the `title:` line (e.g., `sidebarTitle: Hashgraph`).

---

## Protected Pages

Pages written directly on `dev` that have a `hedera/` source mapping must never be overwritten. They are tracked in `revamp/protected-pages.txt`.

### Format

```
source_git_hash|source_path|destination_path|reason
```

### How it Works

- `migrate.sh` skips the copy entirely when a source is protected.
- The hash tracks source content. If `hedera/readme.mdx` changes on `main`, migrate.sh warns that the protected destination (`learn/index.mdx`) may need to be updated manually.
- After reviewing and incorporating relevant changes, acknowledge to clear the warning:

```bash
./revamp/migrate.sh --ack=hedera/readme.mdx
```

### Adding a New Protected Page

1. Write the destination page directly on `dev`
2. Add to `protected-pages.txt`:
   ```
   $(git hash-object hedera/path/to/source.mdx)|hedera/path/to/source.mdx|dest/path.mdx|Reason
   ```
3. The destination must already be in `docs.json` navigation (add manually)

---

## Sidebar Fixups

Many pages in `hedera/` have long titles (e.g., "Understanding Hedera's EVM Differences and Compatibility") that look bad in the sidebar. The fix registry is `revamp/sidebar-fixups.txt`. Currently 31 entries.

### Format

```
source_git_hash|source_path|destination_path|sidebar_title
```

### How it Works

On every migration run, for every file processed:
1. `sidebarTitle: Overview` is stripped (always)
2. If the source is in `sidebar-fixups.txt`, the correct label is injected: `sidebarTitle: <label>`
3. This runs even on UNCHANGED files — so adding a new fixup entry takes effect on the very next migration run without waiting for upstream changes
4. If the source file's content has changed since the hash was recorded, migrate.sh warns you to verify the sidebarTitle is still accurate

To acknowledge a content change:
```bash
# One page
./revamp/migrate.sh --ack-fixup=hedera/core-concepts/hashgraph-consensus-algorithms.mdx

# All at once
./revamp/migrate.sh --ack-fixup=all
```

### Adding a New Sidebar Fixup

```bash
# 1. Get the source hash
git hash-object hedera/path/to/source.mdx

# 2. Add to sidebar-fixups.txt:
#    <hash>|hedera/path/to/source.mdx|dest/path/index.mdx|Short Label

# 3. Run migration — label is injected automatically
./revamp/migrate.sh
```

---

## Sync Log

Every successful `migrate.sh` run (non-dry-run) appends an entry to `revamp/sync-log.md` **only when `main` has advanced to a new commit**. Re-running on the same commit produces no duplicate entry — you'll see `📋 Sync log unchanged (main still at <hash>)` instead.

```markdown
## 2026-03-27 11:52 UTC   ← newest at top

- **main HEAD**: `5c065f1` — docs: Update ecdsa messaging (#486)
- **dev HEAD**: `e3ece80` — Merge remote-tracking branch 'origin/main' into dev
- **Stats**: 1 new · 89 updated · 446 unchanged · 1 protected skipped · 32 fixups applied

## 2026-03-19 21:55 UTC

- **main HEAD**: `f9b2de0` — docs: Add Ubuntu 24 LTS to list of supported OS (#482)
...
```

Use `cat revamp/sync-log.md` to see which `main` commit dev is currently synced to.

---

## Handling Unmapped Files

If a file is added under a **new directory** in `hedera/` that no existing rule covers, migrate.sh flags it as `UNMAPPED` and exits with error code 1.

**Fix:**
1. Decide where it belongs in the 7-tab structure
2. Add an explicit mapping or directory rule to `migrate.sh`
3. Re-run

If the new file is under an **already-mapped directory** (e.g., a new protobuf type under `hedera-api/basic-types/`), directory rules handle it automatically — no script changes needed.

---

## Script Reference

### `merge-main.sh`

```
./revamp/merge-main.sh [OPTIONS]

Options:
  --dry-run    Preview new pages and nav changes; do not merge
  --help       Show usage information
```

Use this **instead of `git merge main`** when syncing `dev` with `main`. Handles the inevitable `docs.json` conflict automatically (always keeps dev's revamp structure). Reports new pages that need explicit mappings or nav entries. Always produces a GPG-signed, DCO-signedoff merge commit.

### `migrate.sh`

```
./revamp/migrate.sh [OPTIONS]

Options:
  --dry-run              Preview all changes without modifying files
  --clean                Remove orphaned destination files
  --verbose              Show all files including unchanged ones
  --ack=<source>         Acknowledge upstream change in a protected page
                         (updates hash in protected-pages.txt)
  --ack-fixup=<source>   Acknowledge upstream change in a sidebar-fixup page
  --ack-fixup=all        Acknowledge all sidebar-fixup pages at once
                         (updates hashes in sidebar-fixups.txt)
  --help                 Show usage information
```

Creates a timestamped `hedera/` backup before making changes (e.g., `hedera.backup.20260316_143022`). These are gitignored. Appends to `revamp/sync-log.md` on every successful non-dry-run.

### `create-placeholders.sh`

```
./revamp/create-placeholders.sh
```

Creates "Coming Soon" placeholder `.mdx` files for any pages referenced in `docs.json` that don't exist on disk. Skips existing files.

### `verify.sh`

```
./revamp/verify.sh [OPTIONS]

Options:
  --fix    Show suggested fixes alongside failures
  --help   Show usage information
```

Runs 11 numbered checks. Check 1 produces 2 PASS outputs, so the final tally reads "All 12 checks passed":

| # | Check | Severity |
|---|-------|----------|
| 1 | `docs.json` is valid JSON | FAIL |
| 1b | `docs.json` matches `revamp/docs.json` | WARN |
| 2 | Every nav page path has a `.mdx` file on disk | FAIL |
| 3 | Every `.mdx` in `hedera/` has a mapping | FAIL |
| 4 | No page path appears twice in nav | FAIL |
| 5 | Every `.mdx` in dest dirs is in nav or a placeholder | FAIL |
| 6 | All snippet imports resolve to real files | FAIL |
| 7 | All tabs have groups or pages defined | FAIL |
| 8 | All 7 destination directories exist | FAIL |
| 9 | No unacknowledged protected-page upstream changes | WARN |
| 10 | No unacknowledged sidebar-fixup hash mismatches | WARN |
| 11 | All production hedera/ nav pages have revamp equivalents | WARN |

Checks 9–11 are warnings — they don't cause a non-zero exit, but require human review. All others cause exit code 1 on failure.

---

## Two Types of Dev-Authored Content

| Type | How to identify | Risk from migration |
|------|----------------|---------------------|
| **No hedera/ source** | Not in any `get_explicit_mapping()` or `get_directory_mapping()` case | None — migration never touches it. Orphan detection skips nav-referenced pages. |
| **Protected (has hedera/ source)** | Listed in `protected-pages.txt` | None — migration skips copy. Warns if upstream source changes. |

---

## Migration Coverage

533 pages in `hedera/` are mapped (100% coverage):

| Tab | Approx pages |
|-----|-------------|
| Learn | ~60 (core concepts, networks, release notes) |
| EVM | ~80 (smart contracts, tokens, tools, tutorials, integrations) |
| Native SDKs | ~100 (accounts, tokens, consensus, files, keys, tutorials, local dev) |
| Operators | ~10 (mirror nodes, consensus nodes) |
| Reference | ~140 (REST API, Protobuf API with all sub-types, HCS, Status) |
| Solutions | ~30 (tokenization studios, governance, sustainability, tools, Hiero CLI) |
| Support | ~15 (FAQs, contributing guide, style guide) |

---

## What Still Needs to Be Done

59 placeholder pages need real content written. The full prioritized list is in `.claude/reports/planning/revamp-gap-analysis.md`. High-priority gaps:

- **EVM tab** — 32 placeholders (overview pages, quickstart, development guides, most tutorials)
- **Native SDK tab** — 17 placeholders (quickstart, fundamentals, service references)
- **Learn tab** — 1 placeholder (`learn/core-concepts/services/index.mdx`)
- **Operators / Solutions / Support** — 9 placeholders

These are all net-new content (don't exist in `hedera/`). They require writing from scratch.
