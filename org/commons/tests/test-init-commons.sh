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
for f in MAP.md INDEX.md context.md engineering.md product.md map-conventions.sh \
         proposals/EXAMPLE.md conventions/README.md conventions/_TEMPLATE.md; do
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

# --- map-conventions.sh keeps MAP.md in step with commons/conventions/ ---
MAPPER="$ALT/commons/map-conventions.sh"

# A fresh scaffold is already up to date, and the template is never listed
bash "$MAPPER" "$ALT" --check >/dev/null || fail "fresh MAP.md reported out of date"
grep -q '_TEMPLATE' "$ALT/commons/MAP.md" && fail "_TEMPLATE.md listed in MAP.md"

# Teams name conventions their own way; quoted values are unwrapped
cat > "$ALT/commons/conventions/working-agreement.md" <<'EOF'
---
name: "Working agreement"
answers: How do we hand work off between people?
use_when: Before passing work to someone else
---
Body text.
EOF
bash "$MAPPER" "$ALT" --check >/dev/null 2>&1 && fail "--check passed with an unlisted convention"
bash "$MAPPER" "$ALT" >/dev/null
grep -Fq '**Working agreement**: How do we hand work off between people? Use when: Before passing work to someone else.' \
  "$ALT/commons/MAP.md" || fail "convention not listed in MAP.md"
grep -Fq 'commons/conventions/working-agreement.md' "$ALT/commons/MAP.md" || fail "convention path missing"
bash "$MAPPER" "$ALT" --check >/dev/null || fail "--check failed right after regenerating"

# Regenerating twice gives the same file, and content outside the markers survives
cp "$ALT/commons/MAP.md" "$ALT/map-before"
bash "$MAPPER" "$ALT" >/dev/null
cmp -s "$ALT/map-before" "$ALT/commons/MAP.md" || fail "regeneration is not stable"
grep -Fq '## Beyond this repo' "$ALT/commons/MAP.md" || fail "content outside markers lost"

# Removing a convention removes its line
rm "$ALT/commons/conventions/working-agreement.md"
bash "$MAPPER" "$ALT" >/dev/null
grep -q 'working-agreement' "$ALT/commons/MAP.md" && fail "deleted convention still listed"

# A convention without 'answers' is rejected, and MAP.md is left alone
printf -- '---\nname: No answers\n---\n' > "$ALT/commons/conventions/broken.md"
cp "$ALT/commons/MAP.md" "$ALT/map-before"
set +e; bash "$MAPPER" "$ALT" >/dev/null 2>&1; code=$?; set -e
[ "$code" -eq 2 ] || fail "missing 'answers' exited $code (expected 2)"
cmp -s "$ALT/map-before" "$ALT/commons/MAP.md" || fail "MAP.md changed despite a broken convention"

echo "PASS"
