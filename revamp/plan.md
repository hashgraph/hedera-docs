# Hedera Docs Revamp — Architecture Plan

## Problems with the Original Structure

| **Issue** | **Impact** |
| --- | --- |
| **Deep nesting (5+ levels)** | Users get lost, hard to find content |
| **Mixed personas in same sections** | EVM developers see SDK content they don't need |
| **Tutorials scattered** | Hard to follow learning paths |
| **Core Concepts buried** | New users don't understand fundamentals |
| **No clear "getting started" flow** | High bounce rate for newcomers |
| **API/SDK reference overwhelming** | 200+ pages in single section |
| **No clear separation between Learn/Build/Deploy** | Users at different stages mixed together |
| **Open Source Solutions mixed with developer tools** | Hard to distinguish ecosystem projects from core docs |

---

## Persona Model

```
┌─────────────────────────────────────────────────────────────────────────────────────────┐
│                                    HEDERA DEVELOPERS                                     │
├─────────────────────────────────────────────────────────────────────────────────────────┤
│                                                                                          │
│  ┌──────────────────────┐    ┌──────────────────────┐    ┌──────────────────────────┐   │
│  │  APPLICATION         │    │  INFRASTRUCTURE      │    │  EVERYONE                │   │
│  │  DEVELOPERS          │    │  OPERATORS           │    │  (Reference/Support)     │   │
│  ├──────────────────────┤    ├──────────────────────┤    ├──────────────────────────┤   │
│  │                      │    │                      │    │                          │   │
│  │  ┌────────────────┐  │    │  • Mirror Node       │    │  • Core Concepts         │   │
│  │  │ EVM Developers │  │    │  • JSON-RPC Relay    │    │  • Network Info          │   │
│  │  │ (Smart         │  │    │  • Block Node        │    │  • API Reference         │   │
│  │  │  Contracts)    │  │    │  • Consensus Node    │    │  • SDK Reference         │   │
│  │  └────────────────┘  │    │    (Council only)    │    │  • FAQs / Glossary       │   │
│  │         │            │    │                      │    │                          │   │
│  │         │ Can use    │    └──────────────────────┘    └──────────────────────────┘   │
│  │         │ precompiles│                                                               │
│  │         ↓            │                                                               │
│  │  ┌────────────────┐  │                                                               │
│  │  │ Native SDK     │  │                                                               │
│  │  │ Developers     │  │                                                               │
│  │  │ (Enterprise/   │  │                                                               │
│  │  │  Backend)      │  │                                                               │
│  │  └────────────────┘  │                                                               │
│  └──────────────────────┘                                                               │
└─────────────────────────────────────────────────────────────────────────────────────────┘
```

---

## Navigation Architecture (Current - 7 Tabs)

```
┌──────────────────────────────────────────────────────────────────────────────────────────────────┐
│  [Logo]  │  Learn  │  EVM Developers  │  Native SDKs  │  Solutions  │  Operators  │  Reference  │  Support
└──────────────────────────────────────────────────────────────────────────────────────────────────┘
```

**Tab Purposes:**

- **Learn** - Core concepts, what is Hedera, fundamentals (for everyone)
- **EVM Developers** - Smart contract developers using Solidity + optional Hedera precompiles
- **Native SDKs** - Enterprise/backend developers using JS/Java/Go/Rust SDKs
- **Solutions** - Open source ecosystem projects: AI Studio, tokenization, governance, tooling
- **Operators** - Infrastructure operators (Mirror Node, JSON-RPC Relay, Consensus Node)
- **Reference** - API docs, SDK reference, protobuf specs (for everyone)
- **Support** - FAQs, contributing guides, glossary, brand guidelines, community

---

## Visual Navigation Map

