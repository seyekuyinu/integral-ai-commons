# The Commons — Shared Decision Layer Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Add an opt-in `commons/` shared decision layer to integral-ai-commons so teams sharing one repo converge on settled facts/decisions and stop re-deriving context (cutting token use).

**Architecture:** A self-contained scaffold under `org/commons/`: markdown templates (`templates/`), a `init-commons.sh` script that copies the templates into a target repo and injects a read-loop block into that repo's `CLAUDE.md`, a human-facing runbook (`org/ORG-COMMONS.md`), and entry-point notes in `README.md` and `org/ORG-ONBOARDING.md`. Doc-driven, no runtime, no service — consistent with how the project already distributes its principles.

**Tech Stack:** Markdown, POSIX/bash shell. No build system, no package manager, no test framework — shell assertions only.

## Global Constraints

- The Commons is **opt-in and additive** — the base philosophy layer (`CLAUDE.md`, `PRINCIPLES.md`, `INTEGRAL.md`) must remain unchanged and fully usable by solo users. Do not edit those three files.
- Entry point must be gated behind the framing: **"Working with a product team, or a team sharing the same organizational goal? Add the Commons."**
- Write authority is **human-ratified only**. Nothing the agent proposes lands in a layer file without human approval.
- The scaffold lives under `org/commons/`; templates are the single source of truth for scaffolded content (no duplicated copies elsewhere).
- All files are plain markdown or POSIX-compatible bash. No new dependencies.
- Stable IDs: `ENG-NNN` for engineering, `PRD-NNN` for product, slug anchors for context.
- Branch: `feature/commons-shared-decision-layer` (already checked out). Commit after each task.

---

### Task 1: Commons templates

The inert content the scaffolder will copy/inject. Six files under `org/commons/templates/`. No behavior — verification is content presence.

**Files:**
- Create: `org/commons/templates/INDEX.md`
- Create: `org/commons/templates/context.md`
- Create: `org/commons/templates/engineering.md`
- Create: `org/commons/templates/product.md`
- Create: `org/commons/templates/proposals/EXAMPLE.md`
- Create: `org/commons/templates/CLAUDE-BLOCK.md`

**Interfaces:**
- Produces: the template tree consumed by `init-commons.sh` (Task 2). The script reads every file under `templates/` and appends `CLAUDE-BLOCK.md` verbatim to the target `CLAUDE.md`. The exact marker line `## The Commons (team shared decision layer)` in `CLAUDE-BLOCK.md` is used by the script for idempotency and by the test as an assertion — keep that line exact.

- [ ] **Step 1: Create `org/commons/templates/INDEX.md`**

```markdown
# Commons Index

> Always-loaded. One line per ratified entry. Agents read this at session start
> and treat every entry as settled. Full detail lives in the layer files.
> Keep each section append-ordered (newest at the bottom) to minimise merge conflicts.

## Context
<!-- slug — one-sentence fact · context.md#slug -->

## Engineering
<!-- [ENG-001] one-sentence decision · engineering.md#eng-001 -->

## Product
<!-- [PRD-001] one-sentence decision · product.md#prd-001 -->

## Pending proposals (0)
<!-- proposals/YYYY-MM-DD-slug.md -->
```

- [ ] **Step 2: Create `org/commons/templates/context.md`**

```markdown
# Context — shared working memory

> Facts every agent currently re-discovers: stack, key files, gotchas,
> glossary, current priorities. Add an entry under a slug heading, then index it
> in INDEX.md under Context. This layer is the highest-value token saver.

<!-- ### stack
Next.js + Supabase, Bun runtime. Prod gated behind PR. -->
```

- [ ] **Step 3: Create `org/commons/templates/engineering.md`**

```markdown
# Engineering decisions

> Resolved technical decisions, ADR-style. One entry per decision, ID ENG-NNN,
> newest at the bottom. Index each in INDEX.md under Engineering.

<!-- ## ENG-001 — Postgres over SQLite
**Decision:** Use Postgres.
**Why:** Durable multi-writer access; SQLite locking fails under concurrent agents.
**Ratified:** YYYY-MM-DD -->
```

- [ ] **Step 4: Create `org/commons/templates/product.md`**

```markdown
# Product decisions

> Resolved product / strategy / scope decisions. One entry per decision,
> ID PRD-NNN, newest at the bottom. Index each in INDEX.md under Product.

<!-- ## PRD-001 — No public API in v1
**Decision:** Ship without a public API.
**Why:** Scope discipline; revisit once the core flow is proven.
**Ratified:** YYYY-MM-DD -->
```

