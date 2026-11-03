#!/usr/bin/env bash
# map-conventions.sh — list each team convention in commons/MAP.md.
# Reads the frontmatter of commons/conventions/*.md and rewrites the block
# between the conventions markers in MAP.md, so the map never drifts.
#
# Usage: bash commons/map-conventions.sh [REPO_ROOT] [--check]
#   --check  change nothing; exit 1 if MAP.md is out of date (for CI)
set -euo pipefail

ROOT="."
CHECK=0
for arg in "$@"; do
  case "$arg" in
    --check) CHECK=1 ;;
    *) ROOT="$arg" ;;
  esac
done

MAP="$ROOT/commons/MAP.md"
DIR="$ROOT/commons/conventions"
START="<!-- conventions:start -->"
END="<!-- conventions:end -->"

[ -f "$MAP" ] || { echo "error: $MAP not found" >&2; exit 2; }
grep -Fq "$START" "$MAP" && grep -Fq "$END" "$MAP" \
  || { echo "error: conventions markers missing from $MAP" >&2; exit 2; }

# Print one frontmatter field's value, without surrounding quotes.
field() {
  awk -v key="$2" '
    NR == 1 && $0 != "---" { exit }
    NR > 1 && $0 == "---"  { exit }
    NR > 1 && index($0, key ":") == 1 {
      v = substr($0, length(key) + 2)
      sub(/^[ \t]+/, "", v); sub(/[ \t]+$/, "", v)
      if (v ~ /^".*"$/ || v ~ /^\047.*\047$/) v = substr(v, 2, length(v) - 2)
      print v; exit
    }' "$1"
}

LINES="$(mktemp)"
NEW="$(mktemp)"
trap 'rm -f "$LINES" "$NEW"' EXIT

if [ -d "$DIR" ]; then
  for f in "$DIR"/*.md; do
    [ -e "$f" ] || continue
    base="$(basename "$f")"
    case "$base" in _*|README.md) continue ;; esac
    name="$(field "$f" name)"
    answers="$(field "$f" answers)"
    when="$(field "$f" use_when)"
    if [ -z "$name" ] || [ -z "$answers" ]; then
      echo "error: $base needs 'name' and 'answers' in its frontmatter" >&2
      exit 2
    fi
    line="- **$name**: $answers"
    [ -n "$when" ] && line="$line Use when: $when."
    echo "$line → \`commons/conventions/$base\`" >> "$LINES"
  done
fi

awk -v start="$START" -v end="$END" -v lines="$LINES" '
  $0 == start { print; while ((getline l < lines) > 0) print l; skip = 1; next }
  $0 == end   { skip = 0 }
  !skip       { print }
' "$MAP" > "$NEW"

if cmp -s "$MAP" "$NEW"; then
  echo "MAP.md is up to date"
elif [ "$CHECK" -eq 1 ]; then
  echo "MAP.md is out of date: run bash commons/map-conventions.sh" >&2
  exit 1
else
  cp "$NEW" "$MAP"
  echo "updated: commons/MAP.md"
fi