```
┌─────────────────────────────────────────────────────────────────────────────────────────────────────┐
│                                      HEDERA DOCUMENTATION                                            │
├─────────────────────────────────────────────────────────────────────────────────────────────────────┤
│   LEARN             │  EVM DEVELOPERS      │  NATIVE SDKs       │  OPERATORS        │  REFERENCE     │
├─────────────────────────────────────────────────────────────────────────────────────────────────────┤
│                     │                      │                    │                   │                │
│  Getting Started    │  Quick Start         │  Quick Start       │  Mirror Nodes     │  REST API      │
│  • What is Hedera   │  • MetaMask Setup    │  • JS Quickstart   │  • Public         │  • Accounts    │
│  • Why Hedera       │  • Deploy Remix      │  • Java Quickstart │  • Run Your Own   │  • Tokens      │
│  • Choose Your Path │  • Deploy Hardhat    │  • Go Quickstart   │  • One-Click      │  • Contracts   │
│  • Create Account   │  • Deploy Foundry    │                    │                   │  • Topics      │
│  • Get Test HBAR    │                      │  SDK Fundamentals  │  JSON-RPC Relay   │  • Txns        │
│                     │  Development         │  • Client          │  • Public         │                │
│  Core Concepts      │  • Creating          │  • Keys            │  • Run Your Own   │  Protobuf API  │
│  • Hashgraph        │  • Compiling         │  • Transactions    │                   │  • Types       │
│  • Accounts         │  • Deploying         │  • Queries         │  Consensus Nodes  │  • Services    │
│  • Transactions     │  • Verifying         │                    │  • Requirements   │                │
│  • Tokens           │  • Traceability      │  Hedera Services   │  • Deployment     │  HCS gRPC API  │
│  • Smart Contracts  │  • JSON-RPC          │  • Accounts/HBAR   │  (Council Only)   │                │
│  • Consensus (HCS)  │                      │  • Tokens (HTS)    │                   │  Status API    │
│  • Files (HFS)      │  EVM Differences     │  • Consensus (HCS) │                   │                │
│  • Staking          │  • Accounts/Sigs     │  • Files (HFS)     │                   │  Verification  │
│  • Mirror Nodes     │  • Decimals (8v18)   │  • Scheduled Txns  │                   │  API           │
│                     │  • HBAR Transfers    │  • Smart Contracts │                   │                │
│  Networks           │  • For Native Devs   │  • Sig Provider    │                   │                │
│  • Mainnet          │                      │                    │                   │                │
│  • Testnet          │  ERC Token Standards │  Tutorials         │                   │                │
│  • Localnet         │  • ERC-20            │  • Getting Started │                   │                │
│                     │  • ERC-721           │  • Token Tutorials │                   │                │
│  Release Notes      │  • ERC-1363          │  • HCS Tutorials   │                   │                │
│  • Consensus Node   │  • ERC-3643 (RWA)    │  • Scheduled Txns  │                   │                │
│  • Mirror Node      │  • WHBAR             │  • Advanced        │                   │                │
│                     │                      │  • HSM Signing     │                   │                │
│                     │  Hedera-Native       │  • HCS Fabric      │                   │                │
│                     │  • System Contracts  │                    │                   │                │
│                     │  • HTS from Solidity │  Local Development │                   │                │
│                     │  • Hybrid Tokeniz.   │  • Local Node      │                   │                │
│                     │                      │  • Gitpod          │                   │                │
│                     │  Tools               │  • Codespaces      │                   │                │
│                     │  • Hardhat Setup     │                    │                   │                │
│                     │  • Foundry Setup     │  Integrations      │                   │                │
│                     │  • Other (Truffle,   │  (index only —     │                   │                │
│                     │    The Graph, etc.)  │   AI content moved │                   │                │
│                     │  • Contract Builder  │   to Solutions)    │                   │                │
│                     │                      │                    │                   │                │
│                     │  Tutorials           │                    │                   │                │
│                     │  • Send/Recv HBAR    │                    │                   │                │
│                     │  • ERC-721 Series    │                    │                   │                │
│                     │  • HTS+EVM Series    │                    │                   │                │
│                     │  • HSS+EVM Series    │                    │                   │                │
│                     │  • JSON-RPC Series   │                    │                   │                │
│                     │                      │                    │                   │                │
│                     │  Integrations        │                    │                   │                │
│                     │  • Oracles           │                    │                   │                │
│                     │    (Chainlink, Pyth, │                    │                   │                │
│                     │     Supra)           │                    │                   │                │
│                     │  • Cross-Chain       │                    │                   │                │
│                     │    (LayerZero, CCIP) │                    │                   │                │
│                     │  • Wallets           │                    │                   │                │
│                     │    (WalletConnect,   │                    │                   │                │
│                     │     MetaMask Snap)   │                    │                   │                │
│                     │                      │                    │                   │                │
│                     │  Troubleshooting     │                    │                   │                │
└─────────────────────────────────────────────────────────────────────────────────────────────────────┘

                                           SOLUTIONS TAB
┌─────────────────────────────────────────────────────────────────────────────────────────────────────┐
│  Tokenization              │  AI & Agents          │  Governance       │  Sustainability             │
│  • ATS                     │  • AI Studio (index)  │  • HashioDAO      │  • Guardian                 │
│  • Stablecoin Studio       │  • Agent Lab          │    - Gov Token    │                             │
│  • NFT Studio              │  • Agent Kit          │    - NFT DAO      │  Developer Tools            │
│                            │    - JS               │    - Multisig     │  • Hiero CLI                │
│                            │    - Python           │    - Proposals    │  • Playground               │
│                            │  • ElizaOS Plugin     │    - Local Setup  │  • Code Repo                │
│                            │  • AI Tools           │                   │  • Custodians Library       │
│                            │    - Hivemind         │                   │  • Wallet Snap Intro        │
│                            │    - Kapa AI          │                   │                             │
│                            │                       │                   │  Examples                   │
│                            │                       │                   │  • Demos                    │
│                            │                       │                   │  • Starters                 │
│                            │                       │                   │  • Building On Hedera       │
└─────────────────────────────────────────────────────────────────────────────────────────────────────┘

                                            SUPPORT TAB
┌─────────────────────────────────────────────────────────────────────────────────────────────────────┐
│  FAQs                    │  Contributing           │  Glossary         │  Brand Guidelines            │
│  • General               │  • Guidelines           │                   │                             │
│  • HTS                   │  • Style Guide          │                   │  Community & Resources       │
│  • Smart Contracts       │                         │                   │                             │
│  • Mirror Nodes          │                         │                   │                             │
└─────────────────────────────────────────────────────────────────────────────────────────────────────┘
```

