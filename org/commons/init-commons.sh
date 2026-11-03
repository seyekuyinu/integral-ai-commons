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
mkdir -p "$TARGET/commons/proposals" "$TARGET/commons/conventions"
for f in MAP.md INDEX.md context.md engineering.md product.md map-conventions.sh \
         proposals/EXAMPLE.md conventions/README.md conventions/_TEMPLATE.md; do
  if [ -e "$TARGET/commons/$f" ]; then
    echo "skip: commons/$f already exists"
  else
    cp "$TEMPLATES/$f" "$TARGET/commons/$f"
    echo "created: commons/$f"
  fi
done

# 2. Inject the read-loop block into the agent instruction file, once.
#    Prefer AGENTS.md (portable across agents); fall back to an existing
#    CLAUDE.md so repos that predate the convention are not split in two.
if [ -f "$TARGET/AGENTS.md" ]; then
  AGENTFILE="$TARGET/AGENTS.md"
elif [ -f "$TARGET/CLAUDE.md" ]; then
  AGENTFILE="$TARGET/CLAUDE.md"
else
  AGENTFILE="$TARGET/AGENTS.md"
fi
AGENTNAME="$(basename "$AGENTFILE")"
if [ -f "$AGENTFILE" ] && grep -Fq "$MARKER" "$AGENTFILE"; then
  echo "skip: $AGENTNAME already has the Commons block"
else
  { [ -f "$AGENTFILE" ] && printf '\n'; cat "$TEMPLATES/CLAUDE-BLOCK.md"; } >> "$AGENTFILE"
  echo "injected: Commons block into $AGENTNAME"
fi

echo "Commons ready in $TARGET/commons"
