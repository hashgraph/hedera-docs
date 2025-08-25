#!/usr/bin/env bash
set -euo pipefail

# Requires env: OPERATOR_ID, OPERATOR_KEY, HEDERA_NETWORK, MIRROR_NODE_URL
if [[ -z "${OPERATOR_ID:-}" || -z "${OPERATOR_KEY:-}" ]]; then
  echo "❌ OPERATOR_ID/OPERATOR_KEY not set"
  exit 2
fi

OUTFILE="java-output.txt"
: > "$OUTFILE"  # truncate/create

echo "=== Java Examples Runner ==="           | tee -a "$OUTFILE"
echo "Timestamp (UTC): $(date -u +'%Y-%m-%d %H:%M:%SZ')" | tee -a "$OUTFILE"
echo "Network: ${HEDERA_NETWORK:-<unset>}"   | tee -a "$OUTFILE"
echo "Mirror:  ${MIRROR_NODE_URL:-<unset>}"  | tee -a "$OUTFILE"
echo ""                                       | tee -a "$OUTFILE"

# If you pass an example FQN as an argument, run just that one:
#   ./.github/scripts/run-java.sh examples.CreateAccountDemo
if [[ $# -gt 0 ]]; then
  FQN="$1"
  echo "▶️  Running single example: $FQN" | tee -a "$OUTFILE"
  set +e
  ./gradlew -q runExample -PexampleClass="$FQN" --stacktrace --console=plain | tee -a "$OUTFILE"
  STATUS=${PIPESTATUS[0]}
  set -e
  exit $STATUS
fi

# Otherwise run ALL discovered examples
echo "▶️  Running all examples…" | tee -a "$OUTFILE"
set +e
./gradlew -q runAllExamples --stacktrace --console=plain | tee -a "$OUTFILE"
STATUS=${PIPESTATUS[0]}
set -e

if [[ $STATUS -ne 0 ]]; then
  echo "" | tee -a "$OUTFILE"
  echo "❌ One or more examples failed." | tee -a "$OUTFILE"
else
  echo "" | tee -a "$OUTFILE"
  echo "✅ All examples passed." | tee -a "$OUTFILE"
fi

exit $STATUS
