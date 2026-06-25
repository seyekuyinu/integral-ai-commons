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
