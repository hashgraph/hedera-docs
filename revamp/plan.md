## **Problems with Current Structure**

| **Issue** | **Impact** |
| --- | --- |
| **Deep nesting (5+ levels)** | Users get lost, hard to find content |
| **Mixed personas in same sections** | EVM developers see SDK content they don't need |
| **Tutorials scattered** | Hard to follow learning paths |
| **Core Concepts buried** | New users don't understand fundamentals |
| **No clear "getting started" flow** | High bounce rate for newcomers |
| **API/SDK reference overwhelming** | 200+ pages in single section |
| **Enterprise content missing dedicated section** | Enterprise users can't find compliance/security info |
| **No clear separation between Learn/Build/Deploy** | Users at different stages mixed together |

## **Persona Model**

```markdown
┌─────────────────────────────────────────────────────────────────────────────────────────┐
│                                    HEDERA DEVELOPERS                                     │
├─────────────────────────────────────────────────────────────────────────────────────────┤
│                                                                                          │
│  ┌──────────────────────┐    ┌──────────────────────┐    ┌──────────────────────────┐   │
│  │  📱 APPLICATION      │    │  🖥️ INFRASTRUCTURE   │    │  📚 EVERYONE             │   │
│  │     DEVELOPERS       │    │     OPERATORS        │    │     (Reference)          │   │
│  ├──────────────────────┤    ├──────────────────────┤    ├──────────────────────────┤   │
│  │                      │    │                      │    │                          │   │
│  │  ┌────────────────┐  │    │  • Mirror Node       │    │  • Core Concepts         │   │
│  │  │ EVM Developers │  │    │  • JSON-RPC Relay    │    │  • Network Info          │   │
│  │  │ (Smart         │  │    │  • Block Node        │    │  • API Reference         │   │
│  │  │  Contracts)    │  │    │  • Consensus Node    │    │  • SDK Reference         │   │
│  │  └────────────────┘  │    │    (Council only)    │    │                          │   │
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

## **Revised Navigation Architecture**

```markdown
┌─────────────────────────────────────────────────────────────────────────────────────────────────────────┐
│  [Logo]  │  Learn  │  EVM Developers  │  Native SDKs  │  Open Source Solutions | Operators  │  Reference
└─────────────────────────────────────────────────────────────────────────────────────────────────────────┘
                                    ↑ TOP TABS ↑