---

## User Journeys

### New Developer - "I don't know where to start"

```
Learn → Getting Started → What is Hedera
                              ↓
                    "Choose your path"
                              ↓
         ┌────────────────────┴────────────────────┐
         ↓                                         ↓
    "I know Solidity"                    "I'm building backend/enterprise"
         ↓                                         ↓
    EVM Developers Tab                    Native SDKs Tab
         ↓                                         ↓
    Quick Start → Deploy with Hardhat     Quick Start → JS Quickstart
```

### EVM Developer Journey

```
EVM Developers → Quick Start → Add to MetaMask → Deploy with Hardhat
                                                        ↓
                                        EVM Differences (IMPORTANT)
                                        • Decimals, HBAR transfers, etc.
                                                        ↓
                                        Hedera-Native Features
                                        • HTS Precompile for native tokens
                                        • Schedule Service for automation
                                                        ↓
                                        Tutorials → HTS+EVM Series
                                                        ↓
                                        Reference → REST API (for reading data)
```

### Native SDK Developer Journey

```
Native SDKs → Quick Start → JavaScript Quickstart
                                   ↓
                    Choose what to build:
        ┌──────────┬──────────┬──────────┬──────────┐
        ↓          ↓          ↓          ↓          ↓
    Accounts   Tokens(HTS)  Consensus  Files    Scheduled
        ↓          ↓          ↓          ↓          ↓
    Create    Create Token  Create    Create    Create
    Transfer  Mint/Burn    Submit Msg Append    Schedule
    etc.      Transfer     Subscribe  etc.      Sign
                                                        ↓
                                        Reference → Protobuf API (deep dive)
```

### Infrastructure Operator Journey

```
Operators → Overview → "What do I want to run?"
                              ↓
         ┌────────────────────┼────────────────────┐
         ↓                    ↓                    ↓
    Mirror Node          JSON-RPC Relay       Consensus Node
         ↓                    ↓                    ↓
    Run Your Own         Run Your Own         (Council only)
    • GCS Setup          • Self-hosting
    • S3 Setup           guide
```

### AI / Solutions Developer Journey

```
Solutions → AI & Agents → AI Studio (index)
                              ↓
              ┌───────────────┼──────────────────┐
              ↓               ↓                  ↓
          Agent Lab       Agent Kit           AI Tools
                         • JS / Python        • Hivemind
                         • Plugins            • Kapa AI
                         • ElizaOS Plugin
```

---

## Cross-References Between Tabs

| **When user is in...** | **They should see links to...** |
| --- | --- |
| EVM → Hedera-Native Features | Learn → Core Concepts → Tokens (for HTS concepts) |
| EVM → Deploy | Learn → Networks (for network endpoints) |
| Native → Tokens | Learn → Core Concepts → Tokens (for concepts) |
| Native → Local Dev | Operators → Mirror Nodes (if they need to query data) |
| Operators → Any | Reference → REST API (for API details) |
| Learn → Core Concepts | "Ready to build?" → Links to EVM or Native tabs |
| Solutions → AI Studio | Native SDKs (for SDK usage context) |

