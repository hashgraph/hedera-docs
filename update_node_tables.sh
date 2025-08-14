#!/usr/bin/env bash
set -euo pipefail

# ──────────────────────────────────────────────────────────────────────────────
# config
# ──────────────────────────────────────────────────────────────────────────────
BASE_URL="https://mainnet.mirrornode.hedera.com/api/v1/network/nodes?limit=100&order=asc"
DOC_FILE="networks/mainnet/mainnet-nodes/README.md"

TABLE_A_START="<!-- TABLE A START -->"
TABLE_A_END="<!-- TABLE A END -->"
TABLE_B_START="<!-- TABLE B START -->"
TABLE_B_END="<!-- TABLE B END -->"

# ──────────────────────────────────────────────────────────────────────────────
# temp files and cleanup
# ──────────────────────────────────────────────────────────────────────────────
acc_file="$(mktemp)"
page_file="$(mktemp)"
trap 'rm -f "$acc_file" "$page_file" "${DOC_FILE}.tmp" "${DOC_FILE}.bak" 2>/dev/null || true' EXIT

# initialize accumulator
printf '%s\n' '{"nodes":[]}' > "$acc_file"

# ──────────────────────────────────────────────────────────────────────────────
# fetch all pages (no huge argv to jq)
# ──────────────────────────────────────────────────────────────────────────────
echo "ℹ️ fetching all nodes via pagination..."
url="$BASE_URL"
while [ -n "${url:-}" ]; do
  echo "→ GET $url"
  if ! curl -sS --fail --max-time 30 "$url" -o "$page_file"; then
    echo "❌ fetch failed: $url"
    exit 1
  fi

  # append nodes from this page to the accumulator using files (avoids argv blowups)
  jq -s '{
    nodes: (.[0].nodes + (.[1].nodes // []))
  }' "$acc_file" "$page_file" > "${acc_file}.new"
  mv "${acc_file}.new" "$acc_file"

  # follow pagination; mirror returns a relative path for next
  next_rel="$(jq -r '.links.next // empty' < "$page_file")"
  if [ -n "$next_rel" ]; then
    case "$next_rel" in
      http*) url="$next_rel" ;;
      /*)    url="https://mainnet.mirrornode.hedera.com$next_rel" ;;
      *)     url="" ;;
    esac
  else
    url=""
  fi
done

# normalize, de-dupe, and project fields (stdin, not argv)
nodes_json="$(
  jq '
    .nodes
    | map(select(.node_id != null))
    | sort_by(.node_id)
    | unique_by(.node_id)
    | map({
        node_id,
        description,
        node_account_id,
        service_endpoints,
        node_cert_hash,
        public_key
      })
  ' < "$acc_file"
)"

node_count="$(jq 'length' <<<"$nodes_json")"
echo "ℹ️ found $node_count nodes"
[ "$node_count" -eq 0 ] && { echo "⚠️ no nodes found; aborting"; exit 1; }

# ──────────────────────────────────────────────────────────────────────────────
# build table a (markdown)
# ──────────────────────────────────────────────────────────────────────────────
echo "ℹ️ building table a (markdown)..."
tableA_header="| Node | Node ID | Node Account ID | Endpoints | Node Certificate Thumbprint |
|------|---------|-----------------|-----------|--------------------------------|
"

tableA_rows="$(
  jq -r '
    map({
      node: (
        if (.description // "") == "" then "N/A"
        else (
          # capture either "Hosted by X" or "Hosted for X" when present
          try ((.description | capture("Hosted (by|for) (?<node>[^|]+)")).node)
          catch .description
        ) end
      ),
      id: .node_id,
      acct: .node_account_id,
      endpoints: (
        (
          [.service_endpoints[]? |
            if (.ip_address_v4 // "") != "" and (.port // null) != null
              then "\(.ip_address_v4):\(.port)"
            elif (.ip_address_v6 // "") != "" and (.port // null) != null
              then "[\(.ip_address_v6)]:\(.port)"
            else empty
            end
          ]
        ) | join(",<br>")
      ),
      thumb: .node_cert_hash
    })
    | sort_by(.id)
    | .[]
    | "| \(.node) | \(.id) | **\(.acct // "N/A")** | \(.endpoints // "N/A") | \(.thumb // "N/A") |"
  ' <<<"$nodes_json"
)"
tableA_content="${tableA_header}${tableA_rows}"
echo "ℹ️ table a built."

# ──────────────────────────────────────────────────────────────────────────────
# build table b (markdown)
# ──────────────────────────────────────────────────────────────────────────────
echo "ℹ️ building table b (markdown)..."
tableB_header="| Node Account ID | Public Key |
|-----------------|-----------|
"

tableB_rows="$(
  jq -r '
    map(select(.public_key != null))
    | sort_by(.node_id)
    | .[]
    | "| **\(.node_account_id // "N/A")** | \(.public_key // "N/A") |"
  ' <<<"$nodes_json"
)"
tableB_content="${tableB_header}${tableB_rows}"
echo "ℹ️ table b built."

# ──────────────────────────────────────────────────────────────────────────────
# injection helper
# ──────────────────────────────────────────────────────────────────────────────
inject_table() {
  local file_to_update="$1" start_marker="$2" end_marker="$3" content_to_inject="$4"
  local tmp_content
  tmp_content="$(mktemp)"
  printf "%s\n" "$content_to_inject" > "$tmp_content"

  cp "$file_to_update" "${file_to_update}.bak" || true
  echo "ℹ️ created backup: ${file_to_update}.bak"

  awk -v start="$start_marker" -v end="$end_marker" -v tf="$tmp_content" '
  {
    if ($0 == start) {
      print
      print ""
      while ((getline line < tf) > 0) { print line }
      print ""
      inblock=1; next
    }
    if ($0 == end) { inblock=0; print; next }
    if (!inblock) { print }
  }' "$file_to_update" > "${file_to_update}.tmp" && mv "${file_to_update}.tmp" "$file_to_update"

  rm -f "$tmp_content"
}

# ensure doc file exists with markers
if [ ! -f "$DOC_FILE" ]; then
  echo "ℹ️ $DOC_FILE not found. creating a placeholder with markers."
  mkdir -p "$(dirname "$DOC_FILE")"
  printf "%s\n%s\n\n%s\n%s\n" "$TABLE_A_START" "$TABLE_A_END" "$TABLE_B_START" "$TABLE_B_END" > "$DOC_FILE"
fi

# ──────────────────────────────────────────────────────────────────────────────
# inject tables
# ──────────────────────────────────────────────────────────────────────────────
echo "ℹ️ injecting table a into $DOC_FILE..."
inject_table "$DOC_FILE" "$TABLE_A_START" "$TABLE_A_END" "$tableA_content"
echo "ℹ️ injecting table b into $DOC_FILE..."
inject_table "$DOC_FILE" "$TABLE_B_START" "$TABLE_B_END" "$tableB_content"

# ──────────────────────────────────────────────────────────────────────────────
# diagnostics
# ──────────────────────────────────────────────────────────────────────────────
echo "ℹ️ change summary:"
git status --porcelain || true
if git diff --quiet; then
  echo "no changes detected."
else
  echo "=== diffstat ==="
  git --no-pager diff --stat
  echo "=== first 200 lines of diff ==="
  git --no-pager diff | head -n 200
fi

echo "✅ updated $DOC_FILE with latest nodes"
