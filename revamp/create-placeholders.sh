#!/bin/bash
# ============================================================================
# Hedera Documentation Placeholder Generator v3.0
# ============================================================================
# Creates placeholder MDX files for NEW pages that don't exist in the old
# docs but are needed for the revamped navigation structure.
#
# Run AFTER migrate.sh — this fills in the gaps for pages that need to be
# written from scratch (overview pages, "choose your path" pages, etc.)
#
# Safe to run multiple times — skips files that already exist.
#
# Usage (from repo root OR from revamp/ directory):
#   ./revamp/create-placeholders.sh
# ============================================================================

set -e

# ── Navigate to repo root ──────────────────────────────────────────────────
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." 2>/dev/null && pwd)"
if [ -f "$SCRIPT_DIR/docs.json" ] && [ -d "$SCRIPT_DIR/hedera" ]; then
    REPO_ROOT="$SCRIPT_DIR"
fi
cd "$REPO_ROOT"

if [ ! -f "docs.json" ] || [ ! -d "hedera" ]; then
    echo "Error: Cannot find hedera-docs repo root. Run from repo root or revamp/."
    exit 1
fi

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

CREATED=0
SKIPPED=0

echo -e "${BLUE}════════════════════════════════════════════${NC}"
echo -e "${BLUE}  Creating Placeholder Pages v3.0${NC}"
echo -e "${BLUE}════════════════════════════════════════════${NC}"

# ── Placeholder function ────────────────────────────────────────────────────
placeholder() {
    local path="$1"
    local title="$2"
    local description="$3"
    local icon="${4:-file-lines}"

    if [ -f "$path" ]; then
        SKIPPED=$((SKIPPED + 1))
        return 0
    fi

    mkdir -p "$(dirname "$path")"

    cat > "$path" << EOF
---
title: "${title}"
description: "${description}"
icon: "${icon}"
---

{/* TODO: This page needs content */}

<Info>
  **Coming Soon** — This page is under construction.
</Info>

## Overview

${description}

{/*
## Content Checklist
- [ ] Write introduction
- [ ] Add code examples
- [ ] Include diagrams if needed
- [ ] Add related links
- [ ] Review and polish
*/}

## Need Help?

<CardGroup cols={2}>
  <Card title="Discord" icon="discord" href="https://hedera.com/discord">
    Join our developer community
  </Card>
  <Card title="GitHub" icon="github" href="https://github.com/hashgraph">
    Explore our repositories
  </Card>
</CardGroup>
EOF

    CREATED=$((CREATED + 1))
    echo -e "  ${GREEN}✓${NC} $path"
}

# ============================================================================
# LEARN SECTION — New Pages
# ============================================================================
echo ""
echo -e "${BLUE}━━━ Learn Section ━━━${NC}"

placeholder "learn/getting-started/index.mdx" \
    "Getting Started" \
    "Everything you need to start building on Hedera." \
    "rocket"

placeholder "learn/getting-started/what-is-hedera.mdx" \
    "What is Hedera?" \
    "An introduction to Hedera, the enterprise-grade public network." \
    "circle-question"

placeholder "learn/getting-started/why-hedera.mdx" \
    "Why Build on Hedera?" \
    "Discover the advantages of building on Hedera: speed, security, and sustainability." \
    "rocket"

placeholder "learn/getting-started/choose-your-path.mdx" \
    "Choose Your Path" \
    "Find the right development path based on your background and goals." \
    "signs-post"

placeholder "learn/core-concepts/services/index.mdx" \
    "Hedera Services" \
    "Overview of Hedera's core services: tokens, consensus, files, and smart contracts." \
    "grid-2"

# ============================================================================
# EVM SECTION — New Pages
# ============================================================================
echo ""
echo -e "${BLUE}━━━ EVM Section ━━━${NC}"

# Overview
placeholder "evm/overview/index.mdx" \
    "EVM on Hedera" \
    "Everything you need to know about building with the EVM on Hedera." \
    "ethereum"

