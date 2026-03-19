#!/bin/bash
# ============================================================================
# Hedera Documentation Verification Script v1.0
# ============================================================================
# Validates the migrated documentation structure for correctness.
#
# Checks:
#   1. Migration coverage — every .mdx in hedera/ has a mapping
#   2. Nav integrity — every page in docs.json exists on disk
#   3. No orphaned files — every .mdx in dest dirs is in nav or a placeholder
#   4. No duplicate nav entries — same page path doesn't appear twice
#   5. Valid JSON — docs.json passes JSON validation
#   6. No broken imports — snippet imports reference existing files
#
# Usage:
#   ./revamp/verify.sh          # Run all checks
#   ./revamp/verify.sh --fix    # Also show suggested fixes
#   ./revamp/verify.sh --help   # Show usage
#
# Exit codes:
#   0 — all checks passed
#   1 — one or more checks failed
# ============================================================================

set -e

# ── Colors ──────────────────────────────────────────────────────────────────
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
RED='\033[0;31m'
DIM='\033[2m'
NC='\033[0m'

# ── Navigate to repo root ──────────────────────────────────────────────────
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." 2>/dev/null && pwd)"
if [ -f "$SCRIPT_DIR/docs.json" ] && [ -d "$SCRIPT_DIR/hedera" ]; then
    REPO_ROOT="$SCRIPT_DIR"
fi
cd "$REPO_ROOT"

if [ ! -f "docs.json" ] || [ ! -d "hedera" ]; then
    echo -e "${RED}Error: Cannot find hedera-docs repo root.${NC}"
    exit 1
fi

# ── Parse flags ─────────────────────────────────────────────────────────────
SHOW_FIX=false
for arg in "$@"; do
    case "$arg" in
        --fix)  SHOW_FIX=true ;;
        --help)
            echo "Usage: ./revamp/verify.sh [OPTIONS]"
            echo ""
            echo "Options:"
            echo "  --fix    Show suggested fixes for issues found"
            echo "  --help   Show this help message"
            echo ""
            echo "Exit codes:"
            echo "  0 — all checks passed"
            echo "  1 — one or more checks failed"
            exit 0
            ;;
    esac
done

# ── Counters ────────────────────────────────────────────────────────────────
CHECKS_PASSED=0
CHECKS_FAILED=0
WARNINGS=0

pass() {
    CHECKS_PASSED=$((CHECKS_PASSED + 1))
    echo -e "  ${GREEN}PASS${NC}  $1"
}

fail() {
    CHECKS_FAILED=$((CHECKS_FAILED + 1))
    echo -e "  ${RED}FAIL${NC}  $1"
}

warn() {
    WARNINGS=$((WARNINGS + 1))
    echo -e "  ${YELLOW}WARN${NC}  $1"
}

detail() {
    echo -e "        ${DIM}$1${NC}"
}

# ── Banner ──────────────────────────────────────────────────────────────────
echo -e "${BLUE}═══════════════════════════════════════════════════${NC}"
echo -e "${BLUE}  Hedera Documentation Verification v1.0${NC}"
echo -e "${BLUE}═══════════════════════════════════════════════════${NC}"
echo -e "${DIM}Repo root: $(pwd)${NC}"
echo ""

# ============================================================================
# CHECK 1: Valid JSON
# ============================================================================
echo -e "${BLUE}━━━ Check 1: docs.json validity ━━━${NC}"

if python3 -m json.tool docs.json > /dev/null 2>&1; then
    pass "docs.json is valid JSON"
else
    fail "docs.json is NOT valid JSON"
    detail "Run: python3 -m json.tool docs.json"
fi

# Check revamp/docs.json matches root docs.json
if [ -f "revamp/docs.json" ]; then
    if cmp -s "revamp/docs.json" "docs.json"; then
        pass "docs.json matches revamp/docs.json"
    else
        warn "docs.json differs from revamp/docs.json"
        detail "Run ./revamp/migrate.sh to sync"
    fi
fi

# ============================================================================
# CHECK 2: Navigation integrity — every page in docs.json exists on disk
# ============================================================================
echo ""
echo -e "${BLUE}━━━ Check 2: Navigation references ━━━${NC}"

# Extract all page paths from docs.json
NAV_PAGES=$(python3 -c "
import json, sys

def extract_pages(obj):
    pages = set()
    if isinstance(obj, dict):
        for k, v in obj.items():
            if k == 'pages' and isinstance(v, list):
                for item in v:
                    if isinstance(item, str):
                        pages.add(item)
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
pages = extract_pages(nav)
for p in sorted(pages):
    print(p)
" 2>/dev/null)

MISSING_NAV=0
TOTAL_NAV=0

while IFS= read -r page; do
    [ -z "$page" ] && continue
    TOTAL_NAV=$((TOTAL_NAV + 1))

    # Check for .mdx file
    if [ -f "${page}.mdx" ]; then
        continue
    fi

    # Check for index.mdx in directory
    if [ -f "${page}/index.mdx" ]; then
        # This means the nav reference should use /index suffix
        MISSING_NAV=$((MISSING_NAV + 1))
        detail "MISSING: ${page}.mdx (exists as ${page}/index.mdx — use \"${page}/index\" in nav)"
        continue
    fi

    MISSING_NAV=$((MISSING_NAV + 1))
    detail "MISSING: ${page}.mdx"
done <<< "$NAV_PAGES"

if [ "$MISSING_NAV" -eq 0 ]; then
    pass "All $TOTAL_NAV navigation pages exist on disk"
else
    fail "$MISSING_NAV of $TOTAL_NAV navigation pages are missing"
    [ "$SHOW_FIX" = true ] && detail "Fix: Create the missing .mdx files or update docs.json paths"
fi

# ============================================================================
# CHECK 3: Migration coverage — every .mdx in hedera/ has a mapping
# ============================================================================
echo ""
echo -e "${BLUE}━━━ Check 3: Migration coverage ━━━${NC}"

UNMAPPED=0
TOTAL_SOURCE=0

if [ -f "revamp/migrate.sh" ]; then
    # Source the mapping functions from migrate.sh by extracting them
    # Instead, just run migrate.sh --dry-run and check for UNMAPPED
    MIGRATE_OUTPUT=$(bash revamp/migrate.sh --dry-run 2>&1)
    UNMAPPED_COUNT=$(echo "$MIGRATE_OUTPUT" | grep -c "UNMAPPED" || true)
    TOTAL_SOURCE=$(find hedera -name "*.mdx" -type f | wc -l | tr -d ' ')

    if [ "$UNMAPPED_COUNT" -eq 0 ]; then
        pass "All $TOTAL_SOURCE source files in hedera/ have mappings"
    else
        fail "$UNMAPPED_COUNT source files have no mapping"
        echo "$MIGRATE_OUTPUT" | grep "UNMAPPED" | while read -r line; do
            detail "$line"
        done
        [ "$SHOW_FIX" = true ] && detail "Fix: Add mappings in revamp/migrate.sh for unmapped files"
    fi
else
    warn "revamp/migrate.sh not found — skipping coverage check"
fi

# ============================================================================
# CHECK 4: No duplicate page references in docs.json
# ============================================================================
echo ""
echo -e "${BLUE}━━━ Check 4: Duplicate navigation entries ━━━${NC}"

DUPLICATES=$(echo "$NAV_PAGES" | sort | uniq -d)

if [ -z "$DUPLICATES" ]; then
    pass "No duplicate page references in docs.json"
else
    DUP_COUNT=$(echo "$DUPLICATES" | wc -l | tr -d ' ')
    fail "$DUP_COUNT duplicate page references found"
    echo "$DUPLICATES" | while read -r dup; do
        detail "DUPLICATE: $dup"
    done
    [ "$SHOW_FIX" = true ] && detail "Fix: Remove duplicate entries from docs.json navigation"
fi

# ============================================================================
# CHECK 5: Orphaned destination files
# ============================================================================
echo ""
echo -e "${BLUE}━━━ Check 5: Orphaned destination files ━━━${NC}"

DEST_DIRS=("learn" "evm" "native" "operators" "reference" "solutions" "support")
ORPHAN_COUNT=0
PLACEHOLDER_COUNT=0

for dir in "${DEST_DIRS[@]}"; do
    [ ! -d "$dir" ] && continue
    while IFS= read -r -d '' dest_file; do
        # Strip .mdx extension to get the nav path
        nav_path="${dest_file%.mdx}"

        # Check if it's in the navigation
        if echo "$NAV_PAGES" | grep -qxF "$nav_path"; then
            continue
        fi

        # Check if it's a placeholder (created by create-placeholders.sh)
        if grep -q "Coming Soon.*This page is under construction" "$dest_file" 2>/dev/null; then
            PLACEHOLDER_COUNT=$((PLACEHOLDER_COUNT + 1))
            continue
        fi

        # It's an orphan — not in nav and not a placeholder
        ORPHAN_COUNT=$((ORPHAN_COUNT + 1))
        detail "ORPHAN: $dest_file"
    done < <(find "$dir" -name "*.mdx" -type f -print0 | sort -z)
done

if [ "$ORPHAN_COUNT" -eq 0 ]; then
    MSG="No orphaned files"
    [ "$PLACEHOLDER_COUNT" -gt 0 ] && MSG="$MSG ($PLACEHOLDER_COUNT placeholders not yet in nav)"
    pass "$MSG"
else
    fail "$ORPHAN_COUNT orphaned files (not in nav, not placeholders)"
    [ "$SHOW_FIX" = true ] && detail "Fix: Add these files to docs.json nav or remove them"
fi

# ============================================================================
# CHECK 6: Broken snippet imports
# ============================================================================
echo ""
echo -e "${BLUE}━━━ Check 6: Snippet imports ━━━${NC}"

BROKEN_IMPORTS=0

for dir in "${DEST_DIRS[@]}"; do
    [ ! -d "$dir" ] && continue
    while IFS= read -r -d '' mdx_file; do
        # Find import statements referencing /snippets/
        while IFS= read -r import_line; do
            # Extract the path from: import X from '/snippets/foo.mdx';
            snippet_path=$(echo "$import_line" | grep -o "'/[^']*'" | tr -d "'" | head -1)
            if [ -n "$snippet_path" ]; then
                # Strip leading / to make it relative to repo root
                rel_path="${snippet_path#/}"
                if [ ! -f "$rel_path" ]; then
                    BROKEN_IMPORTS=$((BROKEN_IMPORTS + 1))
                    detail "BROKEN: $mdx_file imports $snippet_path (file not found)"
                fi
            fi
        done < <(grep -n "^import.*from.*'/snippets/" "$mdx_file" 2>/dev/null || true)
    done < <(find "$dir" -name "*.mdx" -type f -print0)
done

if [ "$BROKEN_IMPORTS" -eq 0 ]; then
    pass "All snippet imports resolve correctly"
else
    fail "$BROKEN_IMPORTS broken snippet imports"
    [ "$SHOW_FIX" = true ] && detail "Fix: Ensure snippet files exist or update import paths"
fi

# ============================================================================
# CHECK 7: Tab structure validation
# ============================================================================
echo ""
echo -e "${BLUE}━━━ Check 7: Tab structure ━━━${NC}"

TAB_CHECK=$(python3 -c "
import json

with open('docs.json') as f:
    data = json.load(f)

nav = data.get('navigation', {})
tabs = nav.get('tabs', [])

if not tabs:
    print('NO_TABS')
else:
    issues = []
    for i, tab in enumerate(tabs):
        name = tab.get('tab', f'tab[{i}]')
        has_groups = 'groups' in tab
        has_pages = 'pages' in tab
        if not has_groups and not has_pages:
            issues.append(f'{name}: no groups or pages')
    if issues:
        for issue in issues:
            print(f'ISSUE:{issue}')
    else:
        print(f'OK:{len(tabs)}')
" 2>/dev/null)

if [[ "$TAB_CHECK" == "NO_TABS" ]]; then
    fail "No tabs defined in docs.json navigation"
elif [[ "$TAB_CHECK" == OK:* ]]; then
    TAB_COUNT="${TAB_CHECK#OK:}"
    pass "$TAB_COUNT tabs defined with valid structure"
else
    echo "$TAB_CHECK" | grep "^ISSUE:" | while read -r line; do
        fail "${line#ISSUE:}"
    done
fi

# ============================================================================
# CHECK 8: Destination directories exist
# ============================================================================
echo ""
echo -e "${BLUE}━━━ Check 8: Directory structure ━━━${NC}"

MISSING_DIRS=0
for dir in "${DEST_DIRS[@]}"; do
    if [ ! -d "$dir" ]; then
        MISSING_DIRS=$((MISSING_DIRS + 1))
        detail "MISSING DIR: $dir/"
    fi
done

if [ "$MISSING_DIRS" -eq 0 ]; then
    # Count total .mdx files across all dest dirs
    TOTAL_DEST=$(find "${DEST_DIRS[@]}" -name "*.mdx" -type f 2>/dev/null | wc -l | tr -d ' ')
    pass "All ${#DEST_DIRS[@]} destination directories exist ($TOTAL_DEST total .mdx files)"
else
    fail "$MISSING_DIRS destination directories missing"
    [ "$SHOW_FIX" = true ] && detail "Fix: Run ./revamp/migrate.sh to create the structure"
fi

# ============================================================================
# CHECK 9: Protected pages — detect unacknowledged upstream changes
# ============================================================================
echo ""
echo -e "${BLUE}━━━ Check 9: Protected pages ━━━${NC}"

PROTECTED_FILE="revamp/protected-pages.txt"
if [ ! -f "$PROTECTED_FILE" ]; then
    warn "revamp/protected-pages.txt not found — skipping protected pages check"
else
    PROT_TOTAL=0
    PROT_CHANGED=0

    while IFS= read -r line; do
        [[ "$line" =~ ^[[:space:]]*# ]] && continue
        [ -z "$line" ] && continue
        IFS='|' read -r hash src dest reason <<< "$line"
        [ -z "$src" ] && continue
        PROT_TOTAL=$((PROT_TOTAL + 1))

        if [ ! -f "$src" ]; then
            warn "Protected source no longer exists: $src"
            detail "Remove entry from revamp/protected-pages.txt if source was deleted"
            continue
        fi

        current_hash=$(git hash-object "$src" 2>/dev/null || echo "unknown")
        if [ "$current_hash" != "$hash" ]; then
            PROT_CHANGED=$((PROT_CHANGED + 1))
            detail "UPSTREAM CHANGE: $src → $dest"
            detail "  Review source, update destination if needed, then:"
            detail "  ./revamp/migrate.sh --ack=$src"
        fi
    done < "$PROTECTED_FILE"

    if [ "$PROT_CHANGED" -eq 0 ]; then
        pass "$PROT_TOTAL protected page(s) — all up to date"
    else
        warn "$PROT_CHANGED of $PROT_TOTAL protected page(s) have unacknowledged upstream changes"
        [ "$SHOW_FIX" = true ] && detail "Fix: Review source changes and run ./revamp/migrate.sh --ack=<source>"
    fi
fi

# ============================================================================
# REPORT
# ============================================================================
echo ""
echo -e "${BLUE}═══════════════════════════════════════════════════${NC}"

TOTAL=$((CHECKS_PASSED + CHECKS_FAILED))

if [ "$CHECKS_FAILED" -eq 0 ]; then
    echo -e "${GREEN}  All $CHECKS_PASSED checks passed!${NC}"
    if [ "$WARNINGS" -gt 0 ]; then
        echo -e "${YELLOW}  ($WARNINGS warnings)${NC}"
    fi
    echo -e "${BLUE}═══════════════════════════════════════════════════${NC}"
    exit 0
else
    echo -e "${RED}  $CHECKS_FAILED of $TOTAL checks failed${NC}"
    if [ "$WARNINGS" -gt 0 ]; then
        echo -e "${YELLOW}  ($WARNINGS warnings)${NC}"
    fi
    echo -e ""
    echo -e "  Run with ${YELLOW}--fix${NC} for suggested fixes"
    echo -e "${BLUE}═══════════════════════════════════════════════════${NC}"
    exit 1
fi
