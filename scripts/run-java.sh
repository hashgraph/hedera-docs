#!/usr/bin/env bash
set -euo pipefail

# Requires env: OPERATOR_ID, OPERATOR_KEY, HEDERA_NETWORK, MIRROR_NODE_URL
if [[ -z "${OPERATOR_ID:-}" || -z "${OPERATOR_KEY:-}" ]]; then
  echo "❌ OPERATOR_ID/OPERATOR_KEY not set"
  exit 2
fi

./gradlew -q run --stacktrace | tee java-output.txt
