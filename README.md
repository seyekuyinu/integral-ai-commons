# Integral AI Commons

> *The human is not here to serve the tools. The tools are here to serve the human.*

A human-centered operating model for AI agents — installable into Claude Code,
Cursor, Codex, and anything else that reads an `AGENTS.md`.

---

## What this is

This is not a framework for building AI products. It is a set of principles, and
the mechanisms that enforce them, that change how an AI agent *relates* to you
when you work together.

Most AI tooling is optimized for output. This is optimized for **you** — your
judgment, your voice, your growth, your community.

It comes in three layers. Take as many as you need:

| Layer | For | Start at |
|---|---|---|
| **The Commons** | A team sharing one repo and one source of truth | [`org/ORG-COMMONS.md`](./org/ORG-COMMONS.md) |
| **The principles** | You and your agent | [`AGENTS.md`](./AGENTS.md) |
| **The plugin** | Principles that fire, instead of prose that drifts | [`plugin/`](./plugin/README.md) |

---

## The Commons — a shared decision layer for teams

This is the part of the project that is a mechanism rather than a statement, and
it solves a problem that arrived with multi-agent teams.

When several teammates each have their own AI access on the **same** repo, two
things go wrong at once:

- **Token maxing.** Every session re-reads the same context and re-derives the
  same conclusions. Redundant work, multiplied by headcount.
- **Divergent truth.** Each person's agent makes its own local calls. Nothing
  accumulates into a shared record, so the agents quietly disagree.

The Commons is a `commons/` folder committed to your shared repo: an always-read
`INDEX.md`, three layer files for settled context, engineering, and product
decisions, and a `proposals/` inbox. Agents read it as closed. Agents may
*propose* — **only a human ratifies.**

That last line is the whole point. It is human agency implemented as a data
structure rather than described in a paragraph.

```bash
bash org/commons/init-commons.sh /path/to/your/repo
```

Full guide: [`org/ORG-COMMONS.md`](./org/ORG-COMMONS.md).

---

## The principles — for you and your agent

When an agent loads [`AGENTS.md`](./AGENTS.md), it is asked to work differently:

- Handle tasks that have no soul so you can focus on the ones that do
- Keep your voice yours — not generic, not corporate, not AI-sounding
- Step back when decisions belong to you
- Name when you are becoming dependent on it rather than more capable
- Ask who might be left out when the work touches other people

### Quick install

```bash
curl -o AGENTS.md https://raw.githubusercontent.com/seyekuyinu/integral-ai-commons/main/AGENTS.md
```

That one file covers Claude Code, Cursor, Codex, Gemini CLI, and anything else
that has adopted the convention. For global installs, `.cursor/rules`, and
claude.ai, see [`install.md`](./install.md).

### The seven principles

1. **Amplify, don't replace** — AI enhances human judgment. It does not substitute for it.
2. **Access belongs to everyone** — Don't build or recommend systems that create new gatekeeping.
3. **Transparency as default** — Explain what you're doing and why when it matters.
4. **The human defines what's good** — You don't decide what flourishing looks like for them or their community.
5. **Name what's not working** — Honest failure is more useful than polished success.
6. **Stay adaptable** — Build habits that outlast any single tool.
7. **Human agency is the load-bearing wall** — Every suggestion either expands it, protects it, or refuses to trade it away.

Full breakdown in [`PRINCIPLES.md`](./PRINCIPLES.md).

---

## The plugin — principles that run

A file in context is a request an agent can drift from. A skill fires when its
trigger conditions are met.

```
/plugin marketplace add seyekuyinu/integral-ai-commons
/plugin install human-centered-ai
```

Three skills: an agency check before decisions that are yours, a dependency check
when deferral becomes a pattern, and a voice check before anything you send under
your own name. See [`plugin/README.md`](./plugin/README.md).

---

## Does any of this actually work?

Sometimes not, and the repo says so.

[`EVIDENCE.md`](./EVIDENCE.md) holds tests of whether loading the file changes
agent behavior, reported as they came out. The first test — nine runs across
three arms on a decision the agent should have handed back — found **no
measurable effect**. The file did not change what the agent did.

That result stays published. A framework that only shows its wins is the thing it
warns you about.

---

## Who this is for

Anyone using AI tools to do real work: entrepreneurs, coaches, educators,
creatives, builders. Especially useful if you work in or with communities, not
just for yourself.

You do not need to be technical. If you use Claude, ChatGPT, Cursor, or any AI
assistant, this applies to you. The plain-language version is in
[`docs/bridges-guide.html`](./docs/bridges-guide.html).

---

## What's in this repo

```
├── AGENTS.md        ← The core file. Portable across agents. Start here.
├── CLAUDE.md        ← A pointer to AGENTS.md, for Claude Code.
├── PRINCIPLES.md    ← The seven principles, for humans and for agents.
├── INTEGRAL.md      ← The philosophical architecture. Integral Theory mapping.
├── USAGE.md         ← What actually changes. Concrete examples.
├── EVIDENCE.md      ← Tests of whether it works, including the failures.
├── install.md       ← Installing for Claude Code, Cursor, and other agents.
├── plugin/          ← Claude Code plugin: the principles as skills that fire.
├── org/             ← Team layer: org operating model, onboarding, and the Commons.
│   └── commons/     ← The shared decision layer scaffolder and templates.
└── docs/
    ├── bridges-guide.html  ← Plain-language community guide.
    └── evidence/           ← Raw transcripts from the tests in EVIDENCE.md.
```

---

## The idea behind this

AI tools right now are mostly built as products — owned by companies, priced in
tiers, designed to keep you engaged. That model subtly optimizes for the tool,
not for you.

This repo treats AI differently: as a shared resource that should expand what
people can do, decide, and become, without replacing their judgment, their voice,
or their community's right to define what good looks like for them.

That idea is grounded in a framework that addresses all four dimensions of human
experience: interior individual, exterior individual, interior collective, and
exterior collective. Most AI frameworks address only one or two. This one
attempts all four. The full architecture is in [`INTEGRAL.md`](./INTEGRAL.md).

Special thanks to Dr. Carlton Robinson, Chief Innovation Officer at the JAX
Chamber, for his presentation on Human-Centered AI as Applied Infrastructure. A
huge part of his idea gave me language for a structure I have wanted to implement
within my organization, and personally, as adoption of AI skyrockets.

---

## How to contribute

If you use this and find something worth changing — a principle that needs
sharpening, a behavior the agent gets wrong, a context this doesn't cover — open
an issue or a PR.

Test results are the most valuable contribution, and **negative results are
welcome**. See the contributing note at the end of [`EVIDENCE.md`](./EVIDENCE.md).

This is meant to evolve through real use, not sit as a finished document.

---

## License

MIT. See [`LICENSE`](./LICENSE). Use it, fork it, build on it.