- [ ] **Step 5: Create `org/commons/templates/proposals/EXAMPLE.md`**

```markdown
---
title: Postgres over SQLite
layer: engineering        # context | engineering | product
status: pending           # pending | rejected
proposed_by: <name or agent>
date: YYYY-MM-DD
---

**Context:** What prompted this — the situation or question that forced a call.

**Decision:** The single thing being proposed as settled.

**Rationale:** Why this over the alternatives. Name the alternatives you rejected.

<!-- A human ratifies this by saying "ratify proposal <slug>". On ratification the
entry moves into its layer file with a stable ID, its one-liner goes into
INDEX.md, and this file is deleted. To reject, set status: rejected or delete. -->
```

- [ ] **Step 6: Create `org/commons/templates/CLAUDE-BLOCK.md`**

```markdown
## The Commons (team shared decision layer)

If this project has a `commons/` folder, it is the team's source of truth for
settled facts and decisions.

At session start, read `commons/INDEX.md`. Treat ratified entries as settled —
do not re-derive, re-explore, or re-litigate them. Open a layer file
(`commons/context.md`, `commons/engineering.md`, `commons/product.md`) only when
your task touches one of its entries.

If you reach a decision, or discover a project fact, that is not yet in the
commons, do not record it silently. Draft a proposal at
`commons/proposals/YYYY-MM-DD-slug.md` (see `commons/proposals/EXAMPLE.md` for
the shape) and tell the human. Only a human ratifies a proposal into a layer file.

When the human says "ratify proposal X", append the entry to the correct layer
file with the next stable ID (ENG-NNN for engineering, PRD-NNN for product;
slug anchors for context), add its one-line summary to `commons/INDEX.md`, then
remove the proposal file. Show the human the diff for approval.
```

- [ ] **Step 7: Verify all six template files exist with expected headers**

Run:
```bash
for f in INDEX context engineering product; do test -f "org/commons/templates/$f.md" || echo "MISSING $f"; done
test -f org/commons/templates/proposals/EXAMPLE.md || echo "MISSING EXAMPLE"
grep -q '^## The Commons (team shared decision layer)$' org/commons/templates/CLAUDE-BLOCK.md && echo "BLOCK MARKER OK"
```
Expected: no `MISSING` lines, and `BLOCK MARKER OK`.

- [ ] **Step 8: Commit**

```bash
git add org/commons/templates
git commit -m "feat(commons): add scaffold templates (index, three layers, proposal, CLAUDE block)"
```

---

### Task 2: init-commons scaffolder + test

The one behavioral unit — gets a real test (TDD). Copies templates into a target repo and idempotently injects the CLAUDE block.

**Files:**
- Create: `org/commons/init-commons.sh`
- Test: `org/commons/tests/test-init-commons.sh`

**Interfaces:**
- Consumes: the `org/commons/templates/` tree from Task 1, resolved relative to the script's own location.
- Produces: `init-commons.sh` — usage `bash init-commons.sh [TARGET_DIR]` (default `.`). Creates `<TARGET_DIR>/commons/` containing `INDEX.md`, `context.md`, `engineering.md`, `product.md`, `proposals/EXAMPLE.md`, and appends `CLAUDE-BLOCK.md` to `<TARGET_DIR>/CLAUDE.md` (creating it if absent) exactly once. Re-running is a no-op for the block.

- [ ] **Step 1: Write the failing test `org/commons/tests/test-init-commons.sh`**

```bash
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
```

- [ ] **Step 2: Run the test to verify it fails**

Run:
```bash
bash org/commons/tests/test-init-commons.sh
```
Expected: FAIL — the script does not exist yet (`bash: .../init-commons.sh: No such file or directory`).

- [ ] **Step 3: Write `org/commons/init-commons.sh`**

```bash
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
if [ -f "$CLAUDE" ] && grep -q "^${MARKER}\$" "$CLAUDE"; then
  echo "skip: CLAUDE.md already has the Commons block"
else
  { [ -f "$CLAUDE" ] && printf '\n'; cat "$TEMPLATES/CLAUDE-BLOCK.md"; } >> "$CLAUDE"
  echo "injected: Commons block into CLAUDE.md"
fi

echo "Commons ready in $TARGET/commons"
```

