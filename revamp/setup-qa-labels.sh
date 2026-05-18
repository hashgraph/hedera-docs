#!/bin/bash
# ============================================================================
# Hedera Docs QA Labels Setup
# ============================================================================
# Creates the minimal set of GitHub labels for the docs revamp QA campaign.
#
# Labels:
#   - 7 tab labels (one per documentation tab) for routing to working-group pairs
#   - 1 campaign label (qa/may-2026) to distinguish QA feedback from regular issues
#
# Priority labels (P1, P3) already exist in the repo and are reused as-is.
# Type labels (broken-link, outdated-code, etc.) intentionally omitted —
# the issue title and body convey this information without needing taxonomy.
#
# Usage:
#   ./revamp/setup-qa-labels.sh
#
# Requires: gh CLI authenticated against the hedera-docs repo
# Safe to re-run: --force updates existing labels rather than erroring
# ============================================================================

set -e

echo "Creating tab labels..."
gh label create "tab/learn"     --color "0E8A16" --description "Issue in the Learn tab" --force
gh label create "tab/evm"       --color "1D76DB" --description "Issue in the EVM Developers tab" --force
gh label create "tab/native"    --color "5319E7" --description "Issue in the Native SDKs tab" --force
gh label create "tab/operators" --color "B60205" --description "Issue in the Operators tab" --force
gh label create "tab/reference" --color "FBCA04" --description "Issue in the Reference tab" --force
gh label create "tab/solutions" --color "D93F0B" --description "Issue in the Solutions tab" --force
gh label create "tab/support"   --color "5DADE2" --description "Issue in the Support tab" --force

echo "Creating QA campaign label..."
gh label create "qa/may-2026"   --color "0E8A16" --description "Filed during May 15–20 QA testing window" --force

echo ""
echo "Done. 8 labels created/updated."
echo "Testers should apply: 1 tab label + qa/may-2026 (+ optional priority)."