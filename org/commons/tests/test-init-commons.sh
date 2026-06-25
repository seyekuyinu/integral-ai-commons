#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
INIT="$SCRIPT_DIR/../init-commons.sh"
TARGET="$(mktemp -d)"
trap 'rm -rf "$TARGET"' EXIT

fail() { echo "FAIL: $1"; exit 1; }

# First run scaffolds everything
bash "$INIT" "$TARGET"
for f in INDEX.md context.md engineering.md product.md proposals/EXAMPLE.md; do
  test -f "$TARGET/commons/$f" || fail "missing commons/$f"
done
test -f "$TARGET/CLAUDE.md" || fail "CLAUDE.md not created"
grep -q '^## The Commons (team shared decision layer)$' "$TARGET/CLAUDE.md" \
  || fail "CLAUDE block not injected"

# Second run is idempotent for the block
bash "$INIT" "$TARGET"
count="$(grep -c '^## The Commons (team shared decision layer)$' "$TARGET/CLAUDE.md")"
[ "$count" -eq 1 ] || fail "CLAUDE block injected $count times (expected 1)"

# Existing CLAUDE.md content is preserved
echo "PRE-EXISTING" > "$TARGET/CLAUDE.md"
bash "$INIT" "$TARGET"
grep -q '^PRE-EXISTING$' "$TARGET/CLAUDE.md" || fail "existing CLAUDE.md content clobbered"
grep -q '^## The Commons (team shared decision layer)$' "$TARGET/CLAUDE.md" \
  || fail "block not appended to existing CLAUDE.md"

echo "PASS"