```

**Tab Purposes:**

- **Learn** - Core concepts, what is Hedera, fundamentals (for everyone)
- **EVM Developers** - Smart contract developers using Solidity + optional Hedera precompiles
- **Native SDKs** - Enterprise/backend developers using JS/Java/Go/Rust SDKs
- **Open Source Solutions** - Highlight ecosystem projects like studios, other open source solutions, etc
- **Operators** - Infrastructure operators (Mirror Node, JSON-RPC, Block Node, Consensus Node)
- **Reference** - API docs, SDK reference, protobuf specs (for everyone)

---

## **Complete New Structure with Content Mapping**

### **Legend for Content Status**

- ✅ **EXISTING** - Content exists, needs migration
- 🆕 **NEW** - Content needs to be created
- 🔄 **MERGED** - Multiple existing pages merged into one
- 📍 **MOVED** - Content moved from different section
## **Visual Navigation Map**

```markdown
┌─────────────────────────────────────────────────────────────────────────────────────────────────────┐
│                                      HEDERA DOCUMENTATION                                            │
├─────────────────────────────────────────────────────────────────────────────────────────────────────┤
│   🎓 LEARN          │  🟣 EVM DEVELOPERS   │  🔷 NATIVE SDKs    │  🖥️ OPERATORS    │  📖 REFERENCE  │
├─────────────────────────────────────────────────────────────────────────────────────────────────────┤
│                     │                      │                    │                   │                │
│  Getting Started    │  Quick Start         │  Quick Start       │  Mirror Nodes     │  REST API      │
│  • What is Hedera   │  • MetaMask Setup    │  • JS Quickstart   │  • Public         │  • Accounts    │
│  • For EVM Devs     │  • Deploy Remix      │  • Java Quickstart │  • Run Your Own   │  • Tokens      │
│  • For Enterprise   │  • Deploy Hardhat    │  • Go Quickstart   │  • One-Click      │  • Contracts   │
│  • Create Account   │  • Deploy Foundry    │                    │                   │  • Topics      │
│  • Get Test HBAR    │                      │  SDK Fundamentals  │  JSON-RPC Relay   │  • Txns        │
│                     │  EVM Differences ⚠️  │  • Client          │  • Public         │                │
│  Core Concepts      │  • Accounts/Sigs     │  • Keys            │  • Run Your Own   │  Protobuf API  │
│  • Hashgraph        │  • Decimals (8v18)   │  • Transactions    │                   │  • Types       │
│  • Accounts         │  • HBAR Transfers    │  • Queries         │  Block Node       │  • Services    │
│  • Transactions     │  • JSON-RPC          │                    │  (Coming Soon)    │                │
│  • Tokens           │                      │  Hedera Services   │                   │  HCS gRPC API  │
│  • Smart Contracts  │  Development         │  • Accounts/HBAR   │  Consensus Nodes  │                │
│  • Consensus (HCS)  │  • Creating          │  • Tokens (HTS)    │  • Requirements   │  Status API    │
│  • Files (HFS)      │  • Compiling         │  • Consensus (HCS) │  • Deployment     │                │
│  • Staking          │  • Deploying         │  • Files (HFS)     │  (Council Only)   │                │
│  • Mirror Nodes     │  • Verifying         │  • Scheduled Txns  │                   │                │
│                     │  • Traceability      │  • Smart Contracts │  Operations       │                │
│  Networks           │                      │                    │  • Best Practices │                │
│  • Mainnet          │  ERC Standards       │  Tutorials         │  • Monitoring     │                │
│  • Testnet          │  • ERC-20            │  • Getting Started │                   │                │
│  • Localnet         │  • ERC-721           │  • Token Tutorials │                   │                │
│                     │  • ERC-1363          │  • HCS Tutorials   │                   │                │
│  Comparisons        │  • ERC-3643 (RWA)    │  • Scheduled Txns  │                   │                │
│  • vs Ethereum      │  • WHBAR             │  • Advanced        │                   │                │
│  • vs Solana        │                      │  • Enterprise      │                   │                │
│  • Why Hedera       │  System Contracts ⭐ │                    │                   │                │
│                     │  • HTS Precompile    │  Local Development │                   │                │
│  Release Notes      │  • Account Service   │  • Local Node      │                   │                │
│                     │  • Schedule Service  │  • Gitpod          │                   │                │
│                     │                      │  • Codespaces      │                   │                │
│                     │  Tools               │                    │                   │                │
│                     │  • Hardhat Setup     │  Integrations      │                   │                │
│                     │  • Foundry Setup     │  • AI Agent Kit    │                   │                │
│                     │  • Truffle           │  • ElizaOS         │                   │                │
│                     │  • The Graph         │  • Hivemind        │                   │                │
│                     │  • Contract Builder  │  • WalletConnect   │                   │                │
│                     │                      │                    │                   │                │
│                     │  Tutorials           │                    │                   │                │
│                     │  • Send/Recv HBAR    │                    │                   │                │
│                     │  • ERC-721 Series    │                    │                   │                │
│                     │  • HTS+EVM Series    │                    │                   │                │
│                     │  • HSS+EVM Series    │                    │                   │                │
│                     │                      │                    │                   │                │
│                     │  Integrations        │                    │                   │                │
│                     │  • Chainlink         │                    │                   │                │
│                     │  • Pyth              │                    │                   │                │
│                     │  • LayerZero         │                    │                   │                │
│                     │  • WalletConnect     │                    │                   │                │
│                     │  • MetaMask Snap     │                    │                   │                │
└─────────────────────────────────────────────────────────────────────────────────────────────────────┘

                                               💼 SOLUTIONS TAB
┌─────────────────────────────────────────────────────────────────────────────────────────────────────┐
│  Tokenization          │  Governance       │  Sustainability   │  Dev Tools        │  Resources     │
│  • ATS                 │  • HashioDAO      │  • Guardian       │  • Hedera CLI     │  • Demos       │
│  • Stablecoin Studio   │                   │                   │  • Playground     │  • Starters    │
│  • NFT Studio          │                   │                   │  • Code Repo      │  • Building On │
└─────────────────────────────────────────────────────────────────────────────────────────────────────┘
```

---

## **User Journeys (Updated)**

### **🆕 New Developer - "I don't know where to start"**

```markdown
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

