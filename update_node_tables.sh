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

# Temp files for API responses
tmp1=$(mktemp)
tmp2=$(mktemp)
# Ensure API response temp files are cleaned up on exit
trap 'rm -f "$tmp1" "$tmp2"' EXIT

# ─── fetch page 1 and page 2 ───
echo "ℹ️ Fetching node data..."
if ! resp1=$(curl -sS --fail --max-time 10 "$BASE_URL"); then
    echo "❌ Error fetching data from $BASE_URL" >&2
    exit 1
fi
if ! resp2=$(curl -sS --fail --max-time 10 "$PAGE2_URL"); then
    echo "❌ Error fetching data from $PAGE2_URL" >&2
    exit 1
fi
echo "ℹ️ Node data fetched."

jq ".nodes" <<<"$resp1" > "$tmp1"
jq ".nodes" <<<"$resp2" > "$tmp2"

# Corrected jq command for merging and processing nodes
all_nodes=$(jq -s '.[0] + .[1] | map(select(.node_id != null) | {node_id, description, node_account_id, service_endpoints, node_cert_hash, public_key})' "$tmp1" "$tmp2")

node_count=$(jq 'length' <<<"$all_nodes")
echo "ℹ️ Found $node_count total nodes after merging pages"
[ "$node_count" -eq 0 ] && { echo "⚠️ No nodes found; aborting"; exit 1; }

nodes_json="$all_nodes"

# ─── build Table A (node_id ≤ 15) ───
echo "ℹ️ Building Table A (Markdown)..."
tableA_header="| Node | Node ID | Node Account ID | Endpoints                                   | Node Certificate Thumbprint                                  |
|------|---------|-----------------|---------------------------------------------|--------------------------------------------------------------|
"

tableA_rows=$(jq -r '
  map(select(.node_id != null)) # Ensure node_id is not null
  | map({
      node:       (if .description then (.description | capture("Hosted by (?<node>[^|]+)") | .node // .description) else "N/A" end),
      id:         .node_id,
      acct:       .node_account_id,
      endpoints:  ([.service_endpoints[]? | select(.ip_address_v4 != null and .port != null) | "\(.ip_address_v4):\(.port)"] | join(",<br>")),
      thumb:      .node_cert_hash
    })
  | sort_by(.id)
  | .[]
  | "| \(.node // "N/A") | \(.id // "N/A") | **\(.acct // "N/A")** | \(.endpoints // "N/A") | \(.thumb // "N/A") |"
' <<<"$nodes_json")
tableA_content="${tableA_header}${tableA_rows}"
echo "ℹ️ Table A (Markdown) built."

# ─── build Table B (node_id > 15) ───
echo "ℹ️ Building Table B (Markdown)..."
tableB_header="| Node Account ID | Public Key                                                                                             |
|-----------------|------------------------------------------------------------------------------------------------------------------------|
"

tableB_rows=$(jq -r '
  map(select(.node_id != null and .public_key != null))
  | sort_by(.node_id)
  | map({
      acct: .node_account_id,
      key:  .public_key
    })
  | .[]
  | "| **\(.acct // "N/A")** | \(.key // "N/A") |"
' <<<"$nodes_json")
tableB_content="${tableB_header}${tableB_rows}"
echo "ℹ️ Table B (Markdown) built."

# ─── injection helper via awk ───
inject_table() {
  local file_to_update="$1" start_marker="$2" end_marker="$3" content_to_inject="$4"
  local temp_content_file # Declare local variable
  temp_content_file=$(mktemp)

  printf "%s\n" "$content_to_inject" > "$temp_content_file"

  cp "$file_to_update" "${file_to_update}.bak"
  echo "ℹ️ Created backup: ${file_to_update}.bak"
  
  awk -v start="$start_marker" -v end="$end_marker" -v tf="$temp_content_file" \
  '{ 
    if ($0 == start) { 
      print; 
      print ""; 
      while ((getline line < tf) > 0) { print line; } 
      print ""; 
      inblock=1; next 
    } 
    if ($0 == end) { 
      inblock=0; print; next 
    } 
    if (!inblock) { print } 
  }' "$file_to_update" > "${file_to_update}.tmp" && mv "${file_to_update}.tmp" "$file_to_update"
  
  rm -f "$temp_content_file"
}

if [ ! -f "$DOC_FILE" ]; then
  echo "ℹ️ $DOC_FILE not found. Creating a dummy file for testing."
  mkdir -p "$(dirname "$DOC_FILE")"
  echo -e "$TABLE_A_START\n$TABLE_A_END\n\n$TABLE_B_START\n$TABLE_B_END" > "$DOC_FILE"
fi

# ─── write and inject Table A ───
echo "ℹ️ Injecting Table A into $DOC_FILE..."
inject_table "$DOC_FILE" "$TABLE_A_START" "$TABLE_A_END" "$tableA_content"
echo "ℹ️ Table A injected."

# ─── write and inject Table B ───
echo "ℹ️ Injecting Table B into $DOC_FILE..."
inject_table "$DOC_FILE" "$TABLE_B_START" "$TABLE_B_END" "$tableB_content"
echo "ℹ️ Table B injected."

echo "✅ Updated $DOC_FILE with merged pages and two Markdown tables with fixed Node names and formatted Endpoints."
