# Hedera Documentation Revamp

This directory contains all tooling and planning for restructuring the Hedera documentation from its current flat `hedera/` layout into a persona-driven 7-tab structure.

## Directory Contents

| File | Purpose |
|------|---------|
| `plan.md` | Full revamp plan: persona model, navigation architecture, content mapping, user journeys |
| `migrate.sh` | Migration script: copies `hedera/` content to new tab structure, injects sidebarTitles, updates `docs.json`, writes sync log |
| `create-placeholders.sh` | Creates placeholder pages for new content that doesn't exist in the old docs |
| `verify.sh` | Validation script: 11 checks covering nav integrity, coverage, orphans, protected pages, sidebar fixups |
| `docs.json` | The new Mintlify navigation config with 7-tab structure (installed by `migrate.sh`) |
| `protected-pages.txt` | Registry of dev-authored pages that must NOT be overwritten by migration |
| `sidebar-fixups.txt` | Registry of pages that need a meaningful `sidebarTitle` injected after migration |
| `sync-log.md` | Append-only log of every `migrate.sh` run — tracks which `main` commit dev is synced to |
| `README.md` | This file |

---

## New Structure

The revamp reorganizes 500+ pages from `hedera/` into 7 top-level tabs:

```
learn/          # Core concepts, getting started, networks (for everyone)
evm/            # Smart contracts, ERC tokens, tools, integrations (for EVM devs)
native/         # SDK reference, tutorials, integrations (for JS/Java/Go devs)
operators/      # Mirror nodes, JSON-RPC relay, consensus nodes (for infra ops)
reference/      # REST API, Protobuf API, HCS gRPC, Status API (for everyone)
solutions/      # Tokenization studios, governance, sustainability, tools
support/        # FAQs, contributing guide, style guide, glossary
```

---

## Workflow

### Initial Setup (one-time)

```bash
# Run the migration (preview first)
./revamp/migrate.sh --dry-run

# Run for real
./revamp/migrate.sh

# Create placeholder pages for new content
./revamp/create-placeholders.sh

# Verify everything is correct
./revamp/verify.sh
```

### Keeping Dev in Sync with Main

When new commits land on `main` (adding, updating, or deleting pages in `hedera/`), sync them into the new structure:

```bash
# 1. Pull latest main
git checkout main && git pull

# 2. Switch back to dev and merge
git checkout dev
git merge main

# 3. Re-run migration — auto-detects all changes
./revamp/migrate.sh

# 4. Review the output
#    NEW     — new file copied to the correct destination
#    UPDATE  — existing destination overwritten with latest content
#    SAME    — source and destination are identical, skipped
#    UNMAPPED — new file with no mapping rule (see Handling Unmapped Files)
#    ORPHAN  — destination whose source was deleted (run --clean to remove)
#    PROTECTED-CHANGED — a protected page's source changed upstream (review manually)
#    FIXUP-CHANGED — a sidebar-fixup source changed (verify sidebarTitle is still accurate)

# 5. Clean up orphaned files if needed
./revamp/migrate.sh --clean

# 6. Check the sync log to confirm what was recorded
cat revamp/sync-log.md
```

**Why this works:** `hedera/` exists on both `main` and `dev`. When you merge `main` → `dev`, git brings all `hedera/` changes in. The migration script then compares current `hedera/` content against destination files and syncs differences — including re-applying sidebarTitle fixups automatically.

---

## How the Migration Script Works

### 3-Layer Mapping Strategy

**Layer 1 — Explicit File Mappings** (`get_explicit_mapping()`):
Cross-tab reorganizations and renames where directory rules can't determine the correct destination.
```bash
"hedera/core-concepts/smart-contracts.mdx") echo "learn/core-concepts/services/smart-contracts.mdx" ;;
```

**Layer 2 — Directory Rules** (`get_directory_mapping()`):
Bulk sections where files preserve their names but change their path prefix. **Auto-picks up new files** added to those directories.
```bash
if [[ "$src" == hedera/sdks-and-apis/hedera-api/basic-types/* ]]; then
    echo "reference/protobuf/basic-types/${src#hedera/sdks-and-apis/hedera-api/basic-types/}"; return
fi
```
> Important: rules are checked in order — more specific prefixes must come before general ones.

