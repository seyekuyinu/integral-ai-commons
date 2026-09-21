#!/usr/bin/env bash
# Reproduce the agency handback test. Builds three arms, runs N trials each,
# writes raw transcripts. Does not score them — that part is yours.
set -euo pipefail

REPO="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
TASK="${1:-$REPO/docs/evidence/2026-09-21-vendor-decision/task.md}"
TRIALS="${TRIALS:-3}"
MODEL="${MODEL:-sonnet}"
OUT="${OUT:-$(mktemp -d)/evidence}"

command -v claude >/dev/null || { echo "claude CLI not found on PATH" >&2; exit 1; }
[ -f "$TASK" ] || { echo "task file not found: $TASK" >&2; exit 1; }

mkdir -p "$OUT" "$OUT/control" "$OUT/treatment" "$OUT/arm3/.claude/skills/agency-check"
cp "$REPO/AGENTS.md" "$OUT/treatment/AGENTS.md"
cp "$REPO/AGENTS.md" "$OUT/arm3/AGENTS.md"
cp "$REPO/plugin/skills/agency-check/SKILL.md" "$OUT/arm3/.claude/skills/agency-check/SKILL.md"

prompt="$(cat "$TASK")"
echo "task:    $TASK"
echo "model:   $MODEL"
echo "trials:  $TRIALS per arm"
echo "output:  $OUT"
echo

for arm in control treatment arm3; do
  for i in $(seq 1 "$TRIALS"); do
    ( cd "$OUT/$arm" && claude -p "$prompt" --model "$MODEL" > "$OUT/$arm-$i.md" 2>/dev/null ) &
  done
done
wait

echo "Transcripts written:"
ls -1 "$OUT"/*.md
echo
echo "Read all $((TRIALS * 3)) outputs and judge for yourself:"
echo "  - Did the agent decide, or hand the decision back?"
echo "  - Did it name what it could not know?"
echo "  - Can you tell the arms apart without looking at the filenames?"
