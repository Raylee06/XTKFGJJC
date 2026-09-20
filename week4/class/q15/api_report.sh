#!/usr/bin/env bash
set -euo pipefail

OUT="summary.md"
URL="http://127.0.0.1:8000/packages.json"

DATA=$(curl -fsS "$URL" | jq -r '
  [.[] | select(.status == "active" and .downloads >= 100)]
  | sort_by([-.downloads, .name])
')

{
  echo "# Package Summary"
  echo ""
  echo "| name | version | downloads |"
  echo "|------|---------|-----------|"
  echo "$DATA" | jq -r '.[] | "| \(.name) | \(.version) | \(.downloads) |"'
} > "$OUT"

echo "Wrote $OUT"