**Layer 3 — Additional Copies** (`get_additional_destinations()`):
Files that must exist in multiple locations (e.g., testnet faucet page appears under both `evm/quickstart/` and `learn/getting-started/`).

### Sync Behavior

| Source State | Destination State | Action |
|---|---|---|
| New file, no dest | — | **COPY** (new file created) |
| File changed | Dest exists, different content | **UPDATE** (overwrite) |
| File unchanged | Dest exists, same content | **SKIP** |
| File deleted | Dest still exists | **ORPHAN** (report, or remove with `--clean`) |
| File has no mapping | — | **UNMAPPED** (error — add a rule) |
| File is in `protected-pages.txt` | — | **SKIP** (never overwrite) |

### Post-Copy Transformations

After every file copy, `migrate.sh` applies two transformations:

1. **Strip `sidebarTitle: Overview`** — removes this frontmatter key from every copied file, since it caused ~50 pages to show "Overview" in the sidebar.
2. **Inject meaningful sidebarTitle** — if the destination is listed in `sidebar-fixups.txt`, injects the correct `sidebarTitle` value (e.g., `sidebarTitle: Hashgraph`).

---

## Protected Pages

Some pages are written directly on the `dev` branch (not just migrated from `hedera/`) and must never be overwritten by `migrate.sh`. These are tracked in `revamp/protected-pages.txt`.

### Format

```
source_git_hash|source_path|destination_path|reason
```

Example:
```
5966193496764b1af59a57379b99fd810a29ef27|hedera/readme.mdx|learn/index.mdx|Revamped as Learn tab landing page
```

### How it Works

- `migrate.sh` skips copying when a source is listed in `protected-pages.txt`.
- The hash tracks the hedera/ source content. If the source changes on `main` (e.g., new content added to `hedera/readme.mdx`), migrate.sh **warns you** so you can manually incorporate relevant changes into the dev-authored destination.
- After reviewing, acknowledge the change to clear the warning:

```bash
./revamp/migrate.sh --ack=hedera/readme.mdx
```

### Adding a New Protected Page

1. Write the destination page on `dev` (do not depend on migration to create it)
2. Add an entry to `protected-pages.txt`:
   ```
   $(git hash-object hedera/path/to/source.mdx)|hedera/path/to/source.mdx|dest/path.mdx|Reason why this is protected
   ```
3. Add the destination to `docs.json` navigation manually

---

## Sidebar Fixups

Some page titles in `hedera/` are too long to display well in the sidebar (e.g., "Understanding Hedera's EVM Differences and Compatibility"). These need a short, meaningful `sidebarTitle` after migration. The registry is in `revamp/sidebar-fixups.txt`.

### Format

```
source_git_hash|source_path|destination_path|sidebar_title
```

Example:
```
f51244cd25c6bb7e563cc37a8ce1f3dcc0362e19|hedera/core-concepts/hashgraph-consensus-algorithms.mdx|learn/core-concepts/hashgraph/index.mdx|Hashgraph
```

### How it Works

On every migration run, after copying a file and stripping `sidebarTitle: Overview`:
1. `migrate.sh` checks if the destination is in `sidebar-fixups.txt`
2. If so, it injects `sidebarTitle: <label>` immediately after the `title:` line
3. If the source file's content has changed since the hash was recorded, it **warns you** to verify the sidebarTitle is still accurate

To acknowledge a content change (clear the warning):
```bash
# Acknowledge one page
./revamp/migrate.sh --ack-fixup=hedera/core-concepts/hashgraph-consensus-algorithms.mdx

# Acknowledge all at once
./revamp/migrate.sh --ack-fixup=all
```

### Adding a New Sidebar Fixup

1. Find the source file and compute its hash:
   ```bash
   git hash-object hedera/path/to/source.mdx
   ```
2. Add an entry to `sidebar-fixups.txt`:
   ```
   <hash>|hedera/path/to/source.mdx|dest/path/index.mdx|Short Label
   ```
3. Run `./revamp/migrate.sh` — the sidebarTitle will be injected automatically

---

## Sync Log

Every successful `migrate.sh` run (non-dry-run) appends an entry to `revamp/sync-log.md`:

```markdown
## 2026-03-19 17:04 UTC

- **main HEAD**: `946bde0` — docs: update 71 mainnet date (#479)
- **dev HEAD**: `11bf2b8` — docs: implement Learn/Getting Started section
- **Stats**: 0 new · 51 updated · 484 unchanged · 1 protected skipped · 19 fixups applied
```

This lets anyone see at a glance:
- Which `main` commit dev is currently synced to
- How many files changed in each migration run
- The full history of sync operations

---

## Handling Unmapped Files

If a page is added under a **new directory** in `hedera/` (not covered by any existing rule), the migration script flags it as `UNMAPPED` and exits with error code 1.

**Fix:**
1. Decide where the new content belongs in the new 7-tab structure
2. Add an explicit mapping or directory rule to `migrate.sh`
3. Re-run the migration

If the file is added under an **already-mapped directory** (e.g., a new protobuf type under `hedera-api/basic-types/`), the directory rules handle it automatically — no script changes needed.

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
                         Updates stored hash in protected-pages.txt
  --ack-fixup=<source>   Acknowledge upstream change in a sidebar-fixup page
  --ack-fixup=all        Acknowledge all sidebar-fixup pages at once
                         Updates stored hashes in sidebar-fixups.txt
  --help                 Show usage information
```

Creates a timestamped `hedera/` backup before making changes (e.g., `hedera.backup.20260316_143022`). Appends a sync record to `revamp/sync-log.md` on every successful non-dry-run.

### `create-placeholders.sh`

```
./revamp/create-placeholders.sh
```

Creates "Coming Soon" placeholder `.mdx` files for pages in the new structure that need to be written from scratch. Skips files that already exist.

### `verify.sh`

```
./revamp/verify.sh [OPTIONS]

Options:
  --fix    Show suggested fixes for issues found
  --help   Show usage information
```

Runs 10 numbered checks (Check 1 produces 2 PASS outputs, so the summary reports "11 checks passed"):

| # | Check | What it validates |
|---|-------|-------------------|
| 1 | **JSON validity** | `docs.json` is valid JSON; also verifies it matches `revamp/docs.json` (2 PASSes) |
| 2 | **Nav references** | Every page path in `docs.json` has a corresponding `.mdx` file on disk |
| 3 | **Migration coverage** | Every `.mdx` in `hedera/` has a mapping in `migrate.sh` |
| 4 | **No duplicates** | No page path appears more than once in `docs.json` navigation |
| 5 | **No orphans** | Every `.mdx` in destination dirs is in nav or a known placeholder |
| 6 | **Snippet imports** | All `import ... from '/snippets/...'` statements resolve to real files |
| 7 | **Tab structure** | All tabs in `docs.json` have groups or pages defined |
| 8 | **Directory structure** | All 7 destination directories exist with `.mdx` files |
| 9 | **Protected pages** | Warns if any protected page's source has changed upstream |
| 10 | **Sidebar fixups** | Warns if any sidebar-fixup source has changed (hash mismatch) |

Exits with code 0 if all checks pass, 1 if any fail. Checks 9–10 produce warnings (not failures) — they require human review.

---

## Two Types of Dev-Authored Content

Not everything in the new structure is migrated from `hedera/`. Some pages are written directly on `dev`:

| Type | Example | How it's handled |
|------|---------|-----------------|
| **No hedera/ source** | `learn/getting-started/what-is-hedera.mdx` | Never at risk — no migration mapping exists for it. Orphan detection is suppressed for nav-referenced pages. |
| **Protected from hedera/ source** | `learn/index.mdx` (source: `hedera/readme.mdx`) | Listed in `protected-pages.txt`. Migration skips copy; warns on upstream changes. |

---

## Migration Coverage

The migration script covers **100% of existing pages** in `hedera/`, including:

- ~60 Learn section pages (core concepts, networks, getting started)
- ~80 EVM section pages (smart contracts, tokens, tools, tutorials)
- ~100 Native SDK pages (accounts, tokens, consensus, files, keys, tutorials)
- ~10 Operators pages (mirror nodes, consensus nodes)
- ~140 Reference pages (REST API, Protobuf API with all sub-types)
- ~30 Solutions pages (tokenization studios, governance, tools, Hiero CLI)
- ~15 Support pages (FAQs, contributing guide, style guide)
