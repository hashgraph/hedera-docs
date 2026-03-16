# Hedera Documentation Revamp

This directory contains the tooling and plan for restructuring the Hedera documentation from its current flat `hedera/` layout into a persona-driven 6-tab structure.

## Directory Contents

| File | Purpose |
|------|---------|
| `plan.md` | The full revamp plan: persona model, navigation architecture, content mapping, user journeys |
| `migrate.sh` | Migration script that copies content from `hedera/` to the new tab structure and updates `docs.json` |
| `create-placeholders.sh` | Creates placeholder pages for new content that doesn't exist in the old docs |
| `verify.sh` | Verification script that validates the migration: nav integrity, coverage, orphans, duplicates |
| `docs.json` | The new Mintlify navigation config with 7-tab structure (installed by `migrate.sh`) |
| `README.md` | This file |

## New Structure

The revamp reorganizes ~300+ pages from `hedera/` into 7 top-level sections:

```
learn/          # Core concepts, getting started, networks (for everyone)
evm/            # Smart contracts, ERC tokens, tools, integrations (for EVM devs)
native/         # SDK reference, tutorials, integrations (for JS/Java/Go devs)
operators/      # Mirror nodes, JSON-RPC relay, consensus nodes (for infra ops)
reference/      # REST API, Protobuf API, HCS gRPC, Status API (for everyone)
solutions/      # Tokenization studios, governance, sustainability, tools
support/        # FAQs, contributing guide, style guide, glossary
```

## Workflow

### Initial Setup

```bash
# Create the dev branch from main
git checkout -b dev

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

When new commits land on `main` that add, update, or delete pages in `hedera/`, you need to sync those changes into the new structure on `dev`:

```bash
# 1. Pull latest main
git checkout main && git pull

# 2. Switch back to dev and merge
git checkout dev
git merge main

# 3. Re-run migration (auto-detects changes)
./revamp/migrate.sh

# 4. Review what happened
#    - NEW files: copied to the correct destination
#    - UPDATED files: overwritten with latest content
#    - UNMAPPED files: new files with no mapping rule (see below)
#    - ORPHANED files: destination files whose source was deleted

# 5. If there are orphans, clean them up
./revamp/migrate.sh --clean
```

**Why this works**: The `hedera/` directory exists on both `main` and `dev`. When you merge `main` into `dev`, git brings all `hedera/` changes into the `dev` branch. The migration script then compares the current `hedera/` content against the destination files and syncs any differences.

### Handling Unmapped Files

If someone adds a page to a **completely new directory** in `hedera/` (not under any existing mapped path), the migration script will flag it as `UNMAPPED` and exit with error code 1.

To fix this:
1. Decide where the new content belongs in the new structure
2. Add either an **explicit mapping** (in `get_explicit_mapping()`) or a **directory rule** (in `get_directory_mapping()`) to `migrate.sh`
3. Re-run the migration

If the new file is added under an **already-mapped directory** (e.g., a new protobuf type under `hedera-api/basic-types/`), the directory rules handle it automatically — no script changes needed.

## How the Migration Script Works

The script uses a **3-layer mapping strategy**:

### Layer 1: Explicit File Mappings

For files that move across tabs or need specific renaming. Defined in `get_explicit_mapping()`.

Example: `hedera/core-concepts/smart-contracts.mdx` → `learn/core-concepts/services/smart-contracts.mdx`

### Layer 2: Directory Rules

For bulk sections where files preserve their names but change their path prefix. Defined in `get_directory_mapping()`. These **automatically pick up new files** added to the source directory.

Example: Any file under `hedera/sdks-and-apis/hedera-api/basic-types/` → `reference/protobuf/basic-types/`

### Layer 3: Additional Copies

Some files need to exist in multiple locations. Defined in `get_additional_destinations()`.

Example: The testnet faucet page appears under both `evm/quickstart/` and `learn/getting-started/`.

### Sync Behavior

| Source State | Destination State | Action |
|---|---|---|
| New file, no dest | — | **COPY** (new file) |
| File changed | Dest exists, different content | **UPDATE** (overwrite) |
| File unchanged | Dest exists, same content | **SKIP** |
| File deleted | Dest still exists | **ORPHAN** (report, or remove with `--clean`) |
| New file, no mapping | — | **UNMAPPED** (error, needs rule added) |

## Script Options

### migrate.sh

```
./revamp/migrate.sh [OPTIONS]

Options:
  --dry-run    Preview all changes without modifying any files
  --clean      Remove orphaned destination files (source was deleted)
  --verbose    Show all files including unchanged ones
  --help       Show usage information
```

The script automatically creates a timestamped backup of `hedera/` before making changes (e.g., `hedera.backup.20260316_143022`).

### create-placeholders.sh

```
./revamp/create-placeholders.sh
```

No options — creates placeholder `.mdx` files for pages in the new structure that need to be written from scratch (overview pages, "choose your path" guides, etc.). Skips files that already exist.

### verify.sh

```
./revamp/verify.sh [OPTIONS]

Options:
  --fix    Show suggested fixes for issues found
  --help   Show usage information
```

Runs 8 validation checks:

| Check | What it validates |
|-------|-------------------|
| **1. JSON validity** | `docs.json` is valid JSON and matches `revamp/docs.json` |
| **2. Nav references** | Every page path in `docs.json` has a corresponding `.mdx` file |
| **3. Migration coverage** | Every `.mdx` in `hedera/` has a mapping in `migrate.sh` |
| **4. No duplicates** | No page path appears more than once in `docs.json` navigation |
| **5. No orphans** | Every `.mdx` in destination dirs is either in nav or a known placeholder |
| **6. Snippet imports** | All `import ... from '/snippets/...'` statements resolve to real files |
| **7. Tab structure** | All tabs in `docs.json` have groups or pages defined |
| **8. Directory structure** | All 7 destination directories exist with `.mdx` files |

Exits with code 0 if all checks pass, 1 if any fail.

## Adding New Mapping Rules

### To add an explicit file mapping:

Edit `revamp/migrate.sh`, find the `get_explicit_mapping()` function, and add a new case:

```bash
"hedera/path/to/new-file.mdx") echo "section/destination/path.mdx" ;;
```

### To add a directory rule:

Edit `revamp/migrate.sh`, find the `get_directory_mapping()` function, and add:

```bash
if [[ "$src" == hedera/new/source/prefix/* ]]; then
    echo "new/dest/prefix/${src#hedera/new/source/prefix/}"; return
fi
```

**Important**: Directory rules are checked in order; place more specific prefixes before more general ones.

## Migration Coverage

The migration script covers **100% of existing pages** in `hedera/`, including:

- ~60 Learn section pages (core concepts, networks, getting started)
- ~80 EVM section pages (smart contracts, tokens, tools, tutorials)
- ~100 Native SDK pages (accounts, tokens, consensus, files, keys, tutorials)
- ~10 Operators pages (mirror nodes, consensus nodes)
- ~140 Reference pages (REST API, Protobuf API with all sub-types)
- ~30 Solutions pages (tokenization studios, governance, tools, Hiero CLI)
- ~15 Support pages (FAQs, contributing guide, style guide)
