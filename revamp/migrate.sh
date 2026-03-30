#!/bin/bash
# ============================================================================
# Hedera Documentation Migration Script v3.0 (Auto-Sync)
# ============================================================================
# Migrates ALL content from hedera/ to the new 6-tab structure.
#
# Features:
#   - 100% coverage of all existing pages
#   - Auto-detects new, updated, and deleted files
#   - Directory-level rules auto-map new files in known sections
#   - Idempotent: safe to run multiple times
#   - Generates a migration report
#
# Usage (from repo root OR from revamp/ directory):
#   ./revamp/migrate.sh              # Full migration
#   ./revamp/migrate.sh --dry-run    # Preview without making changes
#   ./revamp/migrate.sh --clean      # Also remove orphaned destination files
#   ./revamp/migrate.sh --verbose    # Show all files including unchanged
#   ./revamp/migrate.sh --help       # Show usage
#
# Workflow for keeping dev branch in sync with main:
#   git checkout dev
#   git merge main                   # Brings hedera/ changes into dev
#   ./revamp/migrate.sh              # Detects & syncs new/updated/deleted
#   ./revamp/create-placeholders.sh  # Creates any new placeholder pages
# ============================================================================

set -e

# ── Colors ──────────────────────────────────────────────────────────────────
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
RED='\033[0;31m'
CYAN='\033[0;36m'
DIM='\033[2m'
NC='\033[0m'

# ── Counters ────────────────────────────────────────────────────────────────
COPIED=0
UPDATED=0
UNCHANGED=0
UNMAPPED=0
ORPHANED=0
PROTECTED_SKIPPED=0
PROTECTED_CHANGED=0
FIXUP_APPLIED=0
FIXUP_CONTENT_CHANGED=0
FALLBACK_NEEDS_NAV=0   # new/updated files using directory fallback — may need nav entry

# ── Temp files ──────────────────────────────────────────────────────────────
DEST_MANIFEST=$(mktemp)
UNMAPPED_LOG=$(mktemp)
FALLBACK_NAV_LOG=$(mktemp)
trap "rm -f $DEST_MANIFEST $UNMAPPED_LOG $FALLBACK_NAV_LOG" EXIT

# ── Banner ──────────────────────────────────────────────────────────────────
echo -e "${BLUE}═══════════════════════════════════════════════════${NC}"
echo -e "${BLUE}  Hedera Documentation Migration v3.0 (Auto-Sync)${NC}"
echo -e "${BLUE}═══════════════════════════════════════════════════${NC}"

# ── Navigate to repo root ──────────────────────────────────────────────────
# Works whether called from repo root or from revamp/ directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." 2>/dev/null && pwd)"

# If script is at repo root (not in revamp/), adjust
if [ -f "$SCRIPT_DIR/docs.json" ] && [ -d "$SCRIPT_DIR/hedera" ]; then
    REPO_ROOT="$SCRIPT_DIR"
fi

cd "$REPO_ROOT"

if [ ! -f "docs.json" ] || [ ! -d "hedera" ]; then
    echo -e "${RED}Error: Cannot find hedera-docs repo root (expected docs.json + hedera/)${NC}"
    echo -e "${RED}Run from the repo root or from the revamp/ directory.${NC}"
    exit 1
fi

echo -e "${DIM}Repo root: $(pwd)${NC}"

# ── Parse flags ─────────────────────────────────────────────────────────────
CLEAN_ORPHANS=false
DRY_RUN=false
VERBOSE=false

ACK_SOURCE=""
ACK_FIXUP_SOURCE=""
for arg in "$@"; do
    case "$arg" in
        --clean)         CLEAN_ORPHANS=true ;;
        --dry-run)       DRY_RUN=true ;;
        --verbose)       VERBOSE=true ;;
        --ack=*)         ACK_SOURCE="${arg#--ack=}" ;;
        --ack-fixup=*)   ACK_FIXUP_SOURCE="${arg#--ack-fixup=}" ;;
        --help)
            echo "Usage: ./migrate.sh [OPTIONS]"
            echo ""
            echo "Options:"
            echo "  --dry-run              Preview changes without modifying files"
            echo "  --clean                Remove destination files whose source no longer exists"
            echo "  --verbose              Show all files including unchanged ones"
            echo "  --ack=<source>         Acknowledge upstream changes in a protected page"
            echo "                         Updates the stored hash in protected-pages.txt"
            echo "                         Example: --ack=hedera/readme.mdx"
            echo "  --ack-fixup=<source>   Acknowledge upstream changes in a sidebar-fixup page"
            echo "  --ack-fixup=all        Acknowledge all sidebar-fixup pages at once"
            echo "                         Updates the stored hash in sidebar-fixups.txt"
            echo "                         Example: --ack-fixup=hedera/core-concepts/hashgraph-consensus-algorithms.mdx"
            echo ""
            echo "This script is idempotent and safe to run multiple times."
            echo "It auto-detects new, updated, and deleted files."
            exit 0
            ;;
    esac
done

