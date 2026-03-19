# Hedera Documentation Revamp

This directory contains all tooling, planning, and registries for restructuring the Hedera documentation from its current flat `hedera/` layout into a persona-driven 7-tab structure.

**Branch:** All revamp work lives on the `dev` branch. The `main` branch continues to serve the live `hedera/` docs as-is. See [Branch Strategy](#branch-strategy) below.

---

## Current Status (as of 2026-03-19)

| Metric | Value |
|--------|-------|
| Total pages in new structure | 599 |
| Pages migrated from `hedera/` | 532 (100% coverage) |
| Pages protected (dev-authored, have hedera/ source) | 1 |
| Pages dev-authored (no hedera/ source) | 4 |
| Placeholder pages remaining | 59 |
| Sidebar fixup entries | 30 |
| verify.sh checks | 11 (all passing) |

**What's complete:**
- 7-tab navigation wired in `docs.json` with all groups and pages
- 100% of `hedera/` pages mapped and migrated to correct tabs
- `sidebarTitle: Overview` eliminated from all destination files
- Learn / Getting Started section fully written (4 pages)
- Migration tooling: `migrate.sh`, `verify.sh`, `create-placeholders.sh`
- Automated systems: protected pages, sidebar fixups, sync log
- Global nav anchors: Status, Discord, Playground, Blog

**What still needs content written** (59 placeholder pages):
- See `.claude/reports/planning/revamp-gap-analysis.md` for the full list by tab and priority

---

## Directory Contents

| File | Purpose |
|------|---------|
| `plan.md` | Full revamp plan: persona model, tab architecture, content mapping, user journeys |
| `migrate.sh` | Migration script: copies `hedera/` → new structure, strips/injects sidebarTitles, updates `docs.json`, appends to sync log |
| `create-placeholders.sh` | Creates "Coming Soon" placeholder pages for new content that doesn't exist in `hedera/` |
| `verify.sh` | Validation script: 11 checks covering JSON, nav integrity, coverage, orphans, protected pages, sidebar fixups |
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

`hedera/` exists on **both** branches. When content is updated on `main`, you merge `main` → `dev` then re-run `migrate.sh` to propagate changes into the new structure. See [Keeping Dev in Sync with Main](#keeping-dev-in-sync-with-main).

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

When new commits land on `main`, sync them into the new structure on `dev`:

```bash
# 1. Pull latest main
git checkout main && git pull

# 2. Switch to dev and merge
git checkout dev
git merge main

# 3. Re-run migration — auto-detects all changes
./revamp/migrate.sh

# 4. Understand the output symbols:
#    + NEW              new file copied to the correct destination
#    ~ UPDATE           existing destination overwritten with latest content
#    = SAME             source and destination match, skipped
#    ? UNMAPPED         new file with no mapping rule → add one (see below)
#    ! ORPHAN           destination whose source was deleted → run --clean
#    ⚠ PROTECTED-CHANGED  protected page's source changed → review manually
#    ⚠ FIXUP-CHANGED    sidebar-fixup source changed → verify sidebarTitle

# 5. Remove orphaned files if needed
./revamp/migrate.sh --clean

# 6. Check what was recorded in the sync log
cat revamp/sync-log.md

# 7. Validate
./revamp/verify.sh
```

> **Note on UPDATE count:** ~85 files will always show as UPDATE on every migration run. These are files whose content we transform (sidebarTitle stripped or replaced with a custom label). The processed destination always differs from the raw source — this is expected and correct, not a bug.

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

**Layer 3 — Additional Copies** (`get_additional_destinations()`):
For files that must exist in multiple locations (e.g., testnet faucet page appears under both `evm/quickstart/` and `learn/getting-started/`).

### Sync Behavior

| Source State | Destination State | Action |
|---|---|---|
| New file, no dest | — | **COPY** (new file created) |
| File changed | Dest exists, different content | **UPDATE** (overwrite + transform) |
| File unchanged | Dest exists, matches source | **SKIP** (but still applies fixups if needed) |
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

Many pages in `hedera/` have long titles (e.g., "Understanding Hedera's EVM Differences and Compatibility") that look bad in the sidebar. The fix registry is `revamp/sidebar-fixups.txt`. Currently 30 entries.

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
## 2026-03-19 17:04 UTC

- **main HEAD**: `946bde0` — docs: update 71 mainnet date (#479)
- **dev HEAD**: `11bf2b8` — docs: implement Learn/Getting Started section
- **Stats**: 0 new · 51 updated · 484 unchanged · 1 protected skipped · 19 fixups applied
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

Runs 10 numbered checks. Check 1 produces 2 PASS outputs, so the final tally reads "All 11 checks passed":

| # | Check | Pass/Fail |
|---|-------|-----------|
| 1 | `docs.json` is valid JSON | FAIL stops here |
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

Checks 9–10 are warnings — they don't cause a non-zero exit, but require human review. All others cause exit code 1 on failure.

---

## Two Types of Dev-Authored Content

| Type | How to identify | Risk from migration |
|------|----------------|---------------------|
| **No hedera/ source** | Not in any `get_explicit_mapping()` or `get_directory_mapping()` case | None — migration never touches it. Orphan detection skips nav-referenced pages. |
| **Protected (has hedera/ source)** | Listed in `protected-pages.txt` | None — migration skips copy. Warns if upstream source changes. |

---

## Migration Coverage

532 pages in `hedera/` are mapped (100% coverage):

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
