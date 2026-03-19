# Revamp Gap Analysis — Plan vs. Implemented

**Date:** 2026-03-19
**Last updated:** 2026-03-19
**Status:** 599 total pages in new structure, 536 migrated, 59 placeholders remaining (4 written this session)

---

## What's DONE

- [x] 7-tab navigation in `docs.json` (Learn, EVM, Native SDKs, Solutions, Operators, Reference, Support)
- [x] All ~536 existing `hedera/` pages migrated to correct tabs and groups
- [x] Directory structure created for all 7 tabs
- [x] `revamp/migrate.sh`, `revamp/verify.sh`, `revamp/create-placeholders.sh` tooling
- [x] Navigation integrity verified (all referenced pages exist on disk)
- [x] **Learn / Getting Started section** — 4 pages written (2026-03-19):
  - `learn/getting-started/index.mdx` — section hub with 4-step journey + shortcut cards
  - `learn/getting-started/what-is-hedera.mdx` — foundational intro, Hashgraph, services, FAQ
  - `learn/getting-started/why-hedera.mdx` — value prop, comparison table, use cases
  - `learn/getting-started/choose-your-path.mdx` — EVM vs Native SDK persona funnel
- [x] `learn/index.mdx` — stale `hedera/` links updated to new 7-tab paths
- [x] **Protected pages system** — `revamp/protected-pages.txt` + `--ack` workflow in `migrate.sh` + Check 9 in `verify.sh`

---

## What's MISSING — 63 Placeholder Pages (New Content to Write)

### Learn Tab (1 placeholder remaining)
The Getting Started section is complete. One placeholder remains.

| Page | Path | Status |
|------|------|--------|
| ~~Getting Started landing~~ | ~~`learn/getting-started/index.mdx`~~ | ✅ Done |
| ~~What is Hedera~~ | ~~`learn/getting-started/what-is-hedera.mdx`~~ | ✅ Done |
| ~~Why Hedera~~ | ~~`learn/getting-started/why-hedera.mdx`~~ | ✅ Done |
| ~~Choose Your Path~~ | ~~`learn/getting-started/choose-your-path.mdx`~~ | ✅ Done |
| Hedera Services overview | `learn/core-concepts/services/index.mdx` | 🟡 MED |

### EVM Tab (32 placeholders)
Largest content gap. Many are net-new pages that don't exist in `hedera/`.

**Overview group (4):**
- `evm/overview/index.mdx`
- `evm/overview/evm-on-hedera-explained.mdx`
- `evm/overview/choose-your-path.mdx`
- `evm/overview/why-hedera-for-evm.mdx`

**Quickstart group (3):**
- `evm/quickstart/index.mdx`
- `evm/quickstart/interact-with-contract.mdx`
- `evm/quickstart/whats-next.mdx`

**Tools group (6):**
- `evm/tools/index.mdx`
- `evm/tools/remix.mdx`
- `evm/tools/hardhat/setup.mdx`
- `evm/tools/hardhat/testing.mdx`
- `evm/tools/foundry/testing.mdx`
- `evm/development/index.mdx`

**Troubleshooting group (4) — all new:**
- `evm/troubleshooting/index.mdx`
- `evm/troubleshooting/common-errors.mdx`
- `evm/troubleshooting/gas-estimation.mdx`
- `evm/troubleshooting/transaction-failures.mdx`

**Hedera Services group (8):**
- `evm/hedera-services/index.mdx`
- `evm/hedera-services/why-use-native-services.mdx`
- `evm/hedera-services/hts-solidity/index.mdx`
- `evm/hedera-services/hts-solidity/create-tokens.mdx`
- `evm/hedera-services/hts-solidity/nft-operations.mdx`
- `evm/hedera-services/hts-solidity/token-management.mdx`
- `evm/hedera-services/hts-solidity/transfer-tokens.mdx`
- `evm/hedera-services/hybrid/hts-vs-erc.mdx`
- `evm/hedera-services/system-contracts/exchange-rate.mdx`
- `evm/hedera-services/system-contracts/prng.mdx`

**Migration group (1):**
- `evm/migration/checklist.mdx`

**Integrations group (3):**
- `evm/integrations/index.mdx`
- `evm/integrations/indexing/mirror-node.mdx`
- `evm/integrations/indexing/the-graph.mdx`
- `evm/integrations/wallets/index.mdx`

**Tutorials (3):**
- `evm/tutorials/beginner/read-contract-data.mdx`
- `evm/tutorials/beginner/simple-nft.mdx`
- `evm/tutorials/beginner/your-first-token.mdx`
- `evm/tutorials/intermediate/events-and-logs.mdx`

### Native SDKs Tab (6 placeholders)

