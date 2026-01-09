#!/usr/bin/env bash
set -euo pipefail

# ──────────────────────────────────────────────────────────────────────────────
# Hedera Node Tables Update Script
# 
# This script fetches the latest node data from the Hedera Mirror Node API
# and updates the mainnet-nodes.mdx documentation file with:
# - Service endpoints
# - Public keys
# - Certificate hashes
#
# Data source: https://mainnet.mirrornode.hedera.com/api/v1/network/nodes
# (Same data displayed on https://hashscan.io/mainnet/nodes/table)
# ──────────────────────────────────────────────────────────────────────────────

# ──────────────────────────────────────────────────────────────────────────────
# Configuration
# ──────────────────────────────────────────────────────────────────────────────
BASE_URL="https://mainnet.mirrornode.hedera.com/api/v1/network/nodes?limit=100&order=asc"
DOC_FILE="hedera/networks/mainnet/mainnet-nodes.mdx"

# ──────────────────────────────────────────────────────────────────────────────
# Temp files and cleanup
# ──────────────────────────────────────────────────────────────────────────────
acc_file="$(mktemp)"
page_file="$(mktemp)"
tableA_file="$(mktemp)"
tableB_file="$(mktemp)"
trap 'rm -f "$acc_file" "$page_file" "$tableA_file" "$tableB_file" 2>/dev/null || true' EXIT

# Initialize accumulator
printf '%s\n' '{"nodes":[]}' > "$acc_file"