- [ ] **Step 4: Make the script executable and run the test to verify it passes**

Run:
```bash
chmod +x org/commons/init-commons.sh org/commons/tests/test-init-commons.sh
bash org/commons/tests/test-init-commons.sh
```
Expected: `PASS`

- [ ] **Step 5: Commit**

```bash
git add org/commons/init-commons.sh org/commons/tests/test-init-commons.sh
git commit -m "feat(commons): add idempotent init-commons scaffolder with test"
```

---

### Task 3: ORG-COMMONS.md runbook

The human-facing guide: what the Commons is, when to add it, how the propose→ratify loop works. Peer to `ORG-SETUP.md` / `ORG-ONBOARDING.md`.

**Files:**
- Create: `org/ORG-COMMONS.md`

**Interfaces:**
- Consumes: references `org/commons/init-commons.sh` (Task 2) and the template structure (Task 1) by path.
- Produces: the canonical human doc that `README.md` and `ORG-ONBOARDING.md` (Task 4) link to.

- [ ] **Step 1: Create `org/ORG-COMMONS.md`**

```markdown
# The Commons — shared decision layer

**Working with a product team, or a team sharing the same organizational goal? Add the Commons.**

The rest of this project is for *you and your agent* — the principles you hold
AI to. The Commons is the one piece built for *a team*. It is optional. A solo
user never needs it.

---

## The problem it solves

When several teammates each have their own AI access on the **same** repo, two
things go wrong at once:

1. **Token maxing.** Every session re-reads the same project context and
   re-derives the same conclusions. Redundant work, multiplied by headcount.
2. **Divergent truth.** Each person's agent makes its own local calls. Nothing
   accumulates into a shared, authoritative record, so agents quietly disagree.

Both have the same fix: one canonical place where *settled* facts and decisions
live, that every agent reads and treats as closed. Agents stop re-deriving
(tokens drop) and stop diverging (truth converges).

---

## What it is

A `commons/` folder committed to your shared repo:

- `INDEX.md` — always-loaded. One line per settled entry. This is what every
  agent reads at session start.
- `context.md` — shared working memory: stack, key files, gotchas, glossary,
  priorities. The highest-value token saver.
- `engineering.md` — resolved technical decisions (ADR-style, IDs `ENG-NNN`).
- `product.md` — resolved product / strategy / scope decisions (IDs `PRD-NNN`).
- `proposals/` — the inbox for entries awaiting human ratification.

It is plain markdown, versioned by git. No database, no service.

---

## Add it to a repo

From this project, run the scaffolder against your target repo:

```bash
bash org/commons/init-commons.sh /path/to/your/repo
```

This creates the `commons/` folder and appends a short read-loop block to your
repo's `CLAUDE.md` (creating it if needed). Re-running is safe — it never
duplicates the block or overwrites existing entries. Commit the result so
teammates get it on their next pull.

---

## How it works day to day

**Reading.** Because the block is in `CLAUDE.md`, every agent reads
`commons/INDEX.md` at session start and treats its entries as settled — it won't
re-explore the stack or re-argue a closed decision. It opens a layer file only
when a task touches one of its entries.

**Proposing.** When an agent reaches a decision, or learns a project fact, that
isn't in the commons, it does not write it silently. It drafts a file in
`commons/proposals/` (see `commons/proposals/EXAMPLE.md`) and tells you.

**Ratifying — the human gate.** Nothing enters a layer file without you. When
you approve, tell your agent *"ratify proposal &lt;slug&gt;"*. It will:

1. append the entry to the right layer file with the next stable ID,
2. add the one-line summary to `INDEX.md`,
3. delete the proposal file,

and show you the diff to approve. To reject, set `status: rejected` or delete
the proposal. This is principle #4 — *the human defines what's good* — made
mechanical.

---

## Keeping it healthy

- **Ratified means merged.** Pull before you trust the commons; an entry is
  authoritative once it's on your main branch.
- **Append, don't rewrite.** Keep each `INDEX.md` section append-ordered to
  minimise merge conflicts. `INDEX.md` is the one hot file.
- **Prune.** When a decision is reversed, update or remove its entry — a stale
  commons is worse than none.

---

## Where it sits in the framework

The individual `CLAUDE.md` covers one human's interior and behaviour. The
Commons operationalizes the *collective* dimensions the philosophy names but a
solo file can't enact: shared systems and structure (`context.md`,
`engineering.md`), shared meaning (`product.md`), and human agency (the
ratification gate). See `INTEGRAL.md` for the full quadrant mapping.
```