### **🟣 EVM Developer Journey**

```markdown
EVM Developers → Quick Start → Add to MetaMask → Deploy with Hardhat
                                                        ↓
                                        EVM Differences (IMPORTANT)
                                        • Decimals, HBAR transfers, etc.
                                                        ↓
                                        System Contracts (Hedera Superpowers)
                                        • HTS Precompile for native tokens
                                        • Schedule Service for automation
                                                        ↓
                                        Tutorials → HTS+EVM Series
                                                        ↓
                                        Reference → REST API (for reading data)
```

### **🔷 Native SDK Developer Journey**

```markdown
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

### **Infrastructure Operator Journey**

```markdown
Operators → Overview → "What do I want to run?"
                              ↓
         ┌────────────────────┼────────────────────┐
         ↓                    ↓                    ↓
    Mirror Node          JSON-RPC Relay       Block Node
         ↓                    ↓                    ↓
    Run Your Own         Run Your Own         (Coming Soon)
    • GCS Setup          • Self-hosting
    • S3 Setup           guide
         ↓                    ↓
    Operations → Monitoring → Best Practices
```

---

## **Cross-References Between Tabs**

To ensure consistency and avoid confusion:

| **When user is in...** | **They should see links to...** |
| --- | --- |
| EVM → System Contracts | Learn → Core Concepts → Tokens (for HTS concepts) |
| EVM → Deploy | Learn → Networks (for network endpoints) |
| Native → Tokens | Learn → Core Concepts → Tokens (for concepts) |
| Native → Local Dev | Operators → Mirror Nodes (if they need to query data) |
| Operators → Any | Reference → REST API (for API details) |
| Learn → Core Concepts | "Ready to build?" → Links to EVM or Native tabs |

---

## Dev-Only Content (Not Migrated from `hedera/`)

Some pages on the `dev` branch are authored directly — they have no source in `hedera/` and are **never overwritten by `migrate.sh`**. These are new content unique to the revamp.

### Fully Dev-Authored Pages (safe from migration by design)

| File | Why dev-only |
|---|---|
| `learn/getting-started/index.mdx` | New section hub for the 4-page onboarding journey |
| `learn/getting-started/what-is-hedera.mdx` | Foundational intro written for revamp |
| `learn/getting-started/why-hedera.mdx` | Value proposition page, new content |
| `learn/getting-started/choose-your-path.mdx` | Persona funnel (most critical UX page), new content |

These are safe because `migrate.sh` only writes files that have a mapping in `get_explicit_mapping()` or `get_directory_mapping()`. Pages with no `hedera/` source are never touched.

### Protected Pages (have a mapping, but are manually maintained on dev)

Some pages have a source mapping in `migrate.sh` but the dev version is so structurally different that auto-sync would destroy the revamp content. These are tracked in `revamp/protected-pages.txt`.

| Source (`hedera/`) | Destination (dev) | Why Protected |
|---|---|---|
| `hedera/readme.mdx` | `learn/index.mdx` | Dev version links to new 7-tab structure; source is old root README with hedera/ links |

**Workflow for protected pages:**
1. `git merge main` brings changes to `hedera/` onto dev
2. Run `./revamp/migrate.sh` — warns if a protected source changed
3. Review the source diff manually and incorporate relevant content into the destination
4. Run `./revamp/migrate.sh --ack=<source_path>` to acknowledge and silence the warning
5. `./revamp/verify.sh` Check 9 also reports unacknowledged changes

**To add a new protected page:**
1. Keep the mapping in `migrate.sh` `get_explicit_mapping()` (for documentation)
2. Add an entry to `revamp/protected-pages.txt` with `$(git hash-object <source>)`
3. Rewrite the destination on `dev` as needed

### Nav-Only Changes (`docs.json` / `revamp/docs.json`)

`migrate.sh` installs `revamp/docs.json` → `docs.json`. All nav changes (new groups, page additions, reordering) must be made to `revamp/docs.json`. That file is the source of truth for navigation on dev.