placeholder "evm/overview/why-hedera-for-evm.mdx" \
    "Why Hedera for EVM Developers?" \
    "Discover the benefits of deploying smart contracts on Hedera vs other EVM chains." \
    "lightbulb"

placeholder "evm/overview/evm-on-hedera-explained.mdx" \
    "EVM on Hedera Explained" \
    "Understand how the Ethereum Virtual Machine works on Hedera's unique architecture." \
    "microchip"

placeholder "evm/overview/choose-your-path.mdx" \
    "Choose Your Path" \
    "Find the right starting point based on your EVM development experience." \
    "signs-post"

# Quick Start
placeholder "evm/quickstart/index.mdx" \
    "Quick Start" \
    "Get up and running with smart contracts on Hedera in minutes." \
    "rocket"

placeholder "evm/quickstart/interact-with-contract.mdx" \
    "Interact with Your Contract" \
    "Learn how to read from and write to your deployed smart contract." \
    "hand-pointer"

placeholder "evm/quickstart/whats-next.mdx" \
    "What's Next?" \
    "Explore advanced topics after deploying your first contract." \
    "arrow-right"

# Development
placeholder "evm/development/index.mdx" \
    "Smart Contract Development" \
    "Everything you need to know about developing smart contracts on Hedera." \
    "code"

# Migration
placeholder "evm/migration/checklist.mdx" \
    "Migration Checklist" \
    "A step-by-step checklist for migrating your dApp from Ethereum to Hedera." \
    "list-check"

# Hedera Services
placeholder "evm/hedera-services/index.mdx" \
    "Hedera-Native Features" \
    "Access Hedera's unique services directly from your Solidity smart contracts." \
    "sparkles"

placeholder "evm/hedera-services/why-use-native-services.mdx" \
    "Why Use Native Services?" \
    "Understand the cost and performance benefits of using Hedera's native services vs pure ERC standards." \
    "scale-balanced"

placeholder "evm/hedera-services/system-contracts/exchange-rate.mdx" \
    "Exchange Rate System Contract" \
    "Query HBAR to USD exchange rates directly from your smart contracts." \
    "dollar-sign"

placeholder "evm/hedera-services/system-contracts/prng.mdx" \
    "PRNG System Contract" \
    "Generate verifiable random numbers in your smart contracts." \
    "dice"

# HTS from Solidity
placeholder "evm/hedera-services/hts-solidity/index.mdx" \
    "HTS from Solidity" \
    "Create and manage Hedera tokens directly from your Solidity smart contracts." \
    "coins"

placeholder "evm/hedera-services/hts-solidity/create-tokens.mdx" \
    "Create Tokens" \
    "Create fungible and non-fungible tokens using the HTS system contract." \
    "circle-plus"

placeholder "evm/hedera-services/hts-solidity/transfer-tokens.mdx" \
    "Transfer Tokens" \
    "Transfer HTS tokens between accounts from your smart contracts." \
    "arrow-right-arrow-left"

placeholder "evm/hedera-services/hts-solidity/token-management.mdx" \
    "Token Management" \
    "Pause, freeze, wipe, and manage token properties from Solidity." \
    "sliders"

placeholder "evm/hedera-services/hts-solidity/nft-operations.mdx" \
    "NFT Operations" \
    "Mint, burn, and transfer NFTs using the HTS system contract." \
    "image"

placeholder "evm/hedera-services/hybrid/hts-vs-erc.mdx" \
    "HTS vs ERC: When to Use What" \
    "Compare native HTS tokens with ERC-20/721 contracts and choose the right approach." \
    "scale-balanced"

# Tools
placeholder "evm/tools/index.mdx" \
    "Development Tools" \
    "Tools and frameworks for building smart contracts on Hedera." \
    "wrench"

placeholder "evm/tools/hardhat/setup.mdx" \
    "Hardhat Setup" \
    "Configure Hardhat for Hedera development from scratch." \
    "hammer"

placeholder "evm/tools/hardhat/testing.mdx" \
    "Testing with Hardhat" \
    "Write and run tests for your Hedera smart contracts using Hardhat." \
    "vial"