- [ ] **Step 2: Verify the runbook leads with the gating question and references the script**

Run:
```bash
grep -q 'Working with a product team' org/ORG-COMMONS.md && echo "FRAMING OK"
grep -q 'org/commons/init-commons.sh' org/ORG-COMMONS.md && echo "SCRIPT REF OK"
```
Expected: `FRAMING OK` and `SCRIPT REF OK`.

- [ ] **Step 3: Commit**

```bash
git add org/ORG-COMMONS.md
git commit -m "docs(commons): add ORG-COMMONS runbook (problem, scaffold, propose-ratify loop)"
```

---

### Task 4: Entry points in README and onboarding

Make the Commons discoverable from the two places a team would look — gated behind the framing question. Additive edits only.

**Files:**
- Modify: `README.md` (add repo-tree line + a team section)
- Modify: `org/ORG-ONBOARDING.md` (add an optional post-session subsection)

**Interfaces:**
- Consumes: `org/ORG-COMMONS.md` (Task 3) as the link target.

- [ ] **Step 1: Add the Commons to the README repo tree**

In `README.md`, find the line:
```
├── install.md       ← How to install for Claude Code, Cursor, and other agents.
```
Insert immediately **after** it:
```
├── org/             ← Team layer: org operating model, onboarding, and the Commons.
│   └── commons/     ← Optional shared decision layer for teams sharing one repo.
```

- [ ] **Step 2: Add the team section to the README**

In `README.md`, find the section heading:
```
## The seven principles
```
Insert immediately **before** it (with a trailing blank line and `---` separator):
```markdown
## Working with a team? Add the Commons

Everything above is for *you and your agent*. If several teammates share one
repo and their own AI access, you hit two problems: each session burns tokens
re-deriving the same context, and each agent quietly makes its own decisions.

The **Commons** is an opt-in shared decision layer — a committed `commons/`
folder that every agent reads as the team's source of truth, with new entries
gated behind human ratification. It cuts redundant token use and keeps the team
converged.

Add it with one command:

```bash
bash org/commons/init-commons.sh /path/to/your/repo
```

Full guide: [`org/ORG-COMMONS.md`](./org/ORG-COMMONS.md).

---
```

- [ ] **Step 3: Add an optional Commons subsection to ORG-ONBOARDING.md**

In `org/ORG-ONBOARDING.md`, find the heading:
```
## Facilitation notes
```
Insert immediately **before** it:
```markdown
## If your team shares a codebase

The session above is about how your team *relates* to AI. If your team also
*builds* in a shared repository with their own AI access, add the **Commons**
(`org/ORG-COMMONS.md`) — an opt-in `commons/` folder that becomes the team's
shared source of truth for settled facts and decisions. It stops every agent
re-deriving the same context (which maxes out tokens) and keeps teammates'
agents converged, with new entries gated behind human ratification.

This is optional and technical-leaning — skip it for non-engineering teams.

---
```

- [ ] **Step 4: Verify both edits landed and links resolve**

Run:
```bash
grep -q 'Working with a team? Add the Commons' README.md && echo "README SECTION OK"
grep -q 'org/ORG-COMMONS.md' README.md && echo "README LINK OK"
grep -q 'If your team shares a codebase' org/ORG-ONBOARDING.md && echo "ONBOARDING OK"
test -f org/ORG-COMMONS.md && echo "LINK TARGET EXISTS"
```
Expected: `README SECTION OK`, `README LINK OK`, `ONBOARDING OK`, `LINK TARGET EXISTS`.

- [ ] **Step 5: Commit**

```bash
git add README.md org/ORG-ONBOARDING.md
git commit -m "docs(commons): surface the Commons from README and onboarding behind the team framing"
```

---

## Notes for the implementer

- Run the Task 2 test (`bash org/commons/tests/test-init-commons.sh`) again after Task 4 to confirm nothing regressed; it operates on a temp dir and is independent of the doc edits.
- Do not touch `CLAUDE.md`, `PRINCIPLES.md`, or `INTEGRAL.md` in the repo root — the Commons must not alter the solo-user philosophy layer.
- After all tasks, open a PR from `feature/commons-shared-decision-layer` into `main` (this project's flow is `feature/* → main` via PR). Do not push to `main` directly.
