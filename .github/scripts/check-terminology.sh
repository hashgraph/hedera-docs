#!/usr/bin/env bash
# Fails if a changed .mdx file introduces a retired terminology term.
# Word list: .github/terminology-banned.txt  (===-delimited: pattern===suggestion)
# Canonical reference: support/contributing/style-guide/terminology.mdx
#
# Usage: check-terminology.sh <file> [<file> ...]
# The workflow passes the PR's changed .mdx files as arguments.

set -uo pipefail

BANNED_FILE="$(cd "$(dirname "$0")/.." && pwd)/terminology-banned.txt"

# Paths exempt from the standard:
#  - reference/      : protobuf / REST API pages where `alias` is the real field
#  - release-notes   : historical records, left as published
#  - the terminology page and the word list themselves
is_exempt() {
  case "$1" in
    reference/*) return 0 ;;
    *release-notes*) return 0 ;;
    support/contributing/style-guide/terminology.mdx) return 0 ;;
    .github/terminology-banned.txt) return 0 ;;
    *) return 1 ;;
  esac
}

if [[ ! -f "$BANNED_FILE" ]]; then
  echo "::error::Cannot find $BANNED_FILE"
  exit 2
fi

violations=0

for file in "$@"; do
  [[ "$file" == *.mdx ]] || continue
  [[ -f "$file" ]] || continue
  is_exempt "$file" && continue

  while IFS= read -r entry; do
    [[ -z "$entry" || "$entry" == \#* ]] && continue
    pattern="${entry%%===*}"
    suggestion="${entry#*===}"

    while IFS= read -r hit; do
      [[ -z "$hit" ]] && continue
      lineno="${hit%%:*}"
      text="${hit#*:}"
      echo "::error file=${file},line=${lineno}::Retired term in \"${text# }\" -> ${suggestion}. See support/contributing/style-guide/terminology.mdx"
      violations=$((violations + 1))
    done < <(grep -niE "$pattern" "$file" || true)
  done < "$BANNED_FILE"
done

echo ""
if [[ "$violations" -gt 0 ]]; then
  echo "Found ${violations} retired-terminology occurrence(s) in changed .mdx files. See annotations above."
  echo "Standard: support/contributing/style-guide/terminology.mdx"
  exit 1
fi

echo "Terminology check passed: no retired terms in changed .mdx files."
