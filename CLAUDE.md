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

## Terminology

Developer facing docs pages must follow the EVM-address terminology standard defined below (this file is the source of truth). The public-facing definitions live in the [glossary](support/glossary.mdx). The retired terms below fail the **Terminology Check** workflow on PRs (word list: `.github/terminology-banned.txt`).

| Do not use | Use instead |
|-----------|-------------|
| "EVM Address Account Alias", "EVM alias", "EVM-address alias" | **EVM Address from Public Key** (or **EVM Address** unqualified) |
| "Account Number Alias" | **EVM Address from Account ID** |
| "Public Key Account Alias", "public key alias" | Remove the concept (retired) |

- Reserve `alias` for protocol/API surface (`setAlias()`, protobuf `AccountID.alias`, REST `?alias=`); leave `reference/` and `release-notes/` pages untouched.
- Lead with the concrete `0.0.<num>` account ID format, not the abstract `<shard>.<realm>.<num>`.

### Required messaging on account-creation pages (internal authoring rule)

Account-creation pages must lead with the benefit, not the risk. Include all four, in this priority:

1. **Positive default.** For EVM-oriented applications, create accounts with an ECDSA key and set the **EVM Address from Public Key** at creation (native compatibility with EVM wallets, JSON-RPC tooling, and smart-contract interactions).
2. **Immutability.** The EVM Address from Public Key is immutable; rotating keys with `CryptoUpdateTransaction` does not update it — it stays bound to the original ECDSA public key.
3. **Recovery model.** If keys are compromised or must be replaced, create a new ECDSA account with a new EVM address and migrate assets/state. Do not rely on key rotation to preserve the same EVM identity.
4. **Key-rotation conditional.** If the operational model expects key rotation soon after creation, defer setting the EVM Address from Public Key — present this as a conditional trade-off, not the headline.

Callout/comment framing: use `<Tip>` or `<Info>` next to recommended code, and reserve `<Warning>` for genuine anti-patterns. In code comments write `// Sets the EVM Address from Public Key (recommended)`, not `// DO NOT set an alias` — language models reproduce comments verbatim, so negative framing next to recommended code produces the wrong default. The Terminology Check cannot verify any of this messaging/structure; it is a reviewer responsibility.

## Quality Gates

After editing files, `.claude/scripts/post-edit-check.sh` runs automatically via a PostToolUse hook:
- Validates `docs.json` as valid JSON
- Checks MDX files for duplicate imports (causes acorn parse errors)
