# The Commons — Shared Decision Layer for Teams

**Date:** 2026-06-24
**Status:** Approved design, pre-implementation
**Module:** Optional add-on to integral-ai-commons

---

## Positioning

Integral-ai-commons today is a **philosophy layer**: `CLAUDE.md` (operating
principles) and `INTEGRAL.md` (the architecture behind them) define the
personal and organizational orientation a human holds their AI to. That layer
is for *one human and their agent*.

The Commons is a separate, **opt-in module** layered on top of that
philosophy — never a replacement for it. It activates only when a team shares
a repository and a goal. The entry point is framed as a question:

> **Working with a product team, or a team sharing the same organizational
> goal? Add the Commons.**

A solo user never needs it. The base philosophy stands alone.

---

## Problem

When multiple teammates each have their own Claude access on the **same**
project, two failures compound:

1. **Token maxing** — every session re-reads the same project context and
   re-derives the same conclusions from scratch. Redundant work, multiplied by
   headcount.
2. **No converging source of truth** — each person's agent makes its own local
   decisions; nothing accumulates into a shared, authoritative record. Agents
   silently diverge.

Both are solved by the same mechanism: a canonical place where **settled**
facts and decisions live, that every agent reads and treats as closed. Agents
stop re-deriving (tokens drop) *and* stop diverging (truth converges).

---

## Design

### Folder structure

A `commons/` folder committed to the shared repo:

```
commons/
  INDEX.md          # always loads — one line per entry + pending-proposal pointers
  context.md        # Layer C: shared working memory (stack, key files, gotchas, glossary, priorities)
  engineering.md    # Layer A: resolved technical decisions (ADR-style, IDs ENG-001…)
  product.md        # Layer B: product/strategy/scope decisions (IDs PRD-001…)
  proposals/        # inbox — one dated file per pending proposal
    2026-06-24-postgres-over-sqlite.md
```

Three layers, deliberately separated so context (facts), engineering
(technical judgment), and product (strategic judgment) evolve independently.

`INDEX.md` is the load-bearing piece. One line per decision:
`ID · one-sentence summary · anchor into its layer file`, plus a
`Pending proposals (n)` section. It stays small by construction, so
per-session load cost is roughly flat even as the commons grows — the defense
against the project's own *complexity collapse* failure mode.

**INDEX.md shape:**

```markdown
# Commons Index

## Context
- stack — Next.js + Supabase, Bun runtime · context.md#stack
- deploy — Vercel, prod gated behind PR · context.md#deploy

## Engineering
- [ENG-007] Postgres over SQLite — durability for multi-writer · engineering.md#eng-007

## Product
- [PRD-003] No public API in v1 — scope discipline · product.md#prd-003

## Pending proposals (1)
- proposals/2026-06-24-postgres-over-sqlite.md
```

### Read loop (where tokens are saved)

A block appended to the project `CLAUDE.md`:

> At session start, read `commons/INDEX.md`. Treat ratified entries as settled
> — do not re-derive, re-explore, or re-litigate them. Open a layer file only
> when your task touches one of its entries. If you reach a decision or
> discover a project fact that isn't in the commons, draft a proposal instead
> of deciding silently.

Savings = avoided re-derivation × teammates × sessions. The index is cheap to
load; what it prevents (re-exploring the stack, re-arguing settled calls) is
the expensive part.

### Propose → ratify loop (the human gate)

Write authority is **human-ratified only** — the project's principle #4,
*"the human defines what's good,"* made mechanical.

- **Propose:** an agent hits a fact or decision not in the commons → writes
  `proposals/YYYY-MM-DD-slug.md` containing: title, target layer, context, the
  decision, rationale, who proposed it, `status: pending`. Adds a line to the
  index's pending section.
- **Ratify (agent-assisted):** the human says *"ratify proposal X"* → the agent
  appends the entry to the correct layer file with a stable ID (`ENG-007`),
  promotes the one-liner into `INDEX.md`, and removes the proposal file. The
  human **approves the diff** — that approval is the gate.
- **Reject:** delete the proposal or mark `status: rejected`. Nothing enters
  truth without human ratification.

### Distribution (reusable scaffold)

Ships inside integral-ai-commons alongside `install.md`:

- a `commons/` template (the folder above, with seeded empty layer files and a
  starter `INDEX.md`),
- an `init-commons` runbook (markdown, optionally a small shell script) that
  scaffolds the folder into a target repo and injects the `CLAUDE.md` read-loop
  block,
- an entry-point note in `install.md` / README gated behind the
  *"Working with a product team…"* question.

Doc-driven, matching how the project already distributes its principles — no
new runtime, no service.

### Concurrency (single shared git repo)

Rule: **ratified = merged to main; pull before you trust the commons.**

- Proposals are additive files → effectively zero merge conflict.
- Layer files are append-mostly → rare, trivial conflicts.
- `INDEX.md` is the one hot file; keeping each section append-ordered minimizes
  collisions.

### Quadrant fit

- `context.md` / `engineering.md` → **Its** (Lower Right: systems, structure)
- `product.md` → **We** (Lower Left: shared meaning)
- human ratification gate → **I** (Upper Left: agency)

The Commons operationalizes the project's collective quadrants — the ones the
philosophy layer names but a solo `CLAUDE.md` can't enact.

---

## Out of scope (YAGNI)

- No database, web UI, or real-time sync.
- No multi-approver voting — one human ratifier.
- No automated conflict resolution.
- No token-savings dashboard — a manual before/after spot-check validates the
  approach.

---

## Success criteria

1. A team can run one `init-commons` step and have a working `commons/` folder
   plus the `CLAUDE.md` read-loop wired in.
2. An agent in a fresh session reads `INDEX.md` and demonstrably skips
   re-deriving a fact already recorded there.
3. The propose → ratify → index flow works end to end, with the human
   approving every entry that lands in a layer file.
4. The base philosophy layer is unchanged for solo users; the Commons is
   invisible until explicitly added.