---

## Content Authoring Model

### Source of Truth

All migrated content originates from `hedera/` on the `main` branch. The `dev` branch consumes it via `revamp/migrate.sh`, which maps each `hedera/` source to a destination in the new 7-tab structure.

### Three Categories of Pages on `dev`

**1. Migrated pages** — sourced from `hedera/`, automatically synced by `migrate.sh`.
Explicit mappings live in `get_explicit_mapping()` in `migrate.sh`. Directory fallback rules cover new pages in known sections automatically.

**2. Dev-authored pages** — no source in `hedera/`, never touched by `migrate.sh`.

| File | Purpose |
|---|---|
| `learn/getting-started/index.mdx` | Section hub for the onboarding journey |
| `learn/getting-started/what-is-hedera.mdx` | Foundational intro written for revamp |
| `learn/getting-started/why-hedera.mdx` | Value proposition page |
| `learn/getting-started/choose-your-path.mdx` | Persona funnel (critical UX page) |

**3. Protected pages** — have a mapping in `migrate.sh` but are manually maintained on `dev` because the dev version diverges significantly from the source. Tracked in `revamp/protected-pages.txt`.

| Source (`hedera/`) | Destination (dev) | Why Protected |
|---|---|---|
| `hedera/readme.mdx` | `learn/index.mdx` | Dev version links to 7-tab structure; source is old root README |

---

## Migration Tooling

All tooling lives in `revamp/`. See `revamp/README.md` for full documentation.

### Syncing `dev` with `main`

**Never use `git merge main` directly** - `docs.json` always conflicts because `dev` has the 7-tab revamp nav and `main` has the production nav. Use `merge-main.sh` instead:

```bash
./revamp/merge-main.sh --dry-run   # preview: shows new pages needing attention
./revamp/merge-main.sh             # stages merge (does NOT commit)
git diff --cached --stat
git commit -S -s -m "Merge remote-tracking branch 'origin/main' into dev"
./revamp/migrate.sh                # propagate content changes to revamp structure
./revamp/verify.sh                 # validate all 12 checks pass
git add -A && git commit -S -s -m "docs: sync dev with main (<hash> — <description>)"
```

### When Main Adds a New Page

`merge-main.sh --dry-run` will report it. Before running `migrate.sh`, add:
1. An explicit mapping in `revamp/migrate.sh` → `get_explicit_mapping()`
2. A nav entry in `revamp/docs.json`
3. Optionally a sidebarTitle fixup in `revamp/sidebar-fixups.txt`

### Mapping Convention for `open-source-solutions/`

Pages under `hedera/open-source-solutions/` map to `solutions/` by default — **not** `native/`. Subcategory guidance:

| Source prefix | Maps to |
|---|---|
| `ai-studio-on-hedera/` | `solutions/ai/` |
| `ai-tools-for-developers/` | `solutions/ai/tools/` |
| `asset-tokenization-studio-ats/` | `solutions/tokenization/ats/` |
| `stablecoin-studio/` | `solutions/tokenization/stablecoin/` |
| `nft-studio/` | `solutions/tokenization/nft-studio/` |
| `hashiodao/` | `solutions/governance/hashiodao/` |
| `oracle-networks/` | `evm/integrations/oracles/` |
| `interoperability-and-bridging/` | `evm/integrations/cross-chain/` |
| EVM wallets (WalletConnect, MetaMask Snap) | `evm/integrations/wallets/` |

### Key Script Reference

| Script | Purpose |
|---|---|
| `revamp/merge-main.sh` | Safe merge of `origin/main` → `dev`; auto-resolves `docs.json` conflict |
| `revamp/migrate.sh` | Syncs `hedera/` content into 7-tab structure; idempotent |
| `revamp/verify.sh` | Runs 12 integrity checks (nav refs, coverage, orphans, parity, etc.) |
| `revamp/create-placeholders.sh` | Creates stub pages for new content slots |
| `revamp/docs.json` | Source of truth for `dev` nav (installed to `docs.json` by `migrate.sh`) |
| `revamp/sidebar-fixups.txt` | Overrides for sidebarTitle values that differ from page title |
| `revamp/protected-pages.txt` | Registry of pages that are manually maintained on `dev` |
| `revamp/sync-log.md` | Log of every `migrate.sh` run, newest first |
