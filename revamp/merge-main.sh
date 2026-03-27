#!/usr/bin/env bash
# ============================================================================
# revamp/merge-main.sh — Safe merge of origin/main → dev
# ============================================================================
# Use this instead of "git merge origin/main" to safely sync main into the
# dev revamp branch. It handles the structural docs.json conflict automatically
# and reports new content that needs attention before you run migrate.sh.
#
# Usage:
#   ./revamp/merge-main.sh           # Full merge + report
#   ./revamp/merge-main.sh --dry-run # Report only, do not merge
#
# What it does:
#   1. Fetches origin/main
#   2. Detects new hedera/ pages and new docs.json nav entries (pre-merge)
#   3. Merges origin/main → dev with --no-commit so we can sign properly
#   4. Auto-resolves the inevitable docs.json conflict (keeps dev's revamp nav)
#   5. Commits the merge with GPG signing + DCO signoff (-S -s)
#   6. Prints an action checklist for any new pages that need attention
#
# Why docs.json always conflicts:
#   dev's docs.json is the 7-tab revamp navigation structure.
#   main's docs.json is the production (hedera/) navigation structure.
#   They are structurally incompatible and WILL conflict on every merge.
#   This is expected — we always resolve by keeping dev's version.
#
# After merging, run:
#   ./revamp/migrate.sh    — propagate content changes to revamp structure
#   ./revamp/verify.sh     — validate everything (11 checks)
# ============================================================================

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
cd "$REPO_ROOT"

# ── Colors ──────────────────────────────────────────────────────────────────
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
RED='\033[0;31m'
CYAN='\033[0;36m'
DIM='\033[2m'
NC='\033[0m'

# ── Parse flags ──────────────────────────────────────────────────────────────
DRY_RUN=false
for arg in "$@"; do
    case "$arg" in
        --dry-run) DRY_RUN=true ;;
        --help|-h)
            echo "Usage: ./revamp/merge-main.sh [--dry-run]"
            echo ""
            echo "  --dry-run   Report new content only; do not run git merge."
            exit 0
            ;;
    esac
done

# ── Guard: must be on dev ────────────────────────────────────────────────────
BRANCH=$(git rev-parse --abbrev-ref HEAD)
if [ "$BRANCH" != "dev" ]; then
    echo -e "${RED}Error: Must be on 'dev' branch (currently '$BRANCH').${NC}"
    echo "  Switch with: git checkout dev"
    exit 1
fi

if [ ! -d "hedera" ] || [ ! -f "docs.json" ]; then
    echo -e "${RED}Error: Run this from the hedera-docs repo root.${NC}"
    exit 1
fi

echo -e "${BLUE}═══════════════════════════════════════════════════${NC}"
echo -e "${BLUE}  Hedera Docs — Merge main → dev${NC}"
echo -e "${BLUE}═══════════════════════════════════════════════════${NC}"
echo ""

# ── Fetch origin/main ────────────────────────────────────────────────────────
echo -e "${BLUE}━━━ Fetching origin/main ━━━${NC}"
git fetch origin main --quiet
echo -e "  ${GREEN}✓${NC} Fetched"

MAIN_COMMIT=$(git rev-parse origin/main)
MAIN_SHORT=$(git rev-parse --short origin/main)
MAIN_MSG=$(git log -1 --format="%s" origin/main)
DEV_SHORT=$(git rev-parse --short HEAD)

echo -e "  origin/main: ${CYAN}$MAIN_SHORT${NC} — $MAIN_MSG"
echo -e "  dev HEAD:    ${DIM}$DEV_SHORT${NC}"
echo ""

# ── Already up to date? ──────────────────────────────────────────────────────
if git merge-base --is-ancestor origin/main HEAD; then
    echo -e "${GREEN}  Already up to date with origin/main ($MAIN_SHORT). Nothing to do.${NC}"
    exit 0
fi

# ── Pre-merge analysis ───────────────────────────────────────────────────────
echo -e "${BLUE}━━━ Pre-merge analysis ━━━${NC}"

# New .mdx files added to hedera/ on main
NEW_MDX=$(git diff HEAD...origin/main --name-only --diff-filter=A | grep '^hedera/.*\.mdx$' | sort || true)
# Modified .mdx files
MOD_MDX_COUNT=$(git diff HEAD...origin/main --name-only --diff-filter=M | grep '^hedera/.*\.mdx$' | wc -l | tr -d ' ')
# New entries added to main's docs.json
NEW_NAV=$(git diff HEAD...origin/main -- docs.json | grep '^+' | grep -oE '"hedera/[^"]+"' | tr -d '"' | sort -u || true)
# New image files
NEW_IMGS=$(git diff HEAD...origin/main --name-only --diff-filter=A | grep '^images/' | wc -l | tr -d ' ')

NEEDS_ACTION=false

if [ -n "$NEW_MDX" ]; then
    NEEDS_ACTION=true
    NEW_COUNT=$(echo "$NEW_MDX" | wc -l | tr -d ' ')
    echo -e "  ${YELLOW}⚠  $NEW_COUNT new hedera/ page(s) — need migrate.sh mapping + revamp nav:${NC}"
    while IFS= read -r f; do
        echo -e "     ${CYAN}+${NC} $f"
    done <<< "$NEW_MDX"
else
    echo -e "  ${DIM}✓  No new hedera/ pages${NC}"
fi

