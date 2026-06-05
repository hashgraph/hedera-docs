# CLAUDE.md — Hedera Documentation

## Repository Overview

This is the Hedera documentation portal, built with [Mintlify](https://mintlify.com). It contains all developer-facing documentation for the Hedera network, organized into a persona-driven 7-tab structure. All work happens on `main`; merging to `main` deploys to docs.hedera.com.

### Key Directories

| Directory | Purpose |
|-----------|---------|
| `learn/` | Core concepts, getting started, networks, release notes |
| `evm/` | Smart contracts, ERC tokens, tooling, EVM integrations, differences |
| `native/` | SDK reference, tutorials, native integrations |
| `operators/` | Mirror nodes, JSON-RPC relay, consensus nodes |
| `reference/` | REST API, Protobuf API, HCS gRPC, status & verification APIs |
| `solutions/` | Tokenization studios, governance, AI, sustainability, tools |
| `support/` | FAQs, contributing guide, style guide, glossary |
| `snippets/` | Reusable MDX snippet components (imported with absolute `/snippets/...` paths) |
| `images/` | Documentation images |

### Important Files

- `docs.json` — Mintlify navigation, site configuration, and redirects.
- The `redirects` block in `docs.json` maps legacy `/hedera/*` URLs to their new locations. These exist for external inbound traffic and SEO after the docs revamp — **do not remove them**, and when you move or rename a page, add/update its redirect (and confirm the destination actually resolves — `mint broken-links` does NOT check redirect destinations).

## Commit Rules

- This repo enforces **DCO**: every commit must have a `Signed-off-by` line. Always commit with `git commit -s` (and `-S` to GPG-sign). Merge commits are exempt; remediation commits are **not** enabled, so unsigned commits must be fixed with `git rebase --signoff`.
- **NEVER** add `Co-Authored-By` lines to commit messages.
- **NEVER** mention Claude, AI, or assistant in commit messages.
- Write commit messages in the style of existing commits: short, imperative, prefixed with `docs:`, `chore:`, `fix:`, etc.

## Development Workflow

### Running Locally

```bash
# Requires Node.js 22.x (NOT 25+)
nvm use 22
mint dev          # or: npx mintlify dev   -> serves at localhost:3000
```

Standard edits: add/edit `.mdx` files under the tab directories, and update `docs.json` navigation if adding, moving, or removing pages.

### Validation before pushing

```bash
mint broken-links   # validates internal links (note: does NOT check redirect destinations)
```

## Code Conventions

- All documentation pages are `.mdx` files (MDX = Markdown + JSX components).
- Page paths in `docs.json` do NOT include the `.mdx` extension.
- For `index.mdx` files, use the full path with `/index` suffix in `docs.json` (e.g., `"learn/core-concepts/index"`, not `"learn/core-concepts"`).
- Mintlify components like `<Card>`, `<CardGroup>`, `<Info>`, `<Tabs>` are available in MDX files.
- Snippet imports use absolute paths: `import Foo from '/snippets/foo.mdx'`.
- Never duplicate imports in the same file (causes acorn parse errors).
- In-body links use direct, absolute new-structure paths (e.g. `/native/tokens/define`). Never link to legacy `/hedera/...` paths, and avoid fragile `../` relative paths across tabs.
- **Hiding a page:** set `hidden: true` (boolean, not the string `"true"`) in frontmatter **and** omit it from `docs.json` navigation. The cloud renderer does not reliably honor `hidden:` for pages that are still listed in nav, so removal from nav is the dependable way to hide.

## Quality Gates

After editing files, `.claude/scripts/post-edit-check.sh` runs automatically via a PostToolUse hook:
- Validates `docs.json` as valid JSON
- Checks MDX files for duplicate imports (causes acorn parse errors)