# ──────────────────────────────────────────────────────────────────────────────
# Fetch all pages from Mirror Node API
# ──────────────────────────────────────────────────────────────────────────────
echo "ℹ️  Fetching all nodes via pagination from Mirror Node API..."
url="$BASE_URL"
while [ -n "${url:-}" ]; do
  echo "→ GET $url"
  if ! curl -sS --fail --max-time 30 "$url" -o "$page_file"; then
    echo "❌ Fetch failed: $url"
    exit 1
  fi

  # Append nodes from this page to the accumulator
  jq -s '{
    nodes: (.[0].nodes + (.[1].nodes // []))
  }' "$acc_file" "$page_file" > "${acc_file}.new"
  mv "${acc_file}.new" "$acc_file"

  # Follow pagination
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

# ──────────────────────────────────────────────────────────────────────────────
# Process and normalize node data
# ──────────────────────────────────────────────────────────────────────────────
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
echo "ℹ️  Found $node_count nodes"
[ "$node_count" -eq 0 ] && { echo "⚠️  No nodes found; aborting"; exit 1; }

# ──────────────────────────────────────────────────────────────────────────────
# Build Table A: Node Address Book (HTML format for MDX - ALL ON ONE LINE)
# Columns: Node | Node ID | Node Account ID | Endpoints | Node Certificate Thumbprint
#
# IMPORTANT: Mintlify/MDX requires the entire table to be on a SINGLE LINE
# with NO newlines between <tr> elements. Newlines break the rendering.
# ──────────────────────────────────────────────────────────────────────────────
echo "ℹ️  Building Table A (Node Address Book)..."

{
  # Start table - everything must be on one line
  printf '<table><thead><tr><th>Node</th><th>Node ID</th><th>Node Account ID</th><th>Endpoints</th><th>Node Certificate Thumbprint</th></tr></thead><tbody>'
  
  # Generate all rows WITHOUT newlines between them
  jq -rj '
    .[] | 
    # Extract node name from description
    (
      if (.description // "") == "" then "N/A"
      else (
        (.description | split(" | ")[0] | 
          if startswith("Hosted by ") then .[10:]
          elif startswith("Hosted for ") then .[11:]
          else .
          end
        ) // .description
      ) end
    ) as $node_name |
    
    # Format endpoints with <br/> separators
    (
      [.service_endpoints[]? |
        if (.ip_address_v4 // "") != "" and (.port // null) != null
          then "\(.ip_address_v4):\(.port)"
        elif (.ip_address_v6 // "") != "" and (.port // null) != null
          then "[\(.ip_address_v6)]:\(.port)"
        else empty
        end
      ] | join(",<br/>")
    ) as $endpoints |
    
    "<tr><td>\($node_name)</td><td>\(.node_id)</td><td><strong>\(.node_account_id // "N/A")</strong></td><td>\($endpoints // "N/A")</td><td>\(.node_cert_hash // "N/A")</td></tr>"
  ' <<<"$nodes_json"
  
  printf '</tbody></table>'
} > "$tableA_file"

echo "ℹ️  Table A built."

# ──────────────────────────────────────────────────────────────────────────────
# Build Table B: Node Public Keys (HTML format for MDX - ALL ON ONE LINE)
# Columns: Node Account ID | Public Key
# ──────────────────────────────────────────────────────────────────────────────
echo "ℹ️  Building Table B (Node Public Keys)..."

{
  printf '<table><thead><tr><th>Node Account ID</th><th>Public Key</th></tr></thead><tbody>'
  
  # Generate all rows WITHOUT newlines between them
  jq -rj '
    map(select(.public_key != null and .public_key != "")) |
    sort_by(.node_id) |
    .[] |
    "<tr><td><strong>\(.node_account_id // "N/A")</strong></td><td>\(.public_key)</td></tr>"
  ' <<<"$nodes_json"
  
  printf '</tbody></table>'
} > "$tableB_file"

echo "ℹ️  Table B built."

# ──────────────────────────────────────────────────────────────────────────────
# Verify doc file exists
# ──────────────────────────────────────────────────────────────────────────────
if [ ! -f "$DOC_FILE" ]; then
  echo "❌ Error: $DOC_FILE not found."
  echo "   Please ensure you're running this script from the repository root."
  exit 1
fi

# ──────────────────────────────────────────────────────────────────────────────
# Update the MDX file using Python
# Strategy: Read table content from files to avoid shell escaping issues
# ──────────────────────────────────────────────────────────────────────────────
echo "ℹ️  Updating $DOC_FILE..."

python3 - "$DOC_FILE" "$tableA_file" "$tableB_file" << 'PYTHON_SCRIPT'
import re
import sys

doc_file = sys.argv[1]
tableA_file = sys.argv[2]
tableB_file = sys.argv[3]

# Read the table content from files
with open(tableA_file, "r") as f:
    tableA = f.read()

with open(tableB_file, "r") as f:
    tableB = f.read()

# Read the original file
with open(doc_file, "r") as f:
    content = f.read()

# Pattern to match the first table (Node Address Book)
# This table has headers: Node | Node ID | Node Account ID | Endpoints | Node Certificate Thumbprint
pattern_tableA = r'<table><thead><tr><th>Node</th><th>Node ID</th><th>Node Account ID</th><th>Endpoints</th><th>Node Certificate Thumbprint</th></tr></thead><tbody>.*?</tbody></table>'

# Pattern to match the second table (Public Keys)
# This table has headers: Node Account ID | Public Key
pattern_tableB = r'<table><thead><tr><th>Node Account ID</th><th>Public Key</th></tr></thead><tbody>.*?</tbody></table>'

# Replace the tables
new_content = re.sub(pattern_tableA, tableA, content, count=1, flags=re.DOTALL)
new_content = re.sub(pattern_tableB, tableB, new_content, count=1, flags=re.DOTALL)

# Write the updated file
with open(doc_file, "w") as f:
    f.write(new_content)

print("✅ Tables replaced successfully")
PYTHON_SCRIPT

# ──────────────────────────────────────────────────────────────────────────────
# Summary
# ──────────────────────────────────────────────────────────────────────────────
echo ""
echo "✅ Updated $DOC_FILE with latest node data from Mirror Node API"
echo "   - $node_count nodes processed"
echo "   - Service endpoints updated"
echo "   - Public keys updated"
echo "   - Certificate hashes updated"
