# CLAUDE.md — Hedera Documentation

## Repository Overview

This is the Hedera documentation portal, built with [Mintlify](https://mintlify.com). It contains all developer-facing documentation for the Hedera network.

### Branch Strategy

- **`main`** — Production branch. All documentation updates (new pages, content edits, fixes) land here. The `hedera/` directory is the source of truth for the current live documentation.
- **`dev`** — Revamp branch. Contains the new 7-tab documentation structure (`learn/`, `evm/`, `native/`, `operators/`, `reference/`, `solutions/`, `support/`) plus migration tooling in `revamp/`. Periodically synced from `main` via `./revamp/merge-main.sh`, then `./revamp/migrate.sh` to propagate changes.

### Key Directories

| Directory | Purpose |
|-----------|---------|
| `hedera/` | Current production docs (source of truth on `main`) |
| `learn/`, `evm/`, `native/`, `operators/`, `reference/`, `solutions/`, `support/` | New revamped structure (only on `dev`) |
| `revamp/` | Migration scripts, plan, verification tooling (only on `dev`) |
| `snippets/` | Reusable MDX snippet components |
| `images/` | Documentation images |

### Important Files

- `docs.json` — Mintlify navigation and site configuration
- `revamp/merge-main.sh` — **Use instead of `git merge main`** — handles docs.json conflict, reports new pages needing attention
- `revamp/migrate.sh` — Migrates content from `hedera/` to the new structure
- `revamp/create-placeholders.sh` — Creates placeholder pages for new content
- `revamp/verify.sh` — Validates migration integrity (12 checks: nav refs, coverage, orphans, nav parity)
- `revamp/plan.md` — Full revamp architecture plan

## Commit Rules

- **NEVER** add `Co-Authored-By` lines to commit messages. Commits must appear as the repository user's own work.
- **NEVER** mention Claude, AI, or assistant in commit messages.
- Write commit messages in the style of existing commits in the repo: short, imperative, prefixed with `docs:`, `chore:`, `fix:`, etc.
- Examples of good commit messages from this repo:
  - `docs: Adding new sections to AI Studio: Plugins`
  - `chore: audit`
  - `fix: duplicate import in CDE local node page`

## Development Workflow

### Running Locally

```bash
# Requires Node.js LTS (22.x recommended, NOT 25+)
nvm use 22
npx mintlify dev
```

### Working on `dev` Branch (Revamp)

```bash
# Sync latest changes from main
# NOTE: Use merge-main.sh — NOT git merge main directly.
# docs.json always conflicts (dev has revamp nav, main has production nav).
# merge-main.sh auto-resolves the conflict and reports new pages needing attention.
git checkout dev
./revamp/merge-main.sh --dry-run   # preview first
./revamp/merge-main.sh             # stages merge, does NOT commit
git diff --cached --stat            # review what changed
git commit -S -s -m "Merge remote-tracking branch 'origin/main' into dev"

# Run migration to propagate hedera/ changes to new structure
./revamp/migrate.sh

# Acknowledge any warnings (if reported by migrate.sh):
# ./revamp/migrate.sh --ack-fixup=all    (sidebar fixup source changed)
# ./revamp/migrate.sh --ack=<source>     (protected page source changed)

# Create any new placeholder pages
./revamp/create-placeholders.sh

# Verify everything is correct (12 checks)
./revamp/verify.sh

# Test locally
nvm use 22 && npx mintlify dev
```

**When main adds a new page:** `merge-main.sh --dry-run` will report it. Before running migrate.sh, add:
1. An explicit mapping in `revamp/migrate.sh` → `get_explicit_mapping()`
2. A nav entry in `revamp/docs.json`
3. Optionally a sidebarTitle fixup in `revamp/sidebar-fixups.txt`

### Working on `main` Branch (Production)

Standard documentation edits — add/edit `.mdx` files under `hedera/`, update `docs.json` navigation if adding new pages.

## Code Conventions

- All documentation pages are `.mdx` files (MDX = Markdown + JSX components)
- Page paths in `docs.json` do NOT include the `.mdx` extension
- For `index.mdx` files, use the full path with `/index` suffix in `docs.json` (e.g., `"learn/core-concepts/index"` not `"learn/core-concepts"`)
- Mintlify components like `<Card>`, `<CardGroup>`, `<Info>`, `<Tabs>` are available in MDX files
- Snippet imports use absolute paths: `import Foo from '/snippets/foo.mdx'`
- Never duplicate imports in the same file (causes acorn parse errors)

## What NOT to Do

- Do not modify files in `hedera/` on the `dev` branch — only migrate FROM it
- Do not delete `hedera/` on `dev` — it's needed as the migration source
- Do not run `migrate.sh` on `main` — it's only for the `dev` branch
- Do not commit `hedera.backup.*` directories (they are gitignored)
- Do not add the revamp/ directory or new structure directories to `main` branch

## Triggers

When working in these areas, load the indicated context first:

| File Pattern | Load This Context |
|---|---|
| `revamp/*.sh` | `revamp/README.md` — migration script documentation, merge workflow, and how all systems work |
| `revamp/docs.json` or `docs.json` | Code Conventions section above — Mintlify nav format, `/index` suffix rules |
| `learn/`, `evm/`, `native/`, `operators/`, `reference/`, `solutions/`, `support/` | `revamp/plan.md` — full revamp architecture and tab/group structure |
| `snippets/` | Code Conventions section above — snippet import paths are absolute (`/snippets/...`) |
| `hedera/` | Working on `main` Branch section above — production edits only, no migration |

## Quality Gates

After editing files, `.claude/scripts/post-edit-check.sh` runs automatically via PostToolUse hook:
- Validates `docs.json` as valid JSON
- Checks MDX files for duplicate imports (causes acorn parse errors)

Run full validation manually: `./revamp/verify.sh`
