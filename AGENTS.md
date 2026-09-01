# AGENTS.md: Hedera Documentation

Guidance for AI coding assistants (Cursor, Copilot, Gemini CLI, Aider, Windsurf, Devin, Jules, and others) contributing to this repository. This file mirrors the conventions in `CLAUDE.md`; if the two ever disagree, `CLAUDE.md` is authoritative.

> This file is for **contributors editing this repo**. It is different from `skill.md`, which targets **end-user agents building on Hedera at runtime**.

## Repository overview

This is the Hedera documentation portal, built with [Mintlify](https://mintlify.com). It holds all developer-facing documentation for the Hedera network, organized into a persona-driven 7-tab structure. All work happens on `main`; merging to `main` deploys to docs.hedera.com.

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

### Important files

- `docs.json`: Mintlify navigation, site configuration, and redirects.
- The `redirects` block in `docs.json` maps legacy `/hedera/*` URLs to their new locations. These exist for external inbound traffic and SEO after the docs revamp. **Do not remove them.** When you move or rename a page, add or update its redirect (and confirm the destination actually resolves; `mint broken-links` does NOT check redirect destinations).

## Commit rules

- This repo enforces **DCO**: every commit must have a `Signed-off-by` line. Always commit with `git commit -s` (add `-S` to GPG-sign). Merge commits are exempt; unsigned commits must be fixed with `git rebase --signoff`.
- **Never** add `Co-Authored-By` lines to commit messages.
- **Never** mention AI, an assistant, or a specific AI tool in commit messages.
- Write commit messages in the style of existing commits: short, imperative, prefixed with `docs:`, `chore:`, `fix:`, etc.

## Development workflow

### Running locally

```bash
# Requires Node.js 22.x (NOT 25+)
nvm use 22
mint dev          # or: npx mintlify dev   -> serves at localhost:3000
```

Standard edits: add or edit `.mdx` files under the tab directories, and update `docs.json` navigation when adding, moving, or removing pages.

### Validation before pushing

```bash
mint broken-links   # validates internal links (does NOT check redirect destinations)
```

## Code conventions

- All documentation pages are `.mdx` files (MDX = Markdown + JSX components).
- Page paths in `docs.json` do NOT include the `.mdx` extension.
- For `index.mdx` files, use the full path with an `/index` suffix in `docs.json` (e.g. `"learn/core-concepts/index"`, not `"learn/core-concepts"`).
- Mintlify components like `<Card>`, `<CardGroup>`, `<Info>`, `<Tabs>` are available in MDX files.
- Snippet imports use absolute paths: `import Foo from '/snippets/foo.mdx'`.
- Never duplicate imports in the same file (causes acorn parse errors).
- In-body links use direct, absolute new-structure paths (e.g. `/native/tokens/define`). Never link to legacy `/hedera/...` paths, and avoid fragile `../` relative paths across tabs.
- Author all tables as Markdown, never HTML `<table>` tags.
- **Hiding a page:** set `hidden: true` (boolean, not the string `"true"`) in frontmatter **and** omit it from `docs.json` navigation.
- Every page should have a 1–2 sentence `description` in its frontmatter. Mintlify uses it for `llms.txt`, AI/search snippets, and the MCP search results, so it directly affects AI discoverability.

## Terminology

Developer-facing pages must follow the EVM-address terminology standard. The public definitions live in the [glossary](support/glossary.mdx). Retired terms below fail the **Terminology Check** CI workflow (word list: `.github/terminology-banned.txt`).

| Do not use | Use instead |
|-----------|-------------|
| "EVM Address Account Alias", "EVM alias", "EVM-address alias" | **EVM Address from Public Key** (or **EVM Address** unqualified) |
| "Account Number Alias" | **EVM Address from Account ID** |
| "Public Key Account Alias", "public key alias" | Remove the concept (retired) |

- Reserve `alias` for protocol/API surface (`setAlias()`, protobuf `AccountID.alias`, REST `?alias=`); leave `reference/` and `release-notes/` pages untouched.
- Lead with the concrete `0.0.<num>` account ID format, not the abstract `<shard>.<realm>.<num>`.
- Hedera is a distributed ledger that uses hashgraph consensus. Do not call it a blockchain.
- Write HBAR uppercase and singular; tinybars lowercase and plural; network names (`mainnet`, `testnet`, `previewnet`) lowercase even after "Hedera".
- The Hiero SDKs are migrating from the `@hashgraph` namespace to `@hiero-ledger`. Both work; prefer `@hiero-ledger` for new projects.

## Quality gates

Pull requests run CI including a **Terminology Check** (`.github/workflows/terminology-check.yml`) over changed `.mdx` files. Validate `docs.json` as valid JSON and check MDX files for duplicate imports before pushing.