placeholder "evm/tools/foundry/testing.mdx" \
    "Testing with Foundry" \
    "Write Solidity tests for your Hedera smart contracts using Foundry." \
    "vial"

placeholder "evm/tools/remix.mdx" \
    "Remix IDE" \
    "Use Remix IDE to quickly prototype and deploy contracts on Hedera." \
    "browser"

# Tutorials
placeholder "evm/tutorials/beginner/your-first-token.mdx" \
    "Your First Token" \
    "Create and deploy a simple ERC-20 token on Hedera." \
    "coins"

placeholder "evm/tutorials/beginner/simple-nft.mdx" \
    "Create a Simple NFT" \
    "Deploy your first NFT collection on Hedera." \
    "image"

placeholder "evm/tutorials/beginner/read-contract-data.mdx" \
    "Read Contract Data" \
    "Learn how to read data from deployed smart contracts." \
    "magnifying-glass"

placeholder "evm/tutorials/intermediate/events-and-logs.mdx" \
    "Events and Logs" \
    "Emit and listen to events from your smart contracts." \
    "bell"

# Integrations
placeholder "evm/integrations/index.mdx" \
    "Integrations" \
    "Connect your Hedera dApps with oracles, bridges, wallets, and more." \
    "plug"

placeholder "evm/integrations/wallets/index.mdx" \
    "Wallet Integrations" \
    "Integrate popular wallets with your Hedera dApp." \
    "wallet"

placeholder "evm/integrations/indexing/the-graph.mdx" \
    "The Graph" \
    "Index and query blockchain data using The Graph on Hedera." \
    "chart-line"

placeholder "evm/integrations/indexing/mirror-node.mdx" \
    "Mirror Node Queries" \
    "Query historical data using Hedera's Mirror Node REST API." \
    "database"

# Troubleshooting
placeholder "evm/troubleshooting/index.mdx" \
    "Troubleshooting" \
    "Common issues and solutions when developing on Hedera." \
    "bug"

placeholder "evm/troubleshooting/common-errors.mdx" \
    "Common Errors" \
    "Reference guide for common error codes and their solutions." \
    "circle-exclamation"

placeholder "evm/troubleshooting/gas-estimation.mdx" \
    "Gas Estimation Issues" \
    "Troubleshoot gas estimation problems in your transactions." \
    "gas-pump"

placeholder "evm/troubleshooting/transaction-failures.mdx" \
    "Transaction Failures" \
    "Debug and fix failed transactions on Hedera." \
    "triangle-exclamation"

# ============================================================================
# NATIVE SDK SECTION — New Pages
# ============================================================================
echo ""
echo -e "${BLUE}━━━ Native SDK Section ━━━${NC}"

placeholder "native/overview/index.mdx" \
    "Native SDKs Overview" \
    "Build on Hedera using the official JavaScript, Java, Go, and Rust SDKs." \
    "code"

placeholder "native/overview/why-native-sdk.mdx" \
    "Why Use the Native SDKs?" \
    "Understand when to use Hedera's native SDKs vs EVM tooling." \
    "code"

placeholder "native/overview/sdk-comparison.mdx" \
    "SDK Comparison" \
    "Compare features across JavaScript, Java, Go, and other Hedera SDKs." \
    "scale-balanced"

placeholder "native/quickstart/index.mdx" \
    "Quick Start" \
    "Get started with the Hedera SDK in your preferred language." \
    "rocket"

placeholder "native/quickstart/java.mdx" \
    "Java Quick Start" \
    "Set up and use the Hedera Java SDK." \
    "java"

placeholder "native/quickstart/go.mdx" \
    "Go Quick Start" \
    "Set up and use the Hedera Go SDK." \
    "golang"

placeholder "native/integrations/index.mdx" \
    "Integrations" \
    "Integrate Hedera with AI agents, wallets, and other tools." \
    "plug"

# ============================================================================
# OPERATORS SECTION — New Pages
# ============================================================================
echo ""
echo -e "${BLUE}━━━ Operators Section ━━━${NC}"