if [ "$MOD_MDX_COUNT" -gt 0 ]; then
    echo -e "  ${DIM}~  $MOD_MDX_COUNT hedera/ page(s) modified — migrate.sh will sync content${NC}"
fi

if [ "$NEW_IMGS" -gt 0 ]; then
    echo -e "  ${DIM}+  $NEW_IMGS new image(s) — will be brought in by the merge${NC}"
fi

if [ -n "$NEW_NAV" ]; then
    echo -e "  ${YELLOW}⚠  New entries in main's docs.json (ensure revamp/docs.json has equivalents):${NC}"
    while IFS= read -r p; do
        echo -e "     ${CYAN}+${NC} $p"
    done <<< "$NEW_NAV"
else
    echo -e "  ${DIM}✓  No new docs.json nav entries${NC}"
fi

echo ""

if [ "$DRY_RUN" = true ]; then
    echo -e "${YELLOW}  --dry-run mode: stopping here. No files changed.${NC}"
    echo ""
    if [ "$NEEDS_ACTION" = true ]; then
        echo -e "  ${YELLOW}Action needed before running migrate.sh:${NC}"
        echo -e "  For each new hedera/ page listed above:"
        echo -e "    1. Add an explicit mapping in ${CYAN}revamp/migrate.sh${NC} (get_explicit_mapping function)"
        echo -e "    2. Add the destination path to ${CYAN}revamp/docs.json${NC} navigation"
        echo -e "    3. Optionally add a sidebarTitle fixup in ${CYAN}revamp/sidebar-fixups.txt${NC}"
        echo ""
        echo -e "  Then run: ${CYAN}./revamp/merge-main.sh${NC}  (without --dry-run)"
    fi
    exit 0
fi

# ── Run git merge ────────────────────────────────────────────────────────────
echo -e "${BLUE}━━━ Merging origin/main → dev ━━━${NC}"

# Use --no-commit so we can always sign the merge commit ourselves.
# --no-ff ensures a merge commit is created even if fast-forward is possible.
set +e
git merge origin/main --no-ff --no-commit 2>&1
MERGE_EXIT=$?
set -e

# Check for conflicts
CONFLICT_FILES=$(git diff --name-only --diff-filter=U 2>/dev/null || true)

if [ -n "$CONFLICT_FILES" ]; then
    NON_DOCS=$(echo "$CONFLICT_FILES" | grep -v '^docs\.json$' || true)
    if [ -n "$NON_DOCS" ]; then
        echo -e "${RED}  Merge conflicts in files other than docs.json:${NC}"
        while IFS= read -r f; do
            echo -e "    ${RED}✗${NC} $f"
        done <<< "$NON_DOCS"
        echo ""
        echo -e "${YELLOW}  Resolve these conflicts manually, then:${NC}"
        echo -e "    git add <resolved files>"
        echo -e "    git commit -S -s"
        echo ""
        echo -e "  Or abort with: ${CYAN}git merge --abort${NC}"
        exit 1
    fi

    # Auto-resolve docs.json: always keep dev's revamp structure
    git checkout --ours docs.json
    git add docs.json
    echo -e "  ${YELLOW}⚠${NC}  docs.json conflict auto-resolved (kept dev's revamp 7-tab structure)"
    echo -e "  ${DIM}   This is expected — main and dev have incompatible nav structures.${NC}"
fi

# Commit the merge (signed + DCO signoff)
MERGE_MSG_FILE=".git/MERGE_MSG"
if [ -f "$MERGE_MSG_FILE" ]; then
    MERGE_HEADLINE=$(head -1 "$MERGE_MSG_FILE")
else
    MERGE_HEADLINE="Merge origin/main into dev"
fi

git commit -S -s -m "$MERGE_HEADLINE" 2>/dev/null || \
git commit -s -m "$MERGE_HEADLINE"

NEW_DEV_SHORT=$(git rev-parse --short HEAD)
echo -e "  ${GREEN}✓${NC}  Merged → dev at ${CYAN}$NEW_DEV_SHORT${NC}"
echo ""

# ── Post-merge action checklist ──────────────────────────────────────────────
echo -e "${BLUE}━━━ Next steps ━━━${NC}"

if [ "$NEEDS_ACTION" = true ] && [ -n "$NEW_MDX" ]; then
    echo -e "  ${YELLOW}Action required for new page(s):${NC}"
    while IFS= read -r f; do
        BASE=$(basename "$f" .mdx)
        echo -e ""
        echo -e "  ${CYAN}$f${NC}"
        echo -e "    1. Add explicit mapping in ${CYAN}revamp/migrate.sh${NC} → get_explicit_mapping()"
        echo -e "       Pattern: \"$f\") echo \"<revamp/dest/path.mdx>\" ;;"
        echo -e "    2. Add destination to ${CYAN}revamp/docs.json${NC} navigation"
        echo -e "    3. Optionally add sidebarTitle in ${CYAN}revamp/sidebar-fixups.txt${NC}"
        echo -e "       Format: \$(git hash-object $f)|$f|<dest>|$BASE"
    done <<< "$NEW_MDX"
    echo ""
fi

echo -e "  Run: ${CYAN}./revamp/migrate.sh${NC}       propagate content to revamp structure"
echo -e "  Run: ${CYAN}./revamp/verify.sh${NC}        validate all 11 checks"
echo -e "  Run: ${CYAN}git add -A && git commit -S -s -m 'docs: sync dev with main ($MAIN_SHORT — ...)'${NC}"
echo ""
