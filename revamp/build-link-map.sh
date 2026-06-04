#!/usr/bin/env bash
# build-link-map.sh — Emit the authoritative legacy-URL -> new-URL table.
#
# Source of truth: the pure mapping functions in migrate.sh
# (get_explicit_mapping, get_directory_mapping). We extract just those
# functions (migrate.sh has no source-guard, so we must NOT source it whole)
# and replay migrate.sh's precedence: explicit first, then directory fallback.
#
# Output (stdout): TSV  "<legacy_url>\t<new_url>"  one row per hedera/ page.
# URLs are extension-less, /index stripped, leading slash. Anchors are NOT
# involved here (links carry their own anchors at rewrite time).
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$REPO_ROOT"
MIGRATE="revamp/migrate.sh"

# --- extract the three pure mapping functions into a temp file and source it ---
FUNCS="$(mktemp)"
trap 'rm -f "$FUNCS"' EXIT
sed -n '348,847p;859,1104p;1114,1122p' "$MIGRATE" > "$FUNCS"
# sanity: all three function headers present
for fn in get_explicit_mapping get_directory_mapping get_additional_destinations; do
    grep -q "^${fn}()" "$FUNCS" || { echo "ERROR: $fn not extracted" >&2; exit 1; }
done
# shellcheck disable=SC1090
source "$FUNCS"

# src path (with .mdx) -> URL (leading slash, no .mdx, no trailing /index)
path_to_url() {
    local p="$1"
    p="${p%.mdx}"
    p="${p%/index}"
    printf '/%s' "$p"
}

# bash 3.2 compatible (macOS default): no associative arrays here. Collision
# detection (one legacy_url -> two new_urls) is done by the Python consumer.
rows=0
while IFS= read -r -d '' src; do
    dest="$(get_explicit_mapping "$src")"
    if [ -z "$dest" ]; then
        dest="$(get_directory_mapping "$src")"
    fi
    [ -z "$dest" ] && continue   # unmapped source: not our concern here (migrate.sh flags it)

    printf '%s\t%s\n' "$(path_to_url "$src")" "$(path_to_url "$dest")"
    rows=$((rows + 1))
done < <(find hedera -type f -name '*.mdx' -print0 | sort -z)

echo "build-link-map: emitted $rows rows" >&2
