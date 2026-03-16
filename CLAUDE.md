# CLAUDE.md — Hedera Documentation

## Repository Overview

This is the Hedera documentation portal, built with [Mintlify](https://mintlify.com). It contains all developer-facing documentation for the Hedera network.

### Branch Strategy

- **`main`** — Production branch. All documentation updates (new pages, content edits, fixes) land here. The `hedera/` directory is the source of truth for the current live documentation.
- **`dev`** — Revamp branch. Contains the new 7-tab documentation structure (`learn/`, `evm/`, `native/`, `operators/`, `reference/`, `solutions/`, `support/`) plus migration tooling in `revamp/`. Periodically synced from `main` via `git merge main`, then `./revamp/migrate.sh` to propagate changes.

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
- `revamp/migrate.sh` — Migrates content from `hedera/` to the new structure
- `revamp/create-placeholders.sh` — Creates placeholder pages for new content
- `revamp/verify.sh` — Validates migration integrity (nav refs, coverage, orphans)
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
git checkout main && git pull
git checkout dev && git merge main

# Run migration to propagate hedera/ changes to new structure
./revamp/migrate.sh

# Create any new placeholder pages
./revamp/create-placeholders.sh

# Verify everything is correct
./revamp/verify.sh

# Test locally
nvm use 22 && npx mintlify dev
```

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