| Page | Path | Priority |
|------|------|----------|
| Overview landing | `native/overview/index.mdx` | 🔴 HIGH |
| SDK Comparison | `native/overview/sdk-comparison.mdx` | 🟡 MED |
| Why Native SDK | `native/overview/why-native-sdk.mdx` | 🟡 MED |
| Quickstart landing | `native/quickstart/index.mdx` | 🔴 HIGH |
| Java Quickstart | `native/quickstart/java.mdx` | 🟡 MED |
| Go Quickstart | `native/quickstart/go.mdx` | 🟡 MED |
| Integrations landing | `native/integrations/index.mdx` | 🟢 LOW |

### Operators Tab (7 placeholders)

| Page | Path | Priority |
|------|------|----------|
| Operators landing | `operators/index.mdx` | 🔴 HIGH |
| JSON-RPC landing | `operators/json-rpc/index.mdx` | 🟡 MED |
| JSON-RPC Setup | `operators/json-rpc/setup.mdx` | 🟡 MED |
| JSON-RPC Config | `operators/json-rpc/configuration.mdx` | 🟡 MED |
| Mirror Node Architecture | `operators/mirror-node/architecture.mdx` | 🟢 LOW |
| Consensus Node Monitoring | `operators/consensus-node/monitoring.mdx` | 🟢 LOW |
| Consensus Node Hardware | `operators/consensus-node/requirements/hardware.mdx` | 🟢 LOW |
| Consensus Node Network | `operators/consensus-node/requirements/network.mdx` | 🟢 LOW |

### Solutions Tab (6 placeholders — mostly landing pages)

| Page | Path | Priority |
|------|------|----------|
| Tokenization landing | `solutions/tokenization/index.mdx` | 🟡 MED |
| ATS Quickstart | `solutions/tokenization/ats/quickstart.mdx` | 🟡 MED |
| Governance landing | `solutions/governance/index.mdx` | 🟢 LOW |
| Sustainability landing | `solutions/sustainability/index.mdx` | 🟢 LOW |
| Examples landing | `solutions/examples/index.mdx` | 🟢 LOW |
| Dev Tools landing | `solutions/tools/index.mdx` | 🟢 LOW |

### Support Tab (1 placeholder)

| Page | Path | Priority |
|------|------|----------|
| FAQ landing | `support/faq/index.mdx` | 🟡 MED |

---

## What's MISSING — Non-Page Work (from plan)

These are plan items that don't map to specific placeholder files but are still outstanding:

### 1. Cross-tab navigation links (Plan section: "Cross-References Between Tabs")
The plan specifies contextual links between tabs that guide users to related content:
- EVM System Contracts → Learn Core Concepts (tokens)
- EVM Deploy → Learn Networks (endpoints)
- Native Tokens → Learn Core Concepts (tokens)
- Native Local Dev → Operators Mirror Nodes
- Operators → Reference REST API
- Learn Core Concepts → "Ready to build?" links to EVM/Native

**Status:** Not yet implemented. Requires editing real content pages to add `<Card>` or inline links.

### 2. Tab landing/index pages (the critical UX entry points)
The `index.mdx` files for each tab's main section need to be proper landing pages with:
- Brief description of who this section is for
- Card grid linking to major sub-sections
- "What you'll learn" or "Choose your path" orientation

**Status:** All tab-level index pages are placeholders.

### 3. User journey "Choose Your Path" pages
The plan shows a flow: Learn → Getting Started → Choose Your Path → EVM or Native.
- `learn/getting-started/choose-your-path.mdx` — ✅ **DONE**
- `evm/overview/choose-your-path.mdx` — placeholder

### 4. EVM Differences/Migration — content accuracy review
The `evm/migration/` pages were migrated from existing content but need review to ensure:
- They cover the specific Hedera-vs-Ethereum differences the plan calls out (decimals 8 vs 18, HBAR transfers, JSON-RPC quirks)
- The `evm/migration/checklist.mdx` is placeholder — needs to be written

### 5. Support tab — style guide & community pages
The style guide sub-pages and community pages exist but need content review.

---

## Suggested Priority Order

1. ~~**Learn / Getting Started**~~ — ✅ DONE (2026-03-19)
2. **Tab landing pages** — the index.mdx for each major tab (makes nav usable)
3. **EVM Overview** — the "why Hedera for EVM" and orientation pages (4 pages)
4. **EVM Troubleshooting** — highest developer value, all new content (4 pages)
5. **Native Overview + Quickstarts** — Java/Go quickstarts missing (6 pages)
6. **EVM Hedera Services** — HTS Solidity pages, new content (8+ pages)
7. **Cross-tab links** — editorial work across existing pages
8. **Operators landing + JSON-RPC** — infrastructure operator entry points
9. **Solutions landings** — lower traffic, mostly marketing-adjacent

---

## Notes
- `evm/tutorials/hedera/` pages (HTS+EVM, HSS+EVM series) are NOT placeholders — they have real content migrated from `hedera/`
- `evm/migration/` pages (accounts-and-keys, hbar-decimals, json-rpc-differences, etc.) also have real migrated content
- `native/sdk/` and `native/tutorials/` have real content; gaps are mostly in overview/quickstart