placeholder "operators/index.mdx" \
    "Operators" \
    "Run and operate Hedera infrastructure including mirror nodes and consensus nodes." \
    "server"

placeholder "operators/mirror-node/architecture.mdx" \
    "Mirror Node Architecture" \
    "Understand how mirror nodes work and their role in the Hedera network." \
    "sitemap"

placeholder "operators/json-rpc/index.mdx" \
    "JSON-RPC Relay" \
    "Run your own JSON-RPC relay for EVM compatibility." \
    "network-wired"

placeholder "operators/json-rpc/setup.mdx" \
    "JSON-RPC Setup" \
    "Step-by-step guide to setting up a JSON-RPC relay." \
    "wrench"

placeholder "operators/json-rpc/configuration.mdx" \
    "JSON-RPC Configuration" \
    "Configure your JSON-RPC relay for optimal performance." \
    "sliders"

placeholder "operators/consensus-node/requirements/hardware.mdx" \
    "Hardware Requirements" \
    "Hardware specifications for running a Hedera consensus node." \
    "microchip"

placeholder "operators/consensus-node/requirements/network.mdx" \
    "Network Requirements" \
    "Network and connectivity requirements for consensus nodes." \
    "network-wired"

placeholder "operators/consensus-node/monitoring.mdx" \
    "Node Monitoring" \
    "Monitor the health and performance of your Hedera nodes." \
    "chart-line"

# ============================================================================
# REFERENCE SECTION — New Pages
# ============================================================================
echo ""
echo -e "${BLUE}━━━ Reference Section ━━━${NC}"

placeholder "reference/protobuf/miscellaneous/index.mdx" \
    "Miscellaneous Protobuf Types" \
    "Reference for miscellaneous protobuf types and services." \
    "list"

# ============================================================================
# SOLUTIONS SECTION — New Pages
# ============================================================================
echo ""
echo -e "${BLUE}━━━ Solutions Section ━━━${NC}"

placeholder "solutions/tokenization/index.mdx" \
    "Tokenization Solutions" \
    "Tools and frameworks for tokenizing real-world and digital assets on Hedera." \
    "coins"

placeholder "solutions/tokenization/ats/quickstart.mdx" \
    "ATS Quick Start" \
    "Get started with Asset Tokenization Studio in minutes." \
    "rocket"

placeholder "solutions/ai/index.mdx" \
    "AI & Agents" \
    "Build AI-powered applications on Hedera." \
    "robot"

placeholder "solutions/governance/index.mdx" \
    "Governance" \
    "Build decentralized governance solutions on Hedera." \
    "landmark"

placeholder "solutions/sustainability/index.mdx" \
    "Sustainability" \
    "Environmental sustainability solutions built on Hedera." \
    "leaf"

placeholder "solutions/tools/index.mdx" \
    "Developer Tools" \
    "Open-source tools for building on Hedera." \
    "wrench"

placeholder "solutions/examples/index.mdx" \
    "Examples & Demos" \
    "Sample applications, starter projects, and demos built on Hedera." \
    "flask"

# ============================================================================
# SUPPORT SECTION — New Pages
# ============================================================================
echo ""
echo -e "${BLUE}━━━ Support Section ━━━${NC}"

placeholder "support/faq/index.mdx" \
    "Frequently Asked Questions" \
    "Common questions about Hedera, HBAR, and the developer ecosystem." \
    "circle-question"

# ============================================================================
# SUMMARY
# ============================================================================
echo ""
echo -e "${GREEN}════════════════════════════════════════════${NC}"
echo -e "${GREEN}  Placeholder Generation Complete!${NC}"
echo -e "${GREEN}════════════════════════════════════════════${NC}"
echo ""
echo -e "  ${GREEN}✓${NC} Files created: $CREATED"
echo -e "  ${YELLOW}○${NC} Files skipped (already exist): $SKIPPED"
echo ""
echo -e "${YELLOW}Next steps:${NC}"
echo "  1. Review placeholder files and add content"
echo "  2. Update docs.json with the new navigation structure"
echo "  3. Run 'mint dev' to test navigation"
echo ""