# ── Load protected pages ────────────────────────────────────────────────────
# Protected pages are manually maintained on dev and NOT overwritten by migration.
# See revamp/protected-pages.txt for the registry and workflow documentation.
# Uses parallel indexed arrays (bash 3 compatible — macOS ships bash 3).
PROTECTED_SRCS=()
PROTECTED_DESTS_ARR=()
PROTECTED_HASHES=()
PROTECTED_FILE="$SCRIPT_DIR/protected-pages.txt"
if [ -f "$PROTECTED_FILE" ]; then
    while IFS= read -r line; do
        [[ "$line" =~ ^[[:space:]]*# ]] && continue
        [ -z "$line" ] && continue
        IFS='|' read -r hash src dest reason <<< "$line"
        [ -z "$src" ] && continue
        PROTECTED_SRCS+=("$src")
        PROTECTED_DESTS_ARR+=("$dest")
        PROTECTED_HASHES+=("$hash")
    done < "$PROTECTED_FILE"
fi

# Returns 0 if the given source path is protected, 1 otherwise.
is_protected_src() {
    local target="$1"
    local s
    for s in "${PROTECTED_SRCS[@]}"; do
        [ "$s" = "$target" ] && return 0
    done
    return 1
}

# Echoes the stored hash for a protected source path.
get_stored_hash() {
    local target="$1"
    local i
    for i in "${!PROTECTED_SRCS[@]}"; do
        if [ "${PROTECTED_SRCS[$i]}" = "$target" ]; then
            echo "${PROTECTED_HASHES[$i]}"
            return
        fi
    done
}

# Echoes the destination for a protected source path.
get_protected_dest_for() {
    local target="$1"
    local i
    for i in "${!PROTECTED_SRCS[@]}"; do
        if [ "${PROTECTED_SRCS[$i]}" = "$target" ]; then
            echo "${PROTECTED_DESTS_ARR[$i]}"
            return
        fi
    done
}

# ── Load sidebar fixups ──────────────────────────────────────────────────────
# Sidebar fixup pages are auto-copied from hedera/ but need sidebarTitle: Overview
# stripped and replaced with a meaningful label. The hash tracks content changes.
# See revamp/sidebar-fixups.txt for the registry and workflow documentation.
# Uses parallel indexed arrays (bash 3 compatible — macOS ships bash 3).
FIXUP_SRCS=()
FIXUP_DESTS_ARR=()
FIXUP_HASHES=()
FIXUP_TITLES=()
FIXUP_FILE="$SCRIPT_DIR/sidebar-fixups.txt"
if [ -f "$FIXUP_FILE" ]; then
    while IFS= read -r line; do
        [[ "$line" =~ ^[[:space:]]*# ]] && continue
        [ -z "$line" ] && continue
        IFS='|' read -r hash src dest title <<< "$line"
        [ -z "$src" ] && continue
        FIXUP_SRCS+=("$src")
        FIXUP_DESTS_ARR+=("$dest")
        FIXUP_HASHES+=("$hash")
        FIXUP_TITLES+=("$title")
    done < "$FIXUP_FILE"
fi

# Returns 0 if the given source path has a sidebar fixup entry.
is_fixup_src() {
    local target="$1"
    local s
    for s in "${FIXUP_SRCS[@]}"; do
        [ "$s" = "$target" ] && return 0
    done
    return 1
}

# Echoes the sidebarTitle for a fixup source path.
get_fixup_title() {
    local target="$1"
    local i
    for i in "${!FIXUP_SRCS[@]}"; do
        if [ "${FIXUP_SRCS[$i]}" = "$target" ]; then
            echo "${FIXUP_TITLES[$i]}"
            return
        fi
    done
}

# Echoes the stored hash for a fixup source path.
get_fixup_hash() {
    local target="$1"
    local i
    for i in "${!FIXUP_SRCS[@]}"; do
        if [ "${FIXUP_SRCS[$i]}" = "$target" ]; then
            echo "${FIXUP_HASHES[$i]}"
            return
        fi
    done
}

# ── Handle --ack flag ────────────────────────────────────────────────────────
# Updates the stored hash for a protected page after the user has reviewed
# upstream changes and incorporated any relevant content.
if [ -n "$ACK_SOURCE" ]; then
    if [ ! -f "$PROTECTED_FILE" ]; then
        echo -e "${RED}Error: revamp/protected-pages.txt not found${NC}"
        exit 1
    fi
    if [ ! -f "$ACK_SOURCE" ]; then
        echo -e "${RED}Error: source file not found: $ACK_SOURCE${NC}"
        exit 1
    fi
    if ! is_protected_src "$ACK_SOURCE"; then
        echo -e "${RED}Error: '$ACK_SOURCE' is not listed in revamp/protected-pages.txt${NC}"
        exit 1
    fi
    new_hash=$(git hash-object "$ACK_SOURCE")
    dest_display=$(get_protected_dest_for "$ACK_SOURCE")
    # Rewrite the file preserving comments and all other entries
    tmp=$(mktemp)
    while IFS= read -r line; do
        if [[ "$line" =~ ^[[:space:]]*# || -z "$line" ]]; then
            echo "$line"
        else
            IFS='|' read -r h s d r <<< "$line"
            if [ "$s" = "$ACK_SOURCE" ]; then
                echo "${new_hash}|${s}|${d}|${r}"
            else
                echo "$line"
            fi
        fi
    done < "$PROTECTED_FILE" > "$tmp"
    mv "$tmp" "$PROTECTED_FILE"
    echo -e "${GREEN}✓${NC} Acknowledged: $ACK_SOURCE"
    echo -e "  New hash: $new_hash"
    echo -e "  Destination: $dest_display"
    echo -e "  No further warnings until this source changes again."
    exit 0
fi

# ── Handle --ack-fixup flag ──────────────────────────────────────────────────
# Updates the stored hash for a sidebar-fixup page after the user has reviewed
# upstream content changes and confirmed the sidebarTitle is still accurate.
if [ -n "$ACK_FIXUP_SOURCE" ]; then
    if [ ! -f "$FIXUP_FILE" ]; then
        echo -e "${RED}Error: revamp/sidebar-fixups.txt not found${NC}"
        exit 1
    fi
    if [ "$ACK_FIXUP_SOURCE" = "all" ]; then
        # Acknowledge all fixup entries at once
        tmp=$(mktemp)
        ACK_COUNT=0
        while IFS= read -r line; do
            if [[ "$line" =~ ^[[:space:]]*# || -z "$line" ]]; then
                echo "$line"
            else
                IFS='|' read -r h s d t <<< "$line"
                if [ -n "$s" ] && [ -f "$s" ]; then
                    new_hash=$(git hash-object "$s")
                    echo "${new_hash}|${s}|${d}|${t}"
                    ACK_COUNT=$((ACK_COUNT + 1))
                else
                    echo "$line"
                fi
            fi
        done < "$FIXUP_FILE" > "$tmp"
        mv "$tmp" "$FIXUP_FILE"
        echo -e "${GREEN}✓${NC} Acknowledged all $ACK_COUNT sidebar-fixup entries"
        echo -e "  No further warnings until source files change again."
        exit 0
    else
        # Acknowledge a single fixup entry
        if [ ! -f "$ACK_FIXUP_SOURCE" ]; then
            echo -e "${RED}Error: source file not found: $ACK_FIXUP_SOURCE${NC}"
            exit 1
        fi
        if ! is_fixup_src "$ACK_FIXUP_SOURCE"; then
            echo -e "${RED}Error: '$ACK_FIXUP_SOURCE' is not listed in revamp/sidebar-fixups.txt${NC}"
            exit 1
        fi
        new_hash=$(git hash-object "$ACK_FIXUP_SOURCE")
        tmp=$(mktemp)
        while IFS= read -r line; do
            if [[ "$line" =~ ^[[:space:]]*# || -z "$line" ]]; then
                echo "$line"
            else
                IFS='|' read -r h s d t <<< "$line"
                if [ "$s" = "$ACK_FIXUP_SOURCE" ]; then
                    echo "${new_hash}|${s}|${d}|${t}"
                else
                    echo "$line"
                fi
            fi
        done < "$FIXUP_FILE" > "$tmp"
        mv "$tmp" "$FIXUP_FILE"
        echo -e "${GREEN}✓${NC} Acknowledged: $ACK_FIXUP_SOURCE"
        echo -e "  New hash: $new_hash"
        echo -e "  No further warnings until this source changes again."
        exit 0
    fi
fi

# ── Backup ──────────────────────────────────────────────────────────────────
if [ "$DRY_RUN" = false ]; then
    BACKUP="hedera.backup.$(date +%Y%m%d_%H%M%S)"
    echo -e "${YELLOW}Creating backup...${NC}"
    cp -r hedera "$BACKUP"
    cp docs.json "$BACKUP/docs.json.bak"
    echo -e "${GREEN}✓${NC} Backup: $BACKUP (includes docs.json)"
fi

# ============================================================================
# EXPLICIT FILE MAPPING
# ============================================================================
# Maps individual source files to specific destination paths.
# Used for cross-tab reorganizations and renames where directory
# rules alone can't determine the correct destination.
# ============================================================================

get_explicit_mapping() {
    local src="$1"
    case "$src" in

    # ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
    # LEARN SECTION
    # ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

    # Root
    "hedera/readme.mdx") echo "learn/index.mdx" ;;

    # Getting Started
    "hedera/getting-started-hedera-native-developers/create-an-account.mdx") echo "learn/getting-started/create-portal-account.mdx" ;;
    "hedera/getting-started-hedera-native-developers/portal-hedera-com-playground.mdx") echo "learn/getting-started/portal-playground.mdx" ;;

    # Core Concepts
    "hedera/core-concepts.mdx") echo "learn/core-concepts/index.mdx" ;;
    "hedera/core-concepts/accounts.mdx") echo "learn/core-concepts/accounts/index.mdx" ;;
    "hedera/core-concepts/accounts/account-creation.mdx") echo "learn/core-concepts/accounts/account-creation.mdx" ;;
    "hedera/core-concepts/accounts/auto-account-creation.mdx") echo "learn/core-concepts/accounts/auto-account-creation.mdx" ;;
    "hedera/core-concepts/accounts/account-properties.mdx") echo "learn/core-concepts/accounts/account-properties.mdx" ;;
    "hedera/core-concepts/accounts/network-accounts.mdx") echo "learn/core-concepts/accounts/network-accounts.mdx" ;;
    "hedera/core-concepts/hashgraph-consensus-algorithms.mdx") echo "learn/core-concepts/hashgraph/index.mdx" ;;
    "hedera/core-concepts/hashgraph-consensus-algorithms/gossip-about-gossip.mdx") echo "learn/core-concepts/hashgraph/gossip-about-gossip.mdx" ;;
    "hedera/core-concepts/hashgraph-consensus-algorithms/virtual-voting.mdx") echo "learn/core-concepts/hashgraph/virtual-voting.mdx" ;;
    "hedera/core-concepts/keys-and-signatures.mdx") echo "learn/core-concepts/keys/index.mdx" ;;
    "hedera/core-concepts/transactions-and-queries.mdx") echo "learn/core-concepts/transactions/index.mdx" ;;
    "hedera/core-concepts/transactions-and-queries/transaction-properties.mdx") echo "learn/core-concepts/transactions/properties.mdx" ;;
    "hedera/core-concepts/scheduled-transaction.mdx") echo "learn/core-concepts/transactions/scheduled.mdx" ;;
    "hedera/core-concepts/smart-contracts.mdx") echo "learn/core-concepts/services/smart-contracts.mdx" ;;
    "hedera/core-concepts/tokens.mdx") echo "learn/core-concepts/services/tokens.mdx" ;;
    "hedera/core-concepts/tokens/tokenization-on-hedera.mdx") echo "learn/core-concepts/tokens/index.mdx" ;;
    "hedera/core-concepts/tokens/hedera-token-service-hts-native-tokenization.mdx") echo "learn/core-concepts/tokens/hts-overview.mdx" ;;
    "hedera/core-concepts/tokens/hedera-token-service-hts-native-tokenization/token-types-and-id-formats.mdx") echo "learn/core-concepts/tokens/types-and-ids.mdx" ;;
    "hedera/core-concepts/tokens/hedera-token-service-hts-native-tokenization/token-properties.mdx") echo "learn/core-concepts/tokens/properties.mdx" ;;
    "hedera/core-concepts/tokens/hedera-token-service-hts-native-tokenization/token-creation.mdx") echo "learn/core-concepts/tokens/creation.mdx" ;;
    "hedera/core-concepts/tokens/hedera-token-service-hts-native-tokenization/custom-fee-schedule.mdx") echo "learn/core-concepts/tokens/custom-fees.mdx" ;;
    "hedera/core-concepts/tokens/hedera-token-service-hts-native-tokenization/token-airdrops.mdx") echo "learn/core-concepts/tokens/airdrops.mdx" ;;
    "hedera/core-concepts/staking.mdx") echo "learn/core-concepts/staking/index.mdx" ;;
    "hedera/core-concepts/staking/staking.mdx") echo "learn/core-concepts/staking/staking.mdx" ;;
    "hedera/core-concepts/staking/stake-hbar.mdx") echo "learn/core-concepts/staking/stake-hbar.mdx" ;;
    "hedera/core-concepts/mirror-nodes.mdx") echo "learn/core-concepts/mirror-nodes.mdx" ;;
    "hedera/core-concepts/state-and-history.mdx") echo "learn/core-concepts/state-and-history.mdx" ;;

    # Networks
    "hedera/networks.mdx") echo "learn/networks/index.mdx" ;;
    "hedera/networks/mainnet.mdx") echo "learn/networks/mainnet/index.mdx" ;;
    "hedera/networks/mainnet/mainnet-access.mdx") echo "learn/networks/mainnet/access.mdx" ;;
    "hedera/networks/mainnet/fees.mdx") echo "learn/networks/mainnet/fees.mdx" ;;
    "hedera/networks/mainnet/fees/transaction-records.mdx") echo "learn/networks/mainnet/transaction-records.mdx" ;;
    "hedera/networks/testnet.mdx") echo "learn/networks/testnet/index.mdx" ;;
    "hedera/networks/testnet/testnet-access.mdx") echo "learn/networks/testnet/access.mdx" ;;
    "hedera/networks/testnet/testnet-nodes.mdx") echo "learn/networks/testnet/nodes.mdx" ;;
    "hedera/networks/localnet.mdx") echo "learn/networks/localnet/index.mdx" ;;
    "hedera/networks/localnet/single-node-configuration.mdx") echo "learn/networks/localnet/single-node.mdx" ;;
    "hedera/networks/localnet/multinode-configuration.mdx") echo "learn/networks/localnet/multinode.mdx" ;;
    "hedera/networks/community-mirror-nodes.mdx") echo "learn/networks/community-mirror-nodes.mdx" ;;
    "hedera/networks/release-notes.mdx") echo "learn/release-notes/index.mdx" ;;
    "hedera/networks/release-notes/services.mdx") echo "learn/release-notes/services.mdx" ;;
    "hedera/networks/release-notes/mirror-node.mdx") echo "learn/release-notes/mirror-node.mdx" ;;

    # ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
    # EVM SECTION
    # ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

    # Overview & Quick Start
    "hedera/getting-started-evm-developers.mdx") echo "evm/index.mdx" ;;
    "hedera/getting-started-evm-developers/add-hedera-to-metamask.mdx") echo "evm/quickstart/setup-metamask.mdx" ;;
    "hedera/getting-started-evm-developers/hedera-testnet-faucet.mdx") echo "evm/quickstart/get-test-hbar.mdx" ;;
    "hedera/getting-started-evm-developers/deploy-a-smart-contract-using-remix.mdx") echo "evm/quickstart/deploy-with-remix.mdx" ;;
    "hedera/getting-started-evm-developers/deploy-a-smart-contract-with-hardhat.mdx") echo "evm/quickstart/deploy-with-hardhat.mdx" ;;
    "hedera/getting-started-evm-developers/deploy-a-smart-contract-with-foundry.mdx") echo "evm/quickstart/deploy-with-foundry.mdx" ;;
    "hedera/getting-started-evm-developers/deploy-your-first-contract-with-hedera-contract-builder.mdx") echo "evm/quickstart/deploy-with-contract-builder.mdx" ;;
    "hedera/getting-started-evm-developers/docs-hedera-com-hedera-core-concepts-smart-contracts-understanding-hederas-evm-differences-and-compatibility.mdx") echo "evm/quickstart/evm-compatibility-overview.mdx" ;;
    "hedera/getting-started-evm-developers/portal-hedera-com-contract-builder.mdx") echo "evm/quickstart/portal-contract-builder.mdx" ;;

    # Development
    "hedera/core-concepts/smart-contracts/creating-smart-contracts.mdx") echo "evm/development/creating.mdx" ;;
    "hedera/core-concepts/smart-contracts/compiling-smart-contracts.mdx") echo "evm/development/compiling.mdx" ;;
    "hedera/core-concepts/smart-contracts/deploying-smart-contracts.mdx") echo "evm/development/deploying.mdx" ;;
    "hedera/core-concepts/smart-contracts/verifying-smart-contracts-beta.mdx") echo "evm/development/verifying.mdx" ;;
    "hedera/core-concepts/smart-contracts/gas-and-fees.mdx") echo "evm/development/gas-fees.mdx" ;;
    "hedera/core-concepts/smart-contracts/smart-contract-rent.mdx") echo "evm/development/rent.mdx" ;;
    "hedera/core-concepts/smart-contracts/smart-contract-traceability.mdx") echo "evm/development/traceability.mdx" ;;
    "hedera/core-concepts/smart-contracts/evm-archive-node-queries.mdx") echo "evm/development/archive-queries.mdx" ;;
    "hedera/core-concepts/smart-contracts/smart-contract-addresses.mdx") echo "evm/development/addresses.mdx" ;;
    "hedera/core-concepts/smart-contracts/security.mdx") echo "evm/development/security.mdx" ;;
    "hedera/core-concepts/smart-contracts/forking-hedera-network-for-local-testing.mdx") echo "evm/development/forking.mdx" ;;
    "hedera/core-concepts/smart-contracts/json-rpc-relay.mdx") echo "evm/development/json-rpc/index.mdx" ;;

    # Migration / EVM Differences - For EVM developers
    "hedera/core-concepts/smart-contracts/understanding-hederas-evm-differences-and-compatibility.mdx") echo "evm/migration/index.mdx" ;;
    "hedera/core-concepts/smart-contracts/understanding-hederas-evm-differences-and-compatibility/for-evm-developers-migrating-to-hedera.mdx") echo "evm/migration/key-differences-overview.mdx" ;;
    "hedera/core-concepts/smart-contracts/understanding-hederas-evm-differences-and-compatibility/for-evm-developers-migrating-to-hedera/accounts-signature-verification-and-keys-ecdsa-vs.-ed25519.mdx") echo "evm/migration/accounts-and-keys.mdx" ;;
    "hedera/core-concepts/smart-contracts/understanding-hederas-evm-differences-and-compatibility/for-evm-developers-migrating-to-hedera/decimal-handling-8-vs.-18-decimals.mdx") echo "evm/migration/hbar-decimals.mdx" ;;
    "hedera/core-concepts/smart-contracts/understanding-hederas-evm-differences-and-compatibility/for-evm-developers-migrating-to-hedera/handling-hbar-transfers-in-contracts.mdx") echo "evm/migration/native-token-transfers.mdx" ;;
    "hedera/core-concepts/smart-contracts/understanding-hederas-evm-differences-and-compatibility/for-evm-developers-migrating-to-hedera/json-rpc-relay-and-evm-tooling.mdx") echo "evm/migration/json-rpc-differences.mdx" ;;
    "hedera/core-concepts/smart-contracts/understanding-hederas-evm-differences-and-compatibility/for-evm-developers-migrating-to-hedera/token-management-with-hedera-token-service.mdx") echo "evm/migration/tooling-compatibility.mdx" ;;

    # Migration / EVM Differences - For native developers
    "hedera/core-concepts/smart-contracts/understanding-hederas-evm-differences-and-compatibility/for-hedera-native-developers-adding-smart-contract-functionality.mdx") echo "evm/migration/native-devs/index.mdx" ;;
    "hedera/core-concepts/smart-contracts/understanding-hederas-evm-differences-and-compatibility/for-hedera-native-developers-adding-smart-contract-functionality/extending-token-management-with-smart-contracts.mdx") echo "evm/migration/native-devs/extending-token-management.mdx" ;;
    "hedera/core-concepts/smart-contracts/understanding-hederas-evm-differences-and-compatibility/for-hedera-native-developers-adding-smart-contract-functionality/integrating-ed25519-accounts-and-advanced-features-into-smart-contracts.mdx") echo "evm/migration/native-devs/ed25519-integration.mdx" ;;
    "hedera/core-concepts/smart-contracts/understanding-hederas-evm-differences-and-compatibility/for-hedera-native-developers-adding-smart-contract-functionality/json-rpc-relay-and-state-queries.mdx") echo "evm/migration/native-devs/json-rpc-state-queries.mdx" ;;

    # Tokens (ERC standards)
    "hedera/core-concepts/smart-contracts/tokens-managed-by-smart-contracts.mdx") echo "evm/tokens/index.mdx" ;;
    "hedera/core-concepts/smart-contracts/tokens-managed-by-smart-contracts/erc-20-fungible-tokens.mdx") echo "evm/tokens/erc20.mdx" ;;
    "hedera/core-concepts/smart-contracts/tokens-managed-by-smart-contracts/erc-721-non-fungible-tokens-nfts.mdx") echo "evm/tokens/erc721.mdx" ;;
    "hedera/core-concepts/smart-contracts/tokens-managed-by-smart-contracts/erc-1363-payable-tokens.mdx") echo "evm/tokens/erc1363.mdx" ;;
    "hedera/core-concepts/smart-contracts/tokens-managed-by-smart-contracts/erc-3643-real-world-assets-rwa.mdx") echo "evm/tokens/erc3643.mdx" ;;
    "hedera/core-concepts/smart-contracts/wrapped-hbar-whbar.mdx") echo "evm/tokens/whbar.mdx" ;;

    # System Contracts & Hedera Services
    "hedera/core-concepts/smart-contracts/system-smart-contracts.mdx") echo "evm/hedera-services/system-contracts/index.mdx" ;;
    "hedera/core-concepts/smart-contracts/tokens-managed-by-smart-contracts/hedera-token-service-system-contract.mdx") echo "evm/hedera-services/system-contracts/hts.mdx" ;;
    "hedera/core-concepts/smart-contracts/system-smart-contracts/hedera-account-service.mdx") echo "evm/hedera-services/system-contracts/account-service.mdx" ;;
    "hedera/core-concepts/smart-contracts/system-smart-contracts/hedera-schedule-service.mdx") echo "evm/hedera-services/system-contracts/schedule-service.mdx" ;;
    "hedera/core-concepts/tokens/hybrid-hts-+-evm-tokenization.mdx") echo "evm/hedera-services/hybrid/index.mdx" ;;
    "hedera/core-concepts/tokens/erc-evm-compatible-tokenization.mdx") echo "evm/hedera-services/hybrid/erc-compatibility.mdx" ;;

    # Tools
    "hedera/open-source-solutions/hedera-contract-builder.mdx") echo "evm/tools/contract-builder.mdx" ;;
    "hedera/tutorials/smart-contracts/configuring-hardhat-with-hiero-local-node-a-step-by-step-guide.mdx") echo "evm/tools/hardhat/index.mdx" ;;
    "hedera/tutorials/smart-contracts/how-to-fork-the-hedera-network-with-hardhat-basic-erc20.mdx") echo "evm/tools/hardhat/forking-basic.mdx" ;;
    "hedera/tutorials/smart-contracts/how-to-fork-the-hedera-network-with-hardhat-advanced-hts.mdx") echo "evm/tools/hardhat/forking-advanced.mdx" ;;
    "hedera/tutorials/smart-contracts/foundry.mdx") echo "evm/tools/foundry/index.mdx" ;;
    "hedera/tutorials/smart-contracts/foundry/configuring-foundry-with-hedera-localnet-testnet-a-step-by-step-guide.mdx") echo "evm/tools/foundry/setup.mdx" ;;
    "hedera/tutorials/smart-contracts/foundry/how-to-fork-the-hedera-network-with-foundry-basic-erc20.mdx") echo "evm/tools/foundry/forking.mdx" ;;
    "hedera/tutorials/smart-contracts/deploy-smart-contracts-on-hedera-using-truffle.mdx") echo "evm/tools/other/truffle.mdx" ;;
    "hedera/tutorials/smart-contracts/deploy-a-subgraph-using-the-graph-and-json-rpc.mdx") echo "evm/tools/other/the-graph.mdx" ;;

    # Tutorials
    "hedera/tutorials/smart-contracts.mdx") echo "evm/tutorials/index.mdx" ;;
    "hedera/tutorials/smart-contracts/how-to-connect-metamask-to-hedera.mdx") echo "evm/tutorials/beginner/connect-metamask.mdx" ;;
    "hedera/tutorials/smart-contracts/send-and-receive-hbar-using-solidity-smart-contracts.mdx") echo "evm/tutorials/intermediate/send-receive-hbar.mdx" ;;
    "hedera/tutorials/smart-contracts/how-to-verify-a-smart-contract-on-hashscan.mdx") echo "evm/tutorials/intermediate/verify-hashscan.mdx" ;;
    "hedera/tutorials/smart-contracts/how-to-mint-and-burn-an-erc-721-token-using-hardhat-and-ethers-part-1.mdx") echo "evm/tutorials/advanced/erc721-hardhat/part1-mint-burn.mdx" ;;
    "hedera/tutorials/smart-contracts/how-to-set-access-control-a-token-uri-pause-and-transfer-an-erc-721-token-using-hardhat-part-2.mdx") echo "evm/tutorials/advanced/erc721-hardhat/part2-access-control.mdx" ;;
    "hedera/tutorials/smart-contracts/how-to-upgrade-an-erc-721-token-with-openzeppelin-uups-proxies-and-hardhat-part-3.mdx") echo "evm/tutorials/advanced/erc721-hardhat/part3-upgradeable.mdx" ;;
    "hedera/tutorials/smart-contracts/foundry/how-to-mint-and-burn-an-erc-721-token-using-foundry-part-1.mdx") echo "evm/tutorials/advanced/erc721-foundry/part1-mint-burn.mdx" ;;
    "hedera/tutorials/smart-contracts/foundry/how-to-write-tests-in-solidity-part-2.mdx") echo "evm/tutorials/advanced/erc721-foundry/part2-testing.mdx" ;;
    "hedera/tutorials/smart-contracts/hts-x-evm-part-1-how-to-mint-nfts.mdx") echo "evm/tutorials/hedera/hts-evm/part1-mint-nfts.mdx" ;;
    "hedera/tutorials/smart-contracts/hts-x-evm-part-2-kyc-and-update.mdx") echo "evm/tutorials/hedera/hts-evm/part2-kyc-update.mdx" ;;
    "hedera/tutorials/smart-contracts/hts-x-evm-part-3-how-to-pause-freeze-wipe-and-delete-nfts.mdx") echo "evm/tutorials/hedera/hts-evm/part3-pause-freeze-wipe.mdx" ;;
    "hedera/tutorials/smart-contracts/hss-x-evm-part-1-schedule-smart-contract-calls.mdx") echo "evm/tutorials/hedera/hss-evm/part1-schedule-calls.mdx" ;;
    "hedera/tutorials/smart-contracts/hss-x-evm-part-2-dynamic-rebalancing.mdx") echo "evm/tutorials/hedera/hss-evm/part2-rebalancing.mdx" ;;
    "hedera/tutorials/token/create-and-transfer-an-nft-using-a-solidity-contract.mdx") echo "evm/tutorials/hedera/nft-solidity.mdx" ;;
    "hedera/tutorials/token/hybrid-hts-+-evm-tokenization.mdx") echo "evm/tutorials/hedera/hybrid-hts-evm.mdx" ;;

    # Integrations (EVM)
    "hedera/open-source-solutions/oracle-networks.mdx") echo "evm/integrations/oracles/index.mdx" ;;
    "hedera/open-source-solutions/oracle-networks/chainlink-oracles.mdx") echo "evm/integrations/oracles/chainlink.mdx" ;;
    "hedera/open-source-solutions/oracle-networks/pyth-network-oracle.mdx") echo "evm/integrations/oracles/pyth.mdx" ;;
    "hedera/open-source-solutions/oracle-networks/supra-oracles.mdx") echo "evm/integrations/oracles/supra.mdx" ;;
    "hedera/open-source-solutions/interoperability-and-bridging.mdx") echo "evm/integrations/cross-chain/index.mdx" ;;
    "hedera/open-source-solutions/interoperability-and-bridging/layerzero.mdx") echo "evm/integrations/cross-chain/layerzero.mdx" ;;
    "hedera/open-source-solutions/interoperability-and-bridging/chainlink.mdx") echo "evm/integrations/cross-chain/chainlink-ccip.mdx" ;;
    "hedera/open-source-solutions/hedera-walletconnect.mdx") echo "evm/integrations/wallets/walletconnect.mdx" ;;
    "hedera/open-source-solutions/hedera-wallet-snap-by-metamask.mdx") echo "evm/integrations/wallets/metamask-snap.mdx" ;;
    "hedera/open-source-solutions/hedera-wallet-snap-by-metamask/metamask-hedera-wallet-snap-tutorial.mdx") echo "evm/integrations/wallets/metamask-snap-tutorial.mdx" ;;

    # JSON-RPC connection tutorials (EVM)
    "hedera/tutorials/more-tutorials/json-rpc-connections.mdx") echo "evm/tutorials/intermediate/json-rpc-connections/index.mdx" ;;
    "hedera/tutorials/more-tutorials/json-rpc-connections/hashio.mdx") echo "evm/tutorials/intermediate/json-rpc-connections/hashio.mdx" ;;
    "hedera/tutorials/more-tutorials/json-rpc-connections/validation-cloud.mdx") echo "evm/tutorials/intermediate/json-rpc-connections/validation-cloud.mdx" ;;

    # ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
    # NATIVE SDK SECTION
    # ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

    # Overview & Quick Start
    "hedera/getting-started-hedera-native-developers.mdx") echo "native/index.mdx" ;;
    "hedera/getting-started-hedera-native-developers/quickstart.mdx") echo "native/quickstart/javascript.mdx" ;;

    # Fundamentals
    "hedera/sdks-and-apis/sdks.mdx") echo "native/fundamentals/index.mdx" ;;
    "hedera/sdks-and-apis/sdks/client.mdx") echo "native/fundamentals/client.mdx" ;;
    "hedera/sdks-and-apis/sdks/set-up-your-local-network.mdx") echo "native/fundamentals/local-network.mdx" ;;
    "hedera/sdks-and-apis/sdks/address-book.mdx") echo "native/fundamentals/address-book.mdx" ;;
    "hedera/sdks-and-apis/sdks/hbars.mdx") echo "native/fundamentals/hbars.mdx" ;;
    "hedera/sdks-and-apis/sdks/specialized-types.mdx") echo "native/fundamentals/specialized-types.mdx" ;;
    "hedera/sdks-and-apis/sdks/general-errors.mdx") echo "native/fundamentals/errors.mdx" ;;

    # Keys
    "hedera/sdks-and-apis/sdks/keys.mdx") echo "native/keys/index.mdx" ;;
    "hedera/sdks-and-apis/sdks/keys/generate-a-new-key-pair.mdx") echo "native/keys/generate-key-pair.mdx" ;;
    "hedera/sdks-and-apis/sdks/keys/import-an-existing-key.mdx") echo "native/keys/import-key.mdx" ;;
    "hedera/sdks-and-apis/sdks/keys/create-a-key-list.mdx") echo "native/keys/key-list.mdx" ;;
    "hedera/sdks-and-apis/sdks/keys/create-a-threshold-key.mdx") echo "native/keys/threshold-key.mdx" ;;
    "hedera/sdks-and-apis/sdks/keys/generate-a-mnemonic-phrase.mdx") echo "native/keys/mnemonic-generate.mdx" ;;
    "hedera/sdks-and-apis/sdks/keys/recover-keys-from-a-mnemonic-phrase.mdx") echo "native/keys/mnemonic-recover.mdx" ;;

    # Transactions
    "hedera/sdks-and-apis/sdks/transactions.mdx") echo "native/transactions/index.mdx" ;;
    "hedera/sdks-and-apis/sdks/transactions/transaction-id.mdx") echo "native/transactions/transaction-id.mdx" ;;
    "hedera/sdks-and-apis/sdks/transactions/modify-transaction-fields.mdx") echo "native/transactions/modify-fields.mdx" ;;
    "hedera/sdks-and-apis/sdks/transactions/create-an-unsigned-transaction.mdx") echo "native/transactions/unsigned.mdx" ;;
    "hedera/sdks-and-apis/sdks/transactions/manually-sign-a-transaction.mdx") echo "native/transactions/manual-sign.mdx" ;;
    "hedera/sdks-and-apis/sdks/transactions/submit-a-transaction.mdx") echo "native/transactions/submit.mdx" ;;
    "hedera/sdks-and-apis/sdks/transactions/sign-a-multisignature-transaction.mdx") echo "native/transactions/multisig.mdx" ;;
    "hedera/sdks-and-apis/sdks/transactions/get-a-transaction-receipt.mdx") echo "native/transactions/receipt.mdx" ;;
    "hedera/sdks-and-apis/sdks/transactions/get-a-transaction-record.mdx") echo "native/transactions/record.mdx" ;;
    "hedera/sdks-and-apis/sdks/transactions/create-a-batch-transaction.mdx") echo "native/transactions/batch.mdx" ;;

    # Queries & PRNG
    "hedera/sdks-and-apis/sdks/queries.mdx") echo "native/queries.mdx" ;;
    "hedera/sdks-and-apis/sdks/pseudorandom-number-generator.mdx") echo "native/prng.mdx" ;;

    # Accounts (SDK)
    "hedera/sdks-and-apis/sdks/accounts-and-hbar.mdx") echo "native/accounts/index.mdx" ;;
    "hedera/sdks-and-apis/sdks/accounts-and-hbar/create-an-account.mdx") echo "native/accounts/create.mdx" ;;
    "hedera/sdks-and-apis/sdks/accounts-and-hbar/update-an-account.mdx") echo "native/accounts/update.mdx" ;;
    "hedera/sdks-and-apis/sdks/accounts-and-hbar/transfer-cryptocurrency.mdx") echo "native/accounts/transfer.mdx" ;;
    "hedera/sdks-and-apis/sdks/accounts-and-hbar/approve-an-allowance.mdx") echo "native/accounts/approve-allowance.mdx" ;;
    "hedera/sdks-and-apis/sdks/accounts-and-hbar/adjust-an-allowance.mdx") echo "native/accounts/adjust-allowance.mdx" ;;
    "hedera/sdks-and-apis/sdks/accounts-and-hbar/delete-an-account.mdx") echo "native/accounts/delete.mdx" ;;
    "hedera/sdks-and-apis/sdks/accounts-and-hbar/get-account-balance.mdx") echo "native/accounts/get-balance.mdx" ;;
    "hedera/sdks-and-apis/sdks/accounts-and-hbar/get-account-info.mdx") echo "native/accounts/get-info.mdx" ;;
    "hedera/sdks-and-apis/sdks/accounts-and-hbar/errors.mdx") echo "native/accounts/errors.mdx" ;;

    # Token Service (SDK)
    "hedera/sdks-and-apis/sdks/token-service.mdx") echo "native/tokens/index.mdx" ;;
    "hedera/sdks-and-apis/sdks/token-service/token-id.mdx") echo "native/tokens/token-id.mdx" ;;
    "hedera/sdks-and-apis/sdks/token-service/nft-id.mdx") echo "native/tokens/nft-id.mdx" ;;
    "hedera/sdks-and-apis/sdks/token-service/token-types.mdx") echo "native/tokens/token-types.mdx" ;;
    "hedera/sdks-and-apis/sdks/token-service/define-a-token.mdx") echo "native/tokens/define.mdx" ;;
    "hedera/sdks-and-apis/sdks/token-service/custom-token-fees.mdx") echo "native/tokens/custom-fees.mdx" ;;
    "hedera/sdks-and-apis/sdks/token-service/update-a-token.mdx") echo "native/tokens/update.mdx" ;;
    "hedera/sdks-and-apis/sdks/token-service/update-a-fee-schedule.mdx") echo "native/tokens/update-fee-schedule.mdx" ;;
    "hedera/sdks-and-apis/sdks/token-service/update-nft-metadata.mdx") echo "native/tokens/update-nft-metadata.mdx" ;;
    "hedera/sdks-and-apis/sdks/token-service/transfer-tokens.mdx") echo "native/tokens/transfer.mdx" ;;
    "hedera/sdks-and-apis/sdks/token-service/airdrop-a-token.mdx") echo "native/tokens/airdrop.mdx" ;;
    "hedera/sdks-and-apis/sdks/token-service/claim-a-token.mdx") echo "native/tokens/claim.mdx" ;;
    "hedera/sdks-and-apis/sdks/token-service/cancel-a-token.mdx") echo "native/tokens/cancel.mdx" ;;
    "hedera/sdks-and-apis/sdks/token-service/reject-an-airdrop.mdx") echo "native/tokens/reject-airdrop.mdx" ;;
    "hedera/sdks-and-apis/sdks/token-service/delete-a-token.mdx") echo "native/tokens/delete.mdx" ;;
    "hedera/sdks-and-apis/sdks/token-service/mint-a-token.mdx") echo "native/tokens/mint.mdx" ;;
    "hedera/sdks-and-apis/sdks/token-service/burn-a-token.mdx") echo "native/tokens/burn.mdx" ;;
    "hedera/sdks-and-apis/sdks/token-service/freeze-an-account.mdx") echo "native/tokens/freeze.mdx" ;;
    "hedera/sdks-and-apis/sdks/token-service/unfreeze-an-account.mdx") echo "native/tokens/unfreeze.mdx" ;;
    "hedera/sdks-and-apis/sdks/token-service/enable-kyc-account-flag.mdx") echo "native/tokens/enable-kyc.mdx" ;;
    "hedera/sdks-and-apis/sdks/token-service/disable-kyc-account-flag.mdx") echo "native/tokens/disable-kyc.mdx" ;;
    "hedera/sdks-and-apis/sdks/token-service/associate-tokens-to-an-account.mdx") echo "native/tokens/associate.mdx" ;;
    "hedera/sdks-and-apis/sdks/token-service/dissociate-tokens-from-an-account.mdx") echo "native/tokens/dissociate.mdx" ;;
    "hedera/sdks-and-apis/sdks/token-service/pause-a-token.mdx") echo "native/tokens/pause.mdx" ;;
    "hedera/sdks-and-apis/sdks/token-service/unpause-a-token.mdx") echo "native/tokens/unpause.mdx" ;;
    "hedera/sdks-and-apis/sdks/token-service/wipe-a-token.mdx") echo "native/tokens/wipe.mdx" ;;
    "hedera/sdks-and-apis/sdks/token-service/atomic-swaps.mdx") echo "native/tokens/atomic-swaps.mdx" ;;
    "hedera/sdks-and-apis/sdks/token-service/get-account-token-balance.mdx") echo "native/tokens/get-balance.mdx" ;;
    "hedera/sdks-and-apis/sdks/token-service/get-token-info.mdx") echo "native/tokens/get-info.mdx" ;;
    "hedera/sdks-and-apis/sdks/token-service/get-nft-token-info.mdx") echo "native/tokens/get-nft-info.mdx" ;;
    "hedera/sdks-and-apis/sdks/token-service/errors.mdx") echo "native/tokens/errors.mdx" ;;

    # Consensus Service (SDK)
    "hedera/sdks-and-apis/sdks/consensus-service.mdx") echo "native/consensus/index.mdx" ;;
    "hedera/sdks-and-apis/sdks/consensus-service/create-a-topic.mdx") echo "native/consensus/create-topic.mdx" ;;
    "hedera/sdks-and-apis/sdks/consensus-service/update-a-topic.mdx") echo "native/consensus/update-topic.mdx" ;;
    "hedera/sdks-and-apis/sdks/consensus-service/submit-a-message.mdx") echo "native/consensus/submit-message.mdx" ;;
    "hedera/sdks-and-apis/sdks/consensus-service/delete-a-topic.mdx") echo "native/consensus/delete-topic.mdx" ;;
    "hedera/sdks-and-apis/sdks/consensus-service/get-topic-message.mdx") echo "native/consensus/get-message.mdx" ;;
    "hedera/sdks-and-apis/sdks/consensus-service/get-topic-info.mdx") echo "native/consensus/get-info.mdx" ;;
    "hedera/sdks-and-apis/sdks/consensus-service/errors.mdx") echo "native/consensus/errors.mdx" ;;

    # File Service (SDK)
    "hedera/sdks-and-apis/sdks/file-service.mdx") echo "native/files/index.mdx" ;;
    "hedera/sdks-and-apis/sdks/file-service/create-a-file.mdx") echo "native/files/create.mdx" ;;
    "hedera/sdks-and-apis/sdks/file-service/append-to-a-file.mdx") echo "native/files/append.mdx" ;;
    "hedera/sdks-and-apis/sdks/file-service/update-a-file.mdx") echo "native/files/update.mdx" ;;
    "hedera/sdks-and-apis/sdks/file-service/delete-a-file.mdx") echo "native/files/delete.mdx" ;;
    "hedera/sdks-and-apis/sdks/file-service/get-file-contents.mdx") echo "native/files/get-contents.mdx" ;;
    "hedera/sdks-and-apis/sdks/file-service/get-file-info.mdx") echo "native/files/get-info.mdx" ;;
    "hedera/sdks-and-apis/sdks/file-service/errors.mdx") echo "native/files/errors.mdx" ;;

    # Scheduled Transactions (SDK)
    "hedera/sdks-and-apis/sdks/schedule-transaction.mdx") echo "native/scheduled/index.mdx" ;;
    "hedera/sdks-and-apis/sdks/schedule-transaction/schedule-id.mdx") echo "native/scheduled/schedule-id.mdx" ;;
    "hedera/sdks-and-apis/sdks/schedule-transaction/create-a-schedule-transaction.mdx") echo "native/scheduled/create.mdx" ;;
    "hedera/sdks-and-apis/sdks/schedule-transaction/sign-a-schedule-transaction.mdx") echo "native/scheduled/sign.mdx" ;;
    "hedera/sdks-and-apis/sdks/schedule-transaction/delete-a-schedule-transaction.mdx") echo "native/scheduled/delete.mdx" ;;
    "hedera/sdks-and-apis/sdks/schedule-transaction/get-schedule-info.mdx") echo "native/scheduled/get-info.mdx" ;;
    "hedera/sdks-and-apis/sdks/schedule-transaction/network-response-messages.mdx") echo "native/scheduled/response-messages.mdx" ;;

    # Smart Contracts (SDK)
    "hedera/sdks-and-apis/sdks/smart-contracts.mdx") echo "native/smart-contracts/index.mdx" ;;
    "hedera/sdks-and-apis/sdks/smart-contracts/delegate-contract-id.mdx") echo "native/smart-contracts/delegate-contract-id.mdx" ;;
    "hedera/sdks-and-apis/sdks/smart-contracts/create-a-smart-contract.mdx") echo "native/smart-contracts/create.mdx" ;;
    "hedera/sdks-and-apis/sdks/smart-contracts/update-a-smart-contract.mdx") echo "native/smart-contracts/update.mdx" ;;
    "hedera/sdks-and-apis/sdks/smart-contracts/delete-a-smart-contract.mdx") echo "native/smart-contracts/delete.mdx" ;;
    "hedera/sdks-and-apis/sdks/smart-contracts/call-a-smart-contract-function.mdx") echo "native/smart-contracts/call.mdx" ;;
    "hedera/sdks-and-apis/sdks/smart-contracts/ethereum-transaction.mdx") echo "native/smart-contracts/ethereum-transaction.mdx" ;;
    "hedera/sdks-and-apis/sdks/smart-contracts/get-a-smart-contract-function.mdx") echo "native/smart-contracts/get-function.mdx" ;;
    "hedera/sdks-and-apis/sdks/smart-contracts/get-smart-contract-bytecode.mdx") echo "native/smart-contracts/get-bytecode.mdx" ;;
    "hedera/sdks-and-apis/sdks/smart-contracts/get-smart-contract-info.mdx") echo "native/smart-contracts/get-info.mdx" ;;
    "hedera/sdks-and-apis/sdks/smart-contracts/hedera-service-solidity-libraries.mdx") echo "native/smart-contracts/solidity-libraries.mdx" ;;
    "hedera/sdks-and-apis/sdks/smart-contracts/errors.mdx") echo "native/smart-contracts/errors.mdx" ;;

    # Signature Provider
    "hedera/sdks-and-apis/sdks/signature-provider.mdx") echo "native/signature-provider/index.mdx" ;;
    "hedera/sdks-and-apis/sdks/signature-provider/provider.mdx") echo "native/signature-provider/provider.mdx" ;;
    "hedera/sdks-and-apis/sdks/signature-provider/signer.mdx") echo "native/signature-provider/signer.mdx" ;;
    "hedera/sdks-and-apis/sdks/signature-provider/wallet.mdx") echo "native/signature-provider/wallet.mdx" ;;
    "hedera/sdks-and-apis/sdks/signature-provider/local-provider.mdx") echo "native/signature-provider/local-provider.mdx" ;;

    # Tutorials (Native)
    "hedera/tutorials.mdx") echo "native/tutorials/index.mdx" ;;
    "hedera/tutorials/more-tutorials.mdx") echo "native/tutorials/more/index.mdx" ;;
    "hedera/tutorials/more-tutorials/create-and-fund-your-hedera-testnet-account.mdx") echo "native/tutorials/getting-started/create-fund-account.mdx" ;;
    "hedera/tutorials/more-tutorials/how-to-create-a-personal-access-token-api-key-on-the-hedera-portal.mdx") echo "native/tutorials/getting-started/create-api-key.mdx" ;;
    "hedera/tutorials/more-tutorials/how-to-auto-create-hedera-accounts-with-hbar-and-token-transfers.mdx") echo "native/tutorials/getting-started/auto-create-accounts.mdx" ;;
    "hedera/getting-started-hedera-native-developers/create-a-token.mdx") echo "native/tutorials/tokens/create-first-token.mdx" ;;
    "hedera/tutorials/token.mdx") echo "native/tutorials/tokens/index.mdx" ;;
    "hedera/tutorials/token/create-and-transfer-your-first-nft.mdx") echo "native/tutorials/tokens/create-transfer-nft.mdx" ;;
    "hedera/tutorials/token/create-and-transfer-your-first-fungible-token.mdx") echo "native/tutorials/tokens/create-transfer-fungible.mdx" ;;
    "hedera/tutorials/token/structure-your-token-metadata-using-json-schema-v2.mdx") echo "native/tutorials/tokens/metadata-schema.mdx" ;;
    "hedera/tutorials/token/hedera-token-service-part-1-how-to-mint-nfts.mdx") echo "native/tutorials/tokens/hts-part1-mint.mdx" ;;
    "hedera/tutorials/token/hedera-token-service-part-2-kyc-update-and-scheduled-transactions.mdx") echo "native/tutorials/tokens/hts-part2-kyc.mdx" ;;
    "hedera/tutorials/token/hedera-token-service-part-3-how-to-pause-freeze-wipe-and-delete-nfts.mdx") echo "native/tutorials/tokens/hts-part3-admin.mdx" ;;
    "hedera/tutorials/token/create-your-first-frictionless-airdrop-campaign.mdx") echo "native/tutorials/tokens/airdrop-campaign.mdx" ;;
    "hedera/tutorials/consensus.mdx") echo "native/tutorials/consensus/index.mdx" ;;
    "hedera/getting-started-hedera-native-developers/create-a-topic.mdx") echo "native/tutorials/consensus/create-first-topic.mdx" ;;
    "hedera/tutorials/consensus/submit-your-first-message.mdx") echo "native/tutorials/consensus/submit-first-message.mdx" ;;
    "hedera/tutorials/consensus/submit-message-to-private-topic.mdx") echo "native/tutorials/consensus/private-topic.mdx" ;;
    "hedera/tutorials/consensus/batch-anchor-verify-records-with-hcs.mdx") echo "native/tutorials/consensus/batch-anchor-verify.mdx" ;;
    "hedera/tutorials/consensus/query-messages-with-mirror-node.mdx") echo "native/tutorials/consensus/query-mirror-node.mdx" ;;
    "hedera/tutorials/more-tutorials/schedule-your-first-transaction.mdx") echo "native/tutorials/scheduled/schedule-first.mdx" ;;
    "hedera/tutorials/more-tutorials/how-to-generate-a-random-number-on-hedera.mdx") echo "native/tutorials/advanced/random-number.mdx" ;;
    "hedera/tutorials/more-tutorials/how-to-configure-a-mirror-node-and-query-specific-data.mdx") echo "native/tutorials/advanced/configure-mirror-node.mdx" ;;
    "hedera/tutorials/more-tutorials/javascript-testing.mdx") echo "native/tutorials/advanced/javascript-testing.mdx" ;;
    "hedera/tutorials/more-tutorials/develop-a-hedera-dapp-integrated-with-walletconnect.mdx") echo "native/tutorials/advanced/walletconnect-dapp.mdx" ;;
    "hedera/tutorials/hashgraphdev-com.mdx") echo "native/tutorials/advanced/hashgraphdev.mdx" ;;

    # HSM Signing tutorials
    "hedera/tutorials/more-tutorials/HSM-signing.mdx") echo "native/tutorials/advanced/hsm-signing/index.mdx" ;;
    "hedera/tutorials/more-tutorials/HSM-signing/aws-kms.mdx") echo "native/tutorials/advanced/hsm-signing/aws-kms.mdx" ;;
    "hedera/tutorials/more-tutorials/HSM-signing/azure-key-vault.mdx") echo "native/tutorials/advanced/hsm-signing/azure-key-vault.mdx" ;;
    "hedera/tutorials/more-tutorials/HSM-signing/gcp-kms.mdx") echo "native/tutorials/advanced/hsm-signing/gcp-kms.mdx" ;;

    # HCS Fabric Plugin tutorial
    "hedera/tutorials/more-tutorials/get-started-with-the-hedera-consensus-service-fabric-plugin.mdx") echo "native/tutorials/advanced/hcs-fabric-plugin/index.mdx" ;;
    "hedera/tutorials/more-tutorials/get-started-with-the-hedera-consensus-service-fabric-plugin/virtual-environment-set-up.mdx") echo "native/tutorials/advanced/hcs-fabric-plugin/virtual-environment.mdx" ;;

    # MCP Server tutorial
    "hedera/tutorials/more-tutorials/hedera-mcp-server-setup-guide.mdx") echo "native/tutorials/advanced/mcp-server-setup.mdx" ;;

    # Local Development
    "hedera/tutorials/local-node.mdx") echo "native/local-dev/index.mdx" ;;
    "hedera/tutorials/local-node/how-to-set-up-a-hedera-local-node.mdx") echo "native/local-dev/setup-local-node.mdx" ;;
    "hedera/tutorials/local-node/setup-hedera-node-cli-npm.mdx") echo "native/local-dev/setup-cli-npm.mdx" ;;
    "hedera/tutorials/local-node/how-to-run-hedera-local-node-in-a-cloud-development-environment-cde.mdx") echo "native/local-dev/cde/index.mdx" ;;
    "hedera/tutorials/local-node/how-to-run-hedera-local-node-in-a-cloud-development-environment-cde/gitpod.mdx") echo "native/local-dev/cde/gitpod.mdx" ;;
    "hedera/tutorials/local-node/how-to-run-hedera-local-node-in-a-cloud-development-environment-cde/codespaces.mdx") echo "native/local-dev/cde/codespaces.mdx" ;;

    # AI Studio & Tools (Solutions)
    "hedera/open-source-solutions/ai-studio-on-hedera.mdx") echo "solutions/ai/index.mdx" ;;
    "hedera/open-source-solutions/ai-studio-on-hedera/hedera-ai-agent-kit.mdx") echo "solutions/ai/agent-kit/index.mdx" ;;
    "hedera/open-source-solutions/ai-studio-on-hedera/hedera-ai-agent-kit/plugins.mdx") echo "solutions/ai/agent-kit/plugins.mdx" ;;
    "hedera/open-source-solutions/ai-studio-on-hedera/hedera-ai-agent-kit/hedera-agent-kit-js/quickstart.mdx") echo "solutions/ai/agent-kit/js/quickstart.mdx" ;;
    "hedera/open-source-solutions/ai-studio-on-hedera/hedera-ai-agent-kit/hedera-agent-kit-js/plugins.mdx") echo "solutions/ai/agent-kit/js/plugins.mdx" ;;
    "hedera/open-source-solutions/ai-studio-on-hedera/hedera-ai-agent-kit/hedera-agent-kit-js/create-js-plugins.mdx") echo "solutions/ai/agent-kit/js/create-plugins.mdx" ;;
    "hedera/open-source-solutions/ai-studio-on-hedera/hedera-ai-agent-kit/hedera-agent-kit-py/quickstart.mdx") echo "solutions/ai/agent-kit/python/quickstart.mdx" ;;
    "hedera/open-source-solutions/ai-studio-on-hedera/hedera-ai-agent-kit/hedera-agent-kit-py/plugins.mdx") echo "solutions/ai/agent-kit/python/plugins.mdx" ;;
    "hedera/open-source-solutions/ai-studio-on-hedera/hedera-ai-agent-kit/hedera-agent-kit-py/create-py-plugins.mdx") echo "solutions/ai/agent-kit/python/create-plugins.mdx" ;;
    "hedera/open-source-solutions/ai-studio-on-hedera/agent-lab.mdx") echo "solutions/ai/agent-lab.mdx" ;;
    "hedera/open-source-solutions/ai-studio-on-hedera/hedera-ai-agent-kit/elizaos-plugin.mdx") echo "solutions/ai/elizaos.mdx" ;;
    "hedera/open-source-solutions/ai-tools-for-developers.mdx") echo "solutions/ai/tools/index.mdx" ;;
    "hedera/open-source-solutions/ai-tools-for-developers/hedera-hivemind.mdx") echo "solutions/ai/tools/hivemind.mdx" ;;
    "hedera/open-source-solutions/ai-tools-for-developers/kapa-ai.mdx") echo "solutions/ai/tools/kapa.mdx" ;;

    # ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
    # OPERATORS SECTION
    # ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

    "hedera/core-concepts/mirror-nodes/hedera-mirror-node.mdx") echo "operators/mirror-node/index.mdx" ;;
    "hedera/core-concepts/mirror-nodes/one-click-mirror-node-deployment.mdx") echo "operators/mirror-node/one-click-deploy.mdx" ;;
    "hedera/core-concepts/mirror-nodes/run-your-own-beta-mirror-node.mdx") echo "operators/mirror-node/run-your-own/index.mdx" ;;
    "hedera/core-concepts/mirror-nodes/run-your-own-beta-mirror-node/run-your-own-mirror-node-gcs.mdx") echo "operators/mirror-node/run-your-own/gcs.mdx" ;;
    "hedera/core-concepts/mirror-nodes/run-your-own-beta-mirror-node/run-your-own-mirror-node-s3.mdx") echo "operators/mirror-node/run-your-own/s3.mdx" ;;
    "hedera/networks/mainnet/mainnet-nodes.mdx") echo "operators/consensus-node/index.mdx" ;;
    "hedera/networks/mainnet/mainnet-nodes/node-requirements.mdx") echo "operators/consensus-node/requirements/index.mdx" ;;
    "hedera/networks/mainnet/mainnet-nodes/node-requirements/faq.mdx") echo "operators/consensus-node/requirements/faq.mdx" ;;
    "hedera/networks/mainnet/mainnet-nodes/node-deployment-process.mdx") echo "operators/consensus-node/deployment.mdx" ;;

    # ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
    # REFERENCE SECTION
    # ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

    "hedera/sdks-and-apis.mdx") echo "reference/index.mdx" ;;
    "hedera/sdks-and-apis/rest-api.mdx") echo "reference/rest-api/index.mdx" ;;
    "hedera/sdks-and-apis/rest-api/accounts.mdx") echo "reference/rest-api/accounts/index.mdx" ;;
    "hedera/sdks-and-apis/rest-api/balances.mdx") echo "reference/rest-api/balances/index.mdx" ;;
    "hedera/sdks-and-apis/rest-api/blocks.mdx") echo "reference/rest-api/blocks/index.mdx" ;;
    "hedera/sdks-and-apis/rest-api/smart-contracts.mdx") echo "reference/rest-api/contracts/index.mdx" ;;
    "hedera/sdks-and-apis/rest-api/tokens.mdx") echo "reference/rest-api/tokens/index.mdx" ;;
    "hedera/sdks-and-apis/rest-api/topics.mdx") echo "reference/rest-api/topics/index.mdx" ;;
    "hedera/sdks-and-apis/rest-api/transactions.mdx") echo "reference/rest-api/transactions/index.mdx" ;;
    "hedera/sdks-and-apis/rest-api/schedule-transactions.mdx") echo "reference/rest-api/schedules/index.mdx" ;;
    "hedera/sdks-and-apis/rest-api/network.mdx") echo "reference/rest-api/network/index.mdx" ;;
    "hedera/sdks-and-apis/hedera-consensus-service-api.mdx") echo "reference/hcs-api.mdx" ;;
    "hedera/sdks-and-apis/hedera-status-api.mdx") echo "reference/status-api.mdx" ;;
    "hedera/sdks-and-apis/smart-contract-verification-api.mdx") echo "reference/verification-api.mdx" ;;

    # Protobuf index pages
    "hedera/sdks-and-apis/hedera-api.mdx") echo "reference/protobuf/index.mdx" ;;
    "hedera/sdks-and-apis/hedera-api/basic-types.mdx") echo "reference/protobuf/basic-types/index.mdx" ;;
    "hedera/sdks-and-apis/hedera-api/cryptocurrency-accounts.mdx") echo "reference/protobuf/crypto/index.mdx" ;;
    "hedera/sdks-and-apis/hedera-api/consensus.mdx") echo "reference/protobuf/consensus/index.mdx" ;;
    "hedera/sdks-and-apis/hedera-api/schedule-service.mdx") echo "reference/protobuf/schedule/index.mdx" ;;
    "hedera/sdks-and-apis/hedera-api/token-service.mdx") echo "reference/protobuf/token/index.mdx" ;;
    "hedera/sdks-and-apis/hedera-api/file-service.mdx") echo "reference/protobuf/file/index.mdx" ;;
    "hedera/sdks-and-apis/hedera-api/smart-contracts.mdx") echo "reference/protobuf/smart-contracts/index.mdx" ;;
    "hedera/sdks-and-apis/hedera-api/miscellaneous.mdx") echo "reference/protobuf/miscellaneous/index.mdx" ;;

    # ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
    # SOLUTIONS SECTION
    # ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

    "hedera/open-source-solutions.mdx") echo "solutions/index.mdx" ;;

    # Tokenization
    "hedera/open-source-solutions/asset-tokenization-studio-ats.mdx") echo "solutions/tokenization/ats/index.mdx" ;;
    "hedera/open-source-solutions/asset-tokenization-studio-ats/web-user-interface-ui.mdx") echo "solutions/tokenization/ats/web-ui.mdx" ;;
    "hedera/open-source-solutions/asset-tokenization-studio-ats/frequently-asked-questions-faqs.mdx") echo "solutions/tokenization/ats/faq.mdx" ;;
    "hedera/open-source-solutions/stablecoin-studio.mdx") echo "solutions/tokenization/stablecoin/index.mdx" ;;
    "hedera/open-source-solutions/stablecoin-studio/core-concepts.mdx") echo "solutions/tokenization/stablecoin/core-concepts.mdx" ;;
    "hedera/open-source-solutions/stablecoin-studio/web-ui-application.mdx") echo "solutions/tokenization/stablecoin/web-ui.mdx" ;;
    "hedera/open-source-solutions/stablecoin-studio/cli-management.mdx") echo "solutions/tokenization/stablecoin/cli.mdx" ;;
    "hedera/open-source-solutions/nft-studio.mdx") echo "solutions/tokenization/nft-studio/index.mdx" ;;
    "hedera/open-source-solutions/nft-studio/airdrop-list-verifier.mdx") echo "solutions/tokenization/nft-studio/airdrop-verifier.mdx" ;;
    "hedera/open-source-solutions/nft-studio/metadata-validator.mdx") echo "solutions/tokenization/nft-studio/metadata-validator.mdx" ;;
    "hedera/open-source-solutions/nft-studio/nft-rarity-inspector.mdx") echo "solutions/tokenization/nft-studio/rarity-inspector.mdx" ;;
    "hedera/open-source-solutions/nft-studio/nft-risk-calculator.mdx") echo "solutions/tokenization/nft-studio/risk-calculator.mdx" ;;
    "hedera/open-source-solutions/nft-studio/nft-token-holders-list-builder.mdx") echo "solutions/tokenization/nft-studio/token-holders-list.mdx" ;;
    "hedera/open-source-solutions/nft-studio/token-balance-snapshot.mdx") echo "solutions/tokenization/nft-studio/balance-snapshot.mdx" ;;

    # Governance
    "hedera/open-source-solutions/hashiodao.mdx") echo "solutions/governance/hashiodao/index.mdx" ;;
    "hedera/open-source-solutions/hashiodao/governance-token-dao.mdx") echo "solutions/governance/hashiodao/governance-token-dao.mdx" ;;
    "hedera/open-source-solutions/hashiodao/nft-dao.mdx") echo "solutions/governance/hashiodao/nft-dao.mdx" ;;
    "hedera/open-source-solutions/hashiodao/multisig-dao.mdx") echo "solutions/governance/hashiodao/multisig-dao.mdx" ;;
    "hedera/open-source-solutions/hashiodao/dao-proposals.mdx") echo "solutions/governance/hashiodao/dao-proposals.mdx" ;;
    "hedera/open-source-solutions/hashiodao/local-environment-setup.mdx") echo "solutions/governance/hashiodao/local-environment-setup.mdx" ;;

    # Sustainability
    "hedera/open-source-solutions/hedera-guardian.mdx") echo "solutions/sustainability/guardian.mdx" ;;

    # Tools
    "hedera/open-source-solutions/hedera-developer-playground.mdx") echo "solutions/tools/playground.mdx" ;;
    "hedera/open-source-solutions/hedera-developers-code-repository.mdx") echo "solutions/tools/code-repo.mdx" ;;
    "hedera/open-source-solutions/hedera-custodians-library.mdx") echo "solutions/tools/custodians-library.mdx" ;;
    "hedera/open-source-solutions/hedera-custodians-library/how-to-use-it.mdx") echo "solutions/tools/custodians-library-usage.mdx" ;;

    # Redirect/link pages
    "hedera/open-source-solutions/docs-tuum-tech-hedera-wallet-snap-basics-introduction.mdx") echo "solutions/tools/wallet-snap-intro.mdx" ;;
    "hedera/open-source-solutions/github-com-hashgraph-hedera-accelerator-stablecoin-tree-main-sdk.mdx") echo "solutions/tools/stablecoin-sdk-redirect.mdx" ;;
    "hedera/open-source-solutions/github-com-hashgraph-hedera-nft-sdk.mdx") echo "solutions/tools/nft-sdk-redirect.mdx" ;;
    "hedera/open-source-solutions/github-com-hashgraph-hedera-wallet-connect.mdx") echo "solutions/tools/walletconnect-redirect.mdx" ;;

    # Examples
    "hedera/tutorials/demo-applications.mdx") echo "solutions/examples/demos.mdx" ;;
    "hedera/tutorials/starter-projects.mdx") echo "solutions/examples/starters.mdx" ;;
    "hedera/tutorials/building-on-hedera.mdx") echo "solutions/examples/building-on-hedera.mdx" ;;

    # ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
    # SUPPORT SECTION
    # ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

    "hedera/support-and-community.mdx") echo "support/index.mdx" ;;
    "hedera/support-and-community/glossary.mdx") echo "support/glossary.mdx" ;;
    "hedera/support-and-community/contributing-guide.mdx") echo "support/contributing/index.mdx" ;;
    "hedera/support-and-community/brand-guidelines.mdx") echo "support/brand-guidelines.mdx" ;;
    "hedera/faqs/getting-started.mdx") echo "support/faq/getting-started.mdx" ;;
    "hedera/faqs/network-governance.mdx") echo "support/faq/governance.mdx" ;;
    "hedera/faqs/hbar.mdx") echo "support/faq/hbar.mdx" ;;
    "hedera/faqs/community.mdx") echo "support/faq/community.mdx" ;;
    "hedera/support-and-community/contributing-guide/contribution-guidelines.mdx") echo "support/contributing/contribution-guidelines/index.mdx" ;;
    "hedera/support-and-community/contributing-guide/contribution-guidelines/creating-issues.mdx") echo "support/contributing/contribution-guidelines/creating-issues.mdx" ;;
    "hedera/support-and-community/contributing-guide/contribution-guidelines/creating-pull-requests.mdx") echo "support/contributing/contribution-guidelines/creating-pull-requests.mdx" ;;
    "hedera/support-and-community/contributing-guide/contribution-guidelines/hedera-improvement-proposal-hip.mdx") echo "support/contributing/contribution-guidelines/hip.mdx" ;;
    "hedera/support-and-community/contributing-guide/contribution-guidelines/submit-demo-applications.mdx") echo "support/contributing/contribution-guidelines/submit-demo.mdx" ;;
    "hedera/support-and-community/contributing-guide/style-guide.mdx") echo "support/contributing/style-guide/index.mdx" ;;
    "hedera/support-and-community/contributing-guide/style-guide/understanding-different-types-of-documentation.mdx") echo "support/contributing/style-guide/doc-types.mdx" ;;
    "hedera/support-and-community/contributing-guide/style-guide/language-and-grammar.mdx") echo "support/contributing/style-guide/language-grammar.mdx" ;;
    "hedera/support-and-community/contributing-guide/style-guide/formatting.mdx") echo "support/contributing/style-guide/formatting.mdx" ;;

    # No explicit mapping found
    *) echo "" ;;
    esac
}

