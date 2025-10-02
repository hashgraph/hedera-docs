#!/usr/bin/env bash
set -euo pipefail

# Requires env: OPERATOR_ID, OPERATOR_KEY (others optional for logging)
if [[ -z "${OPERATOR_ID:-}" || -z "${OPERATOR_KEY:-}" ]]; then
  echo "❌ OPERATOR_ID/OPERATOR_KEY not set"
  exit 2
fi

EXAMPLES_DIR=".github/examples/javascript"
OUTFILE="js-output.txt"
: > "$OUTFILE"

echo "=== JavaScript Examples Runner ==="           | tee -a "$OUTFILE"
echo "Timestamp (UTC): $(date -u +'%Y-%m-%d %H:%M:%SZ')" | tee -a "$OUTFILE"
echo "Network: ${HEDERA_NETWORK:-<unset>}"         | tee -a "$OUTFILE"
echo "Mirror:  ${MIRROR_NODE_URL:-<unset>}"        | tee -a "$OUTFILE"
echo ""                                            | tee -a "$OUTFILE"

if [ ! -d "$EXAMPLES_DIR" ]; then
  echo "❌ Examples directory not found: $EXAMPLES_DIR" | tee -a "$OUTFILE"
  exit 1
fi

cd "$EXAMPLES_DIR"

shopt -s nullglob
mapfile -t files < <(find . -maxdepth 1 -type f -name "*.js" -printf "%P\n" | sort)

if [ "${#files[@]}" -eq 0 ]; then
  echo "⚠️  No .js files found in $EXAMPLES_DIR" | tee -a "../$OUTFILE"
  exit 0
fi

overall=0
for f in "${files[@]}"; do
  echo "▶️  Running: $f" | tee -a "../$OUTFILE"
  set +e
  OPERATOR_ID="$OPERATOR_ID" \
  OPERATOR_KEY="$OPERATOR_KEY" \
  HEDERA_NETWORK="${HEDERA_NETWORK:-}" \
  MIRROR_NODE_URL="${MIRROR_NODE_URL:-}" \
  node "$f" 2>&1 | tee -a "../$OUTFILE"
  status=${PIPESTATUS[0]}
  set -e

  if [ $status -ne 0 ]; then
    echo "❌ Failed: $f (exit $status)" | tee -a "../$OUTFILE"
    overall=1
  else
    echo "✅ Passed: $f" | tee -a "../$OUTFILE"
  fi
  echo "" | tee -a "../$OUTFILE"
done

cd - >/dev/null

if [ $overall -ne 0 ]; then
  echo "❌ One or more JS examples failed." | tee -a "$OUTFILE"
  exit 1
else
  echo "✅ All JS examples passed." | tee -a "$OUTFILE"
  exit 0
fi
