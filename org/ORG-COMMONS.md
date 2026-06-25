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