# ============================================================================
# DIRECTORY MAPPING RULES
# ============================================================================
# For sections where sub-pages map by replacing a path prefix (preserving
# the relative path and filename). These handle bulk migrations and
# automatically pick up NEW files added in the future.
#
# Order: most specific prefix first (longer prefixes checked first).
# ============================================================================

get_directory_mapping() {
    local src="$1"

    # ── Protobuf API sub-pages ──────────────────────────────────────────
    # These are the ~130+ individual type/service pages
    if [[ "$src" == hedera/sdks-and-apis/hedera-api/basic-types/* ]]; then
        echo "reference/protobuf/basic-types/${src#hedera/sdks-and-apis/hedera-api/basic-types/}"; return
    fi
    if [[ "$src" == hedera/sdks-and-apis/hedera-api/consensus/* ]]; then
        echo "reference/protobuf/consensus/${src#hedera/sdks-and-apis/hedera-api/consensus/}"; return
    fi
    if [[ "$src" == hedera/sdks-and-apis/hedera-api/cryptocurrency-accounts/* ]]; then
        echo "reference/protobuf/crypto/${src#hedera/sdks-and-apis/hedera-api/cryptocurrency-accounts/}"; return
    fi
    if [[ "$src" == hedera/sdks-and-apis/hedera-api/file-service/* ]]; then
        echo "reference/protobuf/file/${src#hedera/sdks-and-apis/hedera-api/file-service/}"; return
    fi
    if [[ "$src" == hedera/sdks-and-apis/hedera-api/smart-contracts/* ]]; then
        echo "reference/protobuf/smart-contracts/${src#hedera/sdks-and-apis/hedera-api/smart-contracts/}"; return
    fi
    if [[ "$src" == hedera/sdks-and-apis/hedera-api/token-service/* ]]; then
        echo "reference/protobuf/token/${src#hedera/sdks-and-apis/hedera-api/token-service/}"; return
    fi
    if [[ "$src" == hedera/sdks-and-apis/hedera-api/schedule-service/* ]]; then
        echo "reference/protobuf/schedule/${src#hedera/sdks-and-apis/hedera-api/schedule-service/}"; return
    fi
    if [[ "$src" == hedera/sdks-and-apis/hedera-api/miscellaneous/* ]]; then
        echo "reference/protobuf/miscellaneous/${src#hedera/sdks-and-apis/hedera-api/miscellaneous/}"; return
    fi

    # ── Hiero CLI (replaced hedera-cli) ─────────────────────────────────
    if [[ "$src" == hedera/open-source-solutions/hiero-cli/* ]]; then
        echo "solutions/tools/hiero-cli/${src#hedera/open-source-solutions/hiero-cli/}"; return
    fi

    # ── Catch-all directory rules for future-proofing ───────────────────
    # These ensure new files added under known directories are auto-mapped.

    # New pages under getting-started-evm-developers/
    if [[ "$src" == hedera/getting-started-evm-developers/* ]]; then
        echo "evm/quickstart/${src#hedera/getting-started-evm-developers/}"; return
    fi

    # New pages under getting-started-hedera-native-developers/
    if [[ "$src" == hedera/getting-started-hedera-native-developers/* ]]; then
        echo "native/quickstart/${src#hedera/getting-started-hedera-native-developers/}"; return
    fi

    # New pages under core-concepts/smart-contracts/system-smart-contracts/
    if [[ "$src" == hedera/core-concepts/smart-contracts/system-smart-contracts/* ]]; then
        echo "evm/hedera-services/system-contracts/${src#hedera/core-concepts/smart-contracts/system-smart-contracts/}"; return
    fi

    # New pages under core-concepts/mirror-nodes/run-your-own-beta-mirror-node/
    if [[ "$src" == hedera/core-concepts/mirror-nodes/run-your-own-beta-mirror-node/* ]]; then
        echo "operators/mirror-node/run-your-own/${src#hedera/core-concepts/mirror-nodes/run-your-own-beta-mirror-node/}"; return
    fi

    # New pages under core-concepts/mirror-nodes/
    if [[ "$src" == hedera/core-concepts/mirror-nodes/* ]]; then
        echo "operators/mirror-node/${src#hedera/core-concepts/mirror-nodes/}"; return
    fi

    # New pages under networks/release-notes/
    if [[ "$src" == hedera/networks/release-notes/* ]]; then
        echo "learn/release-notes/${src#hedera/networks/release-notes/}"; return
    fi

    # New pages under sdks-and-apis/sdks/keys/
    if [[ "$src" == hedera/sdks-and-apis/sdks/keys/* ]]; then
        echo "native/keys/${src#hedera/sdks-and-apis/sdks/keys/}"; return
    fi

    # New pages under sdks-and-apis/sdks/transactions/
    if [[ "$src" == hedera/sdks-and-apis/sdks/transactions/* ]]; then
        echo "native/transactions/${src#hedera/sdks-and-apis/sdks/transactions/}"; return
    fi

    # New pages under sdks-and-apis/sdks/accounts-and-hbar/
    if [[ "$src" == hedera/sdks-and-apis/sdks/accounts-and-hbar/* ]]; then
        echo "native/accounts/${src#hedera/sdks-and-apis/sdks/accounts-and-hbar/}"; return
    fi

    # New pages under sdks-and-apis/sdks/token-service/
    if [[ "$src" == hedera/sdks-and-apis/sdks/token-service/* ]]; then
        echo "native/tokens/${src#hedera/sdks-and-apis/sdks/token-service/}"; return
    fi

    # New pages under sdks-and-apis/sdks/consensus-service/
    if [[ "$src" == hedera/sdks-and-apis/sdks/consensus-service/* ]]; then
        echo "native/consensus/${src#hedera/sdks-and-apis/sdks/consensus-service/}"; return
    fi

    # New pages under sdks-and-apis/sdks/file-service/
    if [[ "$src" == hedera/sdks-and-apis/sdks/file-service/* ]]; then
        echo "native/files/${src#hedera/sdks-and-apis/sdks/file-service/}"; return
    fi

    # New pages under sdks-and-apis/sdks/schedule-transaction/
    if [[ "$src" == hedera/sdks-and-apis/sdks/schedule-transaction/* ]]; then
        echo "native/scheduled/${src#hedera/sdks-and-apis/sdks/schedule-transaction/}"; return
    fi

    # New pages under sdks-and-apis/sdks/smart-contracts/
    if [[ "$src" == hedera/sdks-and-apis/sdks/smart-contracts/* ]]; then
        echo "native/smart-contracts/${src#hedera/sdks-and-apis/sdks/smart-contracts/}"; return
    fi

    # New pages under sdks-and-apis/sdks/signature-provider/
    if [[ "$src" == hedera/sdks-and-apis/sdks/signature-provider/* ]]; then
        echo "native/signature-provider/${src#hedera/sdks-and-apis/sdks/signature-provider/}"; return
    fi

    # New pages under sdks-and-apis/rest-api/
    if [[ "$src" == hedera/sdks-and-apis/rest-api/* ]]; then
        echo "reference/rest-api/${src#hedera/sdks-and-apis/rest-api/}"; return
    fi

    # New pages under open-source-solutions/ai-studio-on-hedera/
    if [[ "$src" == hedera/open-source-solutions/ai-studio-on-hedera/* ]]; then
        echo "solutions/ai/${src#hedera/open-source-solutions/ai-studio-on-hedera/}"; return
    fi

    # New pages under open-source-solutions/ai-tools-for-developers/
    if [[ "$src" == hedera/open-source-solutions/ai-tools-for-developers/* ]]; then
        echo "solutions/ai/tools/${src#hedera/open-source-solutions/ai-tools-for-developers/}"; return
    fi

    # New pages under open-source-solutions/oracle-networks/
    if [[ "$src" == hedera/open-source-solutions/oracle-networks/* ]]; then
        echo "evm/integrations/oracles/${src#hedera/open-source-solutions/oracle-networks/}"; return
    fi

    # New pages under open-source-solutions/interoperability-and-bridging/
    if [[ "$src" == hedera/open-source-solutions/interoperability-and-bridging/* ]]; then
        echo "evm/integrations/cross-chain/${src#hedera/open-source-solutions/interoperability-and-bridging/}"; return
    fi

    # New pages under open-source-solutions/hashiodao/
    if [[ "$src" == hedera/open-source-solutions/hashiodao/* ]]; then
        echo "solutions/governance/hashiodao/${src#hedera/open-source-solutions/hashiodao/}"; return
    fi

    # New pages under open-source-solutions/stablecoin-studio/
    if [[ "$src" == hedera/open-source-solutions/stablecoin-studio/* ]]; then
        echo "solutions/tokenization/stablecoin/${src#hedera/open-source-solutions/stablecoin-studio/}"; return
    fi

    # New pages under open-source-solutions/nft-studio/
    if [[ "$src" == hedera/open-source-solutions/nft-studio/* ]]; then
        echo "solutions/tokenization/nft-studio/${src#hedera/open-source-solutions/nft-studio/}"; return
    fi

    # New pages under open-source-solutions/asset-tokenization-studio-ats/
    if [[ "$src" == hedera/open-source-solutions/asset-tokenization-studio-ats/* ]]; then
        echo "solutions/tokenization/ats/${src#hedera/open-source-solutions/asset-tokenization-studio-ats/}"; return
    fi

    # New pages under open-source-solutions/hedera-wallet-snap-by-metamask/
    if [[ "$src" == hedera/open-source-solutions/hedera-wallet-snap-by-metamask/* ]]; then
        echo "evm/integrations/wallets/${src#hedera/open-source-solutions/hedera-wallet-snap-by-metamask/}"; return
    fi

    # New pages under tutorials/local-node/
    if [[ "$src" == hedera/tutorials/local-node/* ]]; then
        echo "native/local-dev/${src#hedera/tutorials/local-node/}"; return
    fi

    # New pages under tutorials/consensus/
    if [[ "$src" == hedera/tutorials/consensus/* ]]; then
        echo "native/tutorials/consensus/${src#hedera/tutorials/consensus/}"; return
    fi

    # New pages under tutorials/token/
    if [[ "$src" == hedera/tutorials/token/* ]]; then
        echo "native/tutorials/tokens/${src#hedera/tutorials/token/}"; return
    fi

    # New pages under tutorials/smart-contracts/foundry/
    if [[ "$src" == hedera/tutorials/smart-contracts/foundry/* ]]; then
        echo "evm/tools/foundry/${src#hedera/tutorials/smart-contracts/foundry/}"; return
    fi

    # New pages under tutorials/smart-contracts/
    if [[ "$src" == hedera/tutorials/smart-contracts/* ]]; then
        echo "evm/tutorials/new/${src#hedera/tutorials/smart-contracts/}"; return
    fi

    # New pages under tutorials/more-tutorials/HSM-signing/
    if [[ "$src" == hedera/tutorials/more-tutorials/HSM-signing/* ]]; then
        echo "native/tutorials/advanced/hsm-signing/${src#hedera/tutorials/more-tutorials/HSM-signing/}"; return
    fi

    # New pages under tutorials/more-tutorials/
    if [[ "$src" == hedera/tutorials/more-tutorials/* ]]; then
        echo "native/tutorials/advanced/${src#hedera/tutorials/more-tutorials/}"; return
    fi

    # New pages under support-and-community/contributing-guide/contribution-guidelines/
    if [[ "$src" == hedera/support-and-community/contributing-guide/contribution-guidelines/* ]]; then
        echo "support/contributing/contribution-guidelines/${src#hedera/support-and-community/contributing-guide/contribution-guidelines/}"; return
    fi

    # New pages under support-and-community/contributing-guide/style-guide/
    if [[ "$src" == hedera/support-and-community/contributing-guide/style-guide/* ]]; then
        echo "support/contributing/style-guide/${src#hedera/support-and-community/contributing-guide/style-guide/}"; return
    fi

    # New pages under support-and-community/
    if [[ "$src" == hedera/support-and-community/* ]]; then
        echo "support/${src#hedera/support-and-community/}"; return
    fi

    # New pages under faqs/
    if [[ "$src" == hedera/faqs/* ]]; then
        echo "support/faq/${src#hedera/faqs/}"; return
    fi

    # New pages under core-concepts/accounts/
    if [[ "$src" == hedera/core-concepts/accounts/* ]]; then
        echo "learn/core-concepts/accounts/${src#hedera/core-concepts/accounts/}"; return
    fi

    # New pages under core-concepts/staking/
    if [[ "$src" == hedera/core-concepts/staking/* ]]; then
        echo "learn/core-concepts/staking/${src#hedera/core-concepts/staking/}"; return
    fi

    # New pages under core-concepts/tokens/
    if [[ "$src" == hedera/core-concepts/tokens/* ]]; then
        echo "learn/core-concepts/tokens/${src#hedera/core-concepts/tokens/}"; return
    fi

    # New pages under networks/mainnet/mainnet-nodes/
    if [[ "$src" == hedera/networks/mainnet/mainnet-nodes/* ]]; then
        echo "operators/consensus-node/${src#hedera/networks/mainnet/mainnet-nodes/}"; return
    fi

    # New pages under networks/
    if [[ "$src" == hedera/networks/* ]]; then
        echo "learn/networks/${src#hedera/networks/}"; return
    fi

    # No directory rule matched
    echo ""
}

# ============================================================================
# ADDITIONAL COPIES
# ============================================================================
# Some files need to exist in multiple locations (e.g., testnet faucet
# appears under both learn/ and evm/). This function returns extra
# destinations beyond the primary one.
# ============================================================================

get_additional_destinations() {
    local src="$1"
    case "$src" in
    "hedera/getting-started-evm-developers/hedera-testnet-faucet.mdx")
        echo "learn/getting-started/testnet-faucet.mdx"
        ;;
    *) echo "" ;;
    esac
}

# ============================================================================
# SYNC ENGINE
# ============================================================================

# Returns 0 (true) if dest already contains the correctly-transformed version
# of src. Applies the same transforms that sync_file would apply:
#   1. CRLF → LF normalization
#   2. sidebarTitle: Overview stripped (quoted + unquoted)
#   3. sidebarTitle fixup injected (if src is in sidebar-fixups.txt)
#
# Fast path: cmp -s catches byte-identical files (no transforms needed).
# Slow path: Python comparison for the ~85 transform-touched files per run.
# This prevents showing UPDATE for files whose real content hasn't changed.
_src_matches_dest() {
    local src="$1"
    local dest="$2"
    [ -f "$dest" ] || return 1

    # Fast path: byte-for-byte identical (no transforms, no CRLF)
    cmp -s "$src" "$dest" && return 0

    # Slow path: compare after applying our full transform pipeline
    FIXUP_TITLE="$(get_fixup_title "$src")" python3 - "$src" "$dest" <<'PYEOF'
import sys, re, os

src, dest = sys.argv[1], sys.argv[2]
# Strip any trailing \r from title (sidebar-fixups.txt may have CRLF endings)
fixup_title = os.environ.get('FIXUP_TITLE', '').rstrip('\r')

try:
    with open(src, newline='') as f:
        content = f.read()
except Exception:
    sys.exit(1)

# Normalize CRLF
content = content.replace('\r\n', '\n').replace('\r', '\n')
# Strip sidebarTitle: Overview (unquoted and double-quoted)
content = re.sub(r'^sidebarTitle: Overview\n', '', content, flags=re.MULTILINE)
content = re.sub(r'^sidebarTitle: "Overview"\n', '', content, flags=re.MULTILINE)
# Apply fixup sidebarTitle if applicable
if fixup_title:
    content = re.sub(r'^sidebarTitle:.*\n', '', content, flags=re.MULTILINE)
    content = re.sub(
        r'^(title:.*)$',
        lambda m: m.group(0) + '\nsidebarTitle: ' + fixup_title,
        content, count=1, flags=re.MULTILINE
    )

try:
    with open(dest) as f:
        dest_content = f.read()
except Exception:
    sys.exit(1)

sys.exit(0 if content == dest_content else 1)
PYEOF
}

sync_file() {
    local src="$1"
    local dest="$2"
    local used_fallback="${3:-false}"  # true if dest came from directory rule not explicit case

    # Record in manifest (for orphan detection later)
    echo "$dest" >> "$DEST_MANIFEST"

    if [ "$DRY_RUN" = true ]; then
        if [ ! -f "$dest" ]; then
            echo -e "  ${GREEN}+ NEW${NC}     $dest"
            COPIED=$((COPIED + 1))
            if [ "$used_fallback" = true ]; then
                FALLBACK_NEEDS_NAV=$((FALLBACK_NEEDS_NAV + 1))
                echo "$src → $dest" >> "$FALLBACK_NAV_LOG"
            fi
        elif ! _src_matches_dest "$src" "$dest"; then
            echo -e "  ${CYAN}~ UPDATE${NC}  $dest"
            UPDATED=$((UPDATED + 1))
            if [ "$used_fallback" = true ]; then
                FALLBACK_NEEDS_NAV=$((FALLBACK_NEEDS_NAV + 1))
                echo "$src → $dest" >> "$FALLBACK_NAV_LOG"
            fi
        else
            [ "$VERBOSE" = true ] && echo -e "  ${DIM}= SAME${NC}    $dest"
            UNCHANGED=$((UNCHANGED + 1))
        fi
        return
    fi

    mkdir -p "$(dirname "$dest")"

    if [ ! -f "$dest" ]; then
        cp "$src" "$dest"
        _strip_overview_sidebar "$dest"
        _apply_fixup_sidebar "$src" "$dest"
        echo -e "  ${GREEN}+ NEW${NC}     $dest"
        COPIED=$((COPIED + 1))
        if [ "$used_fallback" = true ]; then
            FALLBACK_NEEDS_NAV=$((FALLBACK_NEEDS_NAV + 1))
            echo "$src → $dest" >> "$FALLBACK_NAV_LOG"
        fi
    elif ! _src_matches_dest "$src" "$dest"; then
        cp "$src" "$dest"
        _strip_overview_sidebar "$dest"
        _apply_fixup_sidebar "$src" "$dest"
        echo -e "  ${CYAN}~ UPDATE${NC}  $dest"
        UPDATED=$((UPDATED + 1))
        if [ "$used_fallback" = true ]; then
            FALLBACK_NEEDS_NAV=$((FALLBACK_NEEDS_NAV + 1))
            echo "$src → $dest" >> "$FALLBACK_NAV_LOG"
        fi
    else
        [ "$VERBOSE" = true ] && echo -e "  ${DIM}= SAME${NC}    $dest"
        UNCHANGED=$((UNCHANGED + 1))
    fi
}

# Strips sidebarTitle: Overview (both quoted and unquoted, handles CRLF) from a file.
# Uses Python because hedera/ source files have CRLF line endings and
# BSD sed's ^...$ anchors do not match CRLF-terminated lines on macOS.
# Only writes back the file if the sidebarTitle line was actually present —
# avoids touching unrelated files and prevents perpetual UPDATE churn.
_strip_overview_sidebar() {
    local dest="$1"
    python3 -c "
import sys, re
dest = sys.argv[1]
with open(dest, newline='') as f:
    content = f.read()
normalized = content.replace('\r\n', '\n').replace('\r', '\n')
# Two passes: unquoted and double-quoted (single-quoted form is not used in practice)
stripped = re.sub(r'^sidebarTitle: Overview\n', '', normalized, flags=re.MULTILINE)
stripped = re.sub(r'^sidebarTitle: \"Overview\"\n', '', stripped, flags=re.MULTILINE)
# Only write back if sidebarTitle: Overview was actually removed (avoids CRLF churn)
if stripped != normalized:
    with open(dest, 'w') as f:
        f.write(stripped)
" "$dest"
}

# Injects the correct sidebarTitle into dest if src has a fixup entry.
_apply_fixup_sidebar() {
    local src="$1"
    local dest="$2"
    if is_fixup_src "$src"; then
        local title
        title=$(get_fixup_title "$src")
        python3 -c "
import sys, re
dest, title = sys.argv[1], sys.argv[2]
with open(dest) as f:
    content = f.read()
# Remove any remaining sidebarTitle line
content = re.sub(r'^sidebarTitle:.*\n', '', content, flags=re.MULTILINE)
# Insert sidebarTitle after the title: line
content = re.sub(r'^(title:.*)$', r'\1\nsidebarTitle: ' + title, content, count=1, flags=re.MULTILINE)
with open(dest, 'w') as f:
    f.write(content)
" "$dest" "$title"
        FIXUP_APPLIED=$((FIXUP_APPLIED + 1))
    fi
}

# ============================================================================
# MAIN MIGRATION
# ============================================================================

echo ""
echo -e "${BLUE}━━━ Scanning hedera/ for .mdx files ━━━${NC}"

# Find all .mdx files in hedera/
while IFS= read -r -d '' src; do
    # Get destination
    dest=$(get_explicit_mapping "$src")
    USED_FALLBACK=false
    if [ -z "$dest" ]; then
        dest=$(get_directory_mapping "$src")
        [ -n "$dest" ] && USED_FALLBACK=true
    fi

    if [ -n "$dest" ]; then
        # Check if this source is protected (manually maintained on dev)
        if is_protected_src "$src"; then
            # Register in manifest to avoid false orphan detection
            echo "$dest" >> "$DEST_MANIFEST"
            # Check if source changed since last review
            current_hash=$(git hash-object "$src" 2>/dev/null || echo "unknown")
            stored_hash=$(get_stored_hash "$src")
            if [ "$current_hash" != "$stored_hash" ]; then
                PROTECTED_CHANGED=$((PROTECTED_CHANGED + 1))
                echo -e "  ${YELLOW}⚠ PROTECTED-CHANGED${NC}  $dest"
                echo -e "    ${DIM}↑ source $src changed upstream — review manually${NC}"
            else
                PROTECTED_SKIPPED=$((PROTECTED_SKIPPED + 1))
                [ "$VERBOSE" = true ] && echo -e "  ${DIM}⊞ PROTECTED${NC}   $dest"
            fi
        else
            sync_file "$src" "$dest" "$USED_FALLBACK"

            # Check fixup hash change once per source (after primary sync)
            if is_fixup_src "$src"; then
                current_hash=$(git hash-object "$src" 2>/dev/null || echo "unknown")
                stored_hash=$(get_fixup_hash "$src")
                if [ "$current_hash" != "$stored_hash" ]; then
                    FIXUP_CONTENT_CHANGED=$((FIXUP_CONTENT_CHANGED + 1))
                    echo -e "    ${YELLOW}⚠ FIXUP-CHANGED${NC}  $dest"
                    echo -e "    ${DIM}  ↑ source changed — verify sidebarTitle is still accurate, then:${NC}"
                    echo -e "    ${DIM}    ./revamp/migrate.sh --ack-fixup=$src${NC}"
                fi
            fi

            # Handle additional copies (never flag as fallback — these are intentional extra destinations)
            extra=$(get_additional_destinations "$src")
            if [ -n "$extra" ]; then
                while IFS= read -r extra_dest; do
                    [ -n "$extra_dest" ] && sync_file "$src" "$extra_dest" "false"
                done <<< "$extra"
            fi
        fi
    else
        UNMAPPED=$((UNMAPPED + 1))
        echo "$src" >> "$UNMAPPED_LOG"
        echo -e "  ${RED}? UNMAPPED${NC} $src"
    fi
done < <(find hedera -name "*.mdx" -type f -print0 | sort -z)

# ============================================================================
# ORPHAN DETECTION
# ============================================================================
# Find destination files that no longer have a corresponding source file.
# These may be from files that were deleted or renamed in hedera/.
#
# NOTE: Dev-authored pages (no hedera/ source) are excluded from orphan
# detection if they appear in the docs.json navigation. This ensures that
# pages like learn/getting-started/index.mdx (written directly on dev) are
# not falsely flagged as orphans.
# ============================================================================

# Pre-populate manifest with all nav-referenced files so dev-authored pages
# that are in the nav are never flagged as orphans.
python3 -c "
import json, sys

def extract_pages(obj):
    pages = set()
    if isinstance(obj, dict):
        for k, v in obj.items():
            if k == 'pages' and isinstance(v, list):
                for item in v:
                    if isinstance(item, str):
                        pages.add(item + '.mdx')
                    elif isinstance(item, dict):
                        pages.update(extract_pages(item))
            elif k in ('groups', 'tabs'):
                pages.update(extract_pages(v))
    elif isinstance(obj, list):
        for item in obj:
            pages.update(extract_pages(item))
    return pages

with open('docs.json') as f:
    data = json.load(f)
nav = data.get('navigation', {})
for p in extract_pages(nav):
    print(p)
" 2>/dev/null >> "$DEST_MANIFEST"

echo ""
echo -e "${BLUE}━━━ Checking for orphaned destination files ━━━${NC}"

DEST_DIRS=("learn" "evm" "native" "operators" "reference" "solutions" "support")
ORPHAN_LIST=""

PLACEHOLDER_COUNT=0

for dir in "${DEST_DIRS[@]}"; do
    [ ! -d "$dir" ] && continue
    while IFS= read -r -d '' dest_file; do
        if ! grep -qxF "$dest_file" "$DEST_MANIFEST" 2>/dev/null; then
            # Check if this is a placeholder created by create-placeholders.sh
            if grep -q "Coming Soon.*This page is under construction" "$dest_file" 2>/dev/null; then
                PLACEHOLDER_COUNT=$((PLACEHOLDER_COUNT + 1))
                [ "$VERBOSE" = true ] && echo -e "  ${DIM}⊞ PLACEHOLDER${NC}  $dest_file"
            else
                ORPHANED=$((ORPHANED + 1))
                ORPHAN_LIST="${ORPHAN_LIST}${dest_file}\n"
                if [ "$CLEAN_ORPHANS" = true ] && [ "$DRY_RUN" = false ]; then
                    rm "$dest_file"
                    echo -e "  ${RED}- REMOVED${NC} $dest_file"
                else
                    echo -e "  ${YELLOW}! ORPHAN${NC}  $dest_file"
                fi
            fi
        fi
    done < <(find "$dir" -name "*.mdx" -type f -print0 | sort -z)
done

if [ "$ORPHANED" -eq 0 ] && [ "$PLACEHOLDER_COUNT" -eq 0 ]; then
    echo -e "  ${GREEN}✓${NC} No orphaned files found"
elif [ "$ORPHANED" -eq 0 ]; then
    echo -e "  ${GREEN}✓${NC} No orphaned files found ($PLACEHOLDER_COUNT placeholder pages skipped)"
fi

# ============================================================================
# UPDATE docs.json
# ============================================================================
# If revamp/docs.json exists, install it as the new navigation config.
# Preserves the backup made earlier for rollback.
# ============================================================================

echo ""
echo -e "${BLUE}━━━ Updating docs.json ━━━${NC}"

SCRIPT_SOURCE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
NEW_DOCS_JSON="$SCRIPT_SOURCE_DIR/docs.json"

if [ -f "$NEW_DOCS_JSON" ]; then
    if [ "$DRY_RUN" = true ]; then
        if ! cmp -s "$NEW_DOCS_JSON" "docs.json"; then
            echo -e "  ${CYAN}~ UPDATE${NC}  docs.json (from revamp/docs.json)"
        else
            echo -e "  ${DIM}= SAME${NC}    docs.json (no changes needed)"
        fi
    else
        if ! cmp -s "$NEW_DOCS_JSON" "docs.json"; then
            cp "$NEW_DOCS_JSON" docs.json
            echo -e "  ${CYAN}~ UPDATE${NC}  docs.json (from revamp/docs.json)"
        else
            echo -e "  ${DIM}= SAME${NC}    docs.json (no changes needed)"
        fi
    fi
else
    echo -e "  ${YELLOW}! SKIP${NC}    revamp/docs.json not found — docs.json unchanged"
    echo -e "  ${YELLOW}          Create revamp/docs.json with the new navigation structure${NC}"
fi

# ============================================================================
# REPORT
# ============================================================================

echo ""
echo -e "${GREEN}═══════════════════════════════════════════════════${NC}"
echo -e "${GREEN}  Migration Complete!${NC}"
echo -e "${GREEN}═══════════════════════════════════════════════════${NC}"
echo ""
echo -e "  ${GREEN}+ New files copied:${NC}    $COPIED"
echo -e "  ${CYAN}~ Files updated:${NC}       $UPDATED"
echo -e "  ${DIM}= Files unchanged:${NC}     $UNCHANGED"

if [ "$UNMAPPED" -gt 0 ]; then
    echo ""
    echo -e "  ${RED}? Unmapped files:${NC}      $UNMAPPED"
    echo -e "  ${YELLOW}  These files exist in hedera/ but have no mapping rule.${NC}"
    echo -e "  ${YELLOW}  Add explicit mappings or directory rules for them.${NC}"
    echo -e "  ${YELLOW}  See unmapped list:${NC}"
    while IFS= read -r line; do
        [ -n "$line" ] && echo -e "    ${RED}→${NC} $line"
    done < "$UNMAPPED_LOG"
fi

if [ "$FALLBACK_NEEDS_NAV" -gt 0 ]; then
    echo ""
    echo -e "  ${YELLOW}⚠ New/updated via directory rule:${NC}  $FALLBACK_NEEDS_NAV"
    echo -e "  ${YELLOW}  These are new or changed files placed by a directory fallback rule.${NC}"
    echo -e "  ${YELLOW}  Verify each destination appears in revamp/docs.json nav,${NC}"
    echo -e "  ${YELLOW}  then run ./revamp/verify.sh to confirm no orphans.${NC}"
    while IFS= read -r line; do
        [ -n "$line" ] && echo -e "    ${CYAN}→${NC} $line"
    done < "$FALLBACK_NAV_LOG"
fi

if [ "$ORPHANED" -gt 0 ]; then
    echo ""
    if [ "$CLEAN_ORPHANS" = true ] && [ "$DRY_RUN" = false ]; then
        echo -e "  ${RED}- Orphans removed:${NC}     $ORPHANED"
    else
        echo -e "  ${YELLOW}! Orphaned files:${NC}      $ORPHANED"
        echo -e "  ${YELLOW}  Run with --clean to remove them${NC}"
    fi
fi

TOTAL_PROTECTED=$((PROTECTED_SKIPPED + PROTECTED_CHANGED))
if [ "$TOTAL_PROTECTED" -gt 0 ]; then
    echo ""
    echo -e "  ${DIM}⊞ Protected (skipped):${NC}  $PROTECTED_SKIPPED"
    if [ "$PROTECTED_CHANGED" -gt 0 ]; then
        echo -e "  ${YELLOW}⚠ Need review:${NC}         $PROTECTED_CHANGED"
        echo -e ""
        echo -e "  ${YELLOW}  One or more protected pages have upstream changes.${NC}"
        echo -e "  ${YELLOW}  Review the source file(s) above, incorporate any relevant${NC}"
        echo -e "  ${YELLOW}  changes into the destination, then acknowledge:${NC}"
        echo -e "  ${YELLOW}    ./revamp/migrate.sh --ack=<source_path>${NC}"
        echo -e "  ${YELLOW}  See revamp/protected-pages.txt for the full registry.${NC}"
    fi
fi

if [ "$FIXUP_APPLIED" -gt 0 ] || [ "$FIXUP_CONTENT_CHANGED" -gt 0 ]; then
    echo ""
    echo -e "  ${DIM}✎ sidebarTitle fixups applied:${NC}  $FIXUP_APPLIED"
    if [ "$FIXUP_CONTENT_CHANGED" -gt 0 ]; then
        echo -e "  ${YELLOW}⚠ Fixups needing review:${NC}        $FIXUP_CONTENT_CHANGED"
        echo -e ""
        echo -e "  ${YELLOW}  One or more fixup sources changed upstream.${NC}"
        echo -e "  ${YELLOW}  Verify the sidebarTitle is still accurate, then:${NC}"
        echo -e "  ${YELLOW}    ./revamp/migrate.sh --ack-fixup=<source_path>${NC}"
        echo -e "  ${YELLOW}    ./revamp/migrate.sh --ack-fixup=all   (approve all at once)${NC}"
        echo -e "  ${YELLOW}  See revamp/sidebar-fixups.txt for the full registry.${NC}"
    fi
fi

if [ "$DRY_RUN" = true ]; then
    echo ""
    echo -e "  ${YELLOW}DRY RUN - no files were modified${NC}"
else
    echo ""
    echo -e "  📁 Backup: $BACKUP"

    # ── Append to sync log ───────────────────────────────────────────────────
    # Only log when main HEAD has changed since the last recorded entry.
    # Re-running migrate.sh on the same commit produces no new log entry.
    # Entries are prepended (newest first) so the file reads top-to-bottom newest→oldest.
    # grep -m1 on "- **main HEAD**" therefore always hits the most recent entry.
    SYNC_LOG="$SCRIPT_DIR/sync-log.md"
    if [ -f "$SYNC_LOG" ]; then
        MAIN_COMMIT=$(git log origin/main -1 --format="%h" 2>/dev/null || git log main -1 --format="%h" 2>/dev/null || echo "unknown")
        MAIN_MSG=$(git log origin/main -1 --format="%s" 2>/dev/null || git log main -1 --format="%s" 2>/dev/null || echo "unknown")
        DEV_COMMIT=$(git log HEAD -1 --format="%h" 2>/dev/null || echo "unknown")
        DEV_MSG=$(git log HEAD -1 --format="%s" 2>/dev/null || echo "unknown")
        # grep -m1 gets the FIRST (most recent) main HEAD line because entries are newest-first
        LAST_MAIN=$(grep -m1 '^\- \*\*main HEAD\*\*' "$SYNC_LOG" 2>/dev/null | grep -o '`[a-f0-9]*`' | tr -d '`' || echo "")
        if [ "$LAST_MAIN" = "$MAIN_COMMIT" ]; then
            echo -e "  ${DIM}📋 Sync log unchanged (main still at $MAIN_COMMIT)${NC}"
        else
            RUN_TIMESTAMP=$(date -u "+%Y-%m-%d %H:%M UTC")
            # Prepend new entry after the "---" header separator (keeps newest at top)
            NEW_ENTRY="## $RUN_TIMESTAMP

- **main HEAD**: \`$MAIN_COMMIT\` — $MAIN_MSG
- **dev HEAD**: \`$DEV_COMMIT\` — $DEV_MSG
- **Stats**: $COPIED new · $UPDATED updated · $UNCHANGED unchanged · $PROTECTED_SKIPPED protected skipped · $FIXUP_APPLIED fixups applied"
            python3 -c "
import sys
log = open('$SYNC_LOG').read()
sep = log.find('\n---\n')
if sep == -1:
    open('$SYNC_LOG', 'a').write('\n' + '''$NEW_ENTRY''' + '\n')
else:
    rest = log[sep+5:].lstrip('\n')
    open('$SYNC_LOG', 'w').write(log[:sep+5] + '\n' + '''$NEW_ENTRY''' + '\n\n' + rest)
"
            echo -e "  📋 Sync record added to revamp/sync-log.md"
        fi
    fi
fi

echo ""
echo -e "${YELLOW}Next steps:${NC}"
echo "  1. Run ./revamp/create-placeholders.sh to create new pages"
echo "  2. Run 'npx mintlify dev' to test the new navigation"
echo ""

# Exit with error if there are unmapped files
if [ "$UNMAPPED" -gt 0 ]; then
    exit 1
fi
