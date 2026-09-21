#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
INIT="$SCRIPT_DIR/../init-commons.sh"
MARKER='^## The Commons (team shared decision layer)$'
TARGET="$(mktemp -d)"
ALT="$(mktemp -d)"
trap 'rm -rf "$TARGET" "$ALT"' EXIT

fail() { echo "FAIL: $1"; exit 1; }

# First run scaffolds everything
bash "$INIT" "$TARGET"
for f in INDEX.md context.md engineering.md product.md proposals/EXAMPLE.md; do
  test -f "$TARGET/commons/$f" || fail "missing commons/$f"
done

# Default target is AGENTS.md, not CLAUDE.md
test -f "$TARGET/AGENTS.md" || fail "AGENTS.md not created"
test -f "$TARGET/CLAUDE.md" && fail "CLAUDE.md created when AGENTS.md was the target"
grep -q "$MARKER" "$TARGET/AGENTS.md" || fail "Commons block not injected into AGENTS.md"

# Second run is idempotent for the block
bash "$INIT" "$TARGET"
count="$(grep -c "$MARKER" "$TARGET/AGENTS.md")"
[ "$count" -eq 1 ] || fail "block injected $count times into AGENTS.md (expected 1)"

# Existing AGENTS.md content is preserved
echo "PRE-EXISTING" > "$TARGET/AGENTS.md"
bash "$INIT" "$TARGET"
grep -q '^PRE-EXISTING$' "$TARGET/AGENTS.md" || fail "existing AGENTS.md content clobbered"
grep -q "$MARKER" "$TARGET/AGENTS.md" || fail "block not appended to existing AGENTS.md"

# Re-run does not clobber existing commons layer files
SENTINEL="SENTINEL-CLOBBER-TEST"
echo "$SENTINEL" > "$TARGET/commons/INDEX.md"
bash "$INIT" "$TARGET"
grep -q "$SENTINEL" "$TARGET/commons/INDEX.md" || fail "commons/INDEX.md was clobbered on re-run"

# A repo that predates the convention keeps one instruction file, not two
echo "LEGACY-PROJECT" > "$ALT/CLAUDE.md"
bash "$INIT" "$ALT"
test -f "$ALT/AGENTS.md" && fail "AGENTS.md created alongside an existing CLAUDE.md"
grep -q '^LEGACY-PROJECT$' "$ALT/CLAUDE.md" || fail "existing CLAUDE.md content clobbered"
grep -q "$MARKER" "$ALT/CLAUDE.md" || fail "block not appended to existing CLAUDE.md"

bash "$INIT" "$ALT"
count="$(grep -c "$MARKER" "$ALT/CLAUDE.md")"
[ "$count" -eq 1 ] || fail "block injected $count times into CLAUDE.md (expected 1)"

echo "PASS"
