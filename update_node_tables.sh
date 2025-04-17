#!/usr/bin/env bash
set -euo pipefail

# ─── configuration ───
BASE_URL="https://mainnet.mirrornode.hedera.com/api/v1/network/nodes?file.id=0.0.102&limit=100&order=asc"
PAGE2_URL="${BASE_URL}&node.id=gt:27"
DOC_FILE="networks/mainnet/mainnet-nodes/README.md"

TABLE_A_START="<!-- TABLE A START -->"
TABLE_A_END="<!-- TABLE A END -->"
TABLE_B_START="<!-- TABLE B START -->"
TABLE_B_END="<!-- TABLE B END -->"

# ─── fetch page 1 and page 2 ───
resp1=$(curl -sS --fail --max-time 10 "$BASE_URL")
resp2=$(curl -sS --fail --max-time 10 "$PAGE2_URL")

# write each nodes array to a temp file
tmp1=$(mktemp)
tmp2=$(mktemp)
jq '.nodes' <<<"$resp1" > "$tmp1"
jq '.nodes' <<<"$resp2" > "$tmp2"

# merge into one array
all_nodes=$(jq -s '.[0] + .[1]' "$tmp1" "$tmp2")

# clean up
rm "$tmp1" "$tmp2"


node_count=$(jq 'length' <<<"$all_nodes")
echo "ℹ️  found $node_count total nodes after merging pages"
[ "$node_count" -eq 0 ] && { echo "⚠️  no nodes found; aborting"; exit 1; }

nodes_json="$all_nodes"

# ─── build Table A (node_id ≤ 15) ───
tableA_header="| Node | Node ID | Node Account ID | Endpoints | Node Certificate Thumbprint |
|------|---------|-----------------|-----------|-----------------------------|
"
tableA_rows=$(jq -r '
  map(select(.node_id >= 0))
  | map({
      node:      (.description | capture("Hosted by (?<node>[^|]+) \\|").node),
      id:        .node_id,
      acct:      .node_account_id,
      endpoints: [.service_endpoints[] | "\(.ip_address_v4):\(.port)"],
      thumb:     .node_cert_hash
    })
  | sort_by(.id)
  | .[]
  | "| \(.node) | \(.id) | **\(.acct)** | \(.endpoints | join(", ")) | \(.thumb) |"
' <<<"$nodes_json")
tableA_content="${tableA_header}${tableA_rows}"

# ─── build Table B (node_id > 15) ───
tableB_header="| Node Account ID | Public Key |
|-----------------|-----------------------------|
"
tableB_rows=$(jq -r '
  map(select(.node_id >= 0))
  | sort_by(.node_id)
  | map({
      acct: .node_account_id,
      key:  .public_key
    })
  | .[]
  | "| **\(.acct)** | \(.key) |"
' <<<"$nodes_json")
tableB_content="${tableB_header}${tableB_rows}"

# ─── injection helper via awk ───
inject_table() {
  local file="$1" start="$2" end="$3" table_file="$4"
  cp "$file" "${file}.bak"
  awk -v start="$start" -v end="$end" -v tf="$table_file" '
    $0 == start { print; while ((getline line < tf) > 0) print line; inblock=1; next }
    $0 == end   { inblock=0; print; next }
    !inblock    { print }
  ' "$file" > "${file}.tmp" && mv "${file}.tmp" "$file"
}

# ─── write and inject Table A ───
TABLE_A_FILE=$(mktemp)
printf '%s\n' "$tableA_content" > "$TABLE_A_FILE"
inject_table "$DOC_FILE" "$TABLE_A_START" "$TABLE_A_END" "$TABLE_A_FILE"
rm "$TABLE_A_FILE"

# ─── write and inject Table B ───
TABLE_B_FILE=$(mktemp)
printf '%s\n' "$tableB_content" > "$TABLE_B_FILE"
inject_table "$DOC_FILE" "$TABLE_B_START" "$TABLE_B_END" "$TABLE_B_FILE"
rm "$TABLE_B_FILE"

echo "✅  Updated $DOC_FILE with merged pages and two tables"
