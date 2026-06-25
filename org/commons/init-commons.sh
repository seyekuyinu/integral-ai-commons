#!/usr/bin/env bash
# init-commons.sh — scaffold the Commons shared decision layer into a repo.
# Usage: bash init-commons.sh [TARGET_DIR]   (default: current directory)
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TEMPLATES="$SCRIPT_DIR/templates"
TARGET="${1:-.}"
MARKER="## The Commons (team shared decision layer)"

if [ ! -d "$TEMPLATES" ]; then
  echo "error: templates not found at $TEMPLATES" >&2
  exit 1
fi

# 1. Scaffold the commons/ folder (do not overwrite existing layer files)
mkdir -p "$TARGET/commons/proposals"
for f in INDEX.md context.md engineering.md product.md; do
  if [ -e "$TARGET/commons/$f" ]; then
    echo "skip: commons/$f already exists"
  else
    cp "$TEMPLATES/$f" "$TARGET/commons/$f"
    echo "created: commons/$f"
  fi
done
if [ -e "$TARGET/commons/proposals/EXAMPLE.md" ]; then
  echo "skip: commons/proposals/EXAMPLE.md already exists"
else
  cp "$TEMPLATES/proposals/EXAMPLE.md" "$TARGET/commons/proposals/EXAMPLE.md"
  echo "created: commons/proposals/EXAMPLE.md"
fi

# 2. Inject the read-loop block into CLAUDE.md, once
CLAUDE="$TARGET/CLAUDE.md"
if [ -f "$CLAUDE" ] && grep -Fq "$MARKER" "$CLAUDE"; then
  echo "skip: CLAUDE.md already has the Commons block"
else
  { [ -f "$CLAUDE" ] && printf '\n'; cat "$TEMPLATES/CLAUDE-BLOCK.md"; } >> "$CLAUDE"
  echo "injected: Commons block into CLAUDE.md"
fi

echo "Commons ready in $TARGET/commons"
