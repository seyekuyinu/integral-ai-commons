# Human-Centered AI

> *The human is not here to serve the tools. The tools are here to serve the human.*

A lightweight, installable operating model for AI agents — shaping how they work *with* you, not just *for* you.

---

## What this is

This is not a framework for building AI products. It is a set of principles and instructions that change how an AI agent *relates* to you when you work together.

Most AI tools are optimized for output. This is optimized for **you** — your judgment, your voice, your growth, your community.

When an agent loads this, it works differently:

- It handles tasks that have no soul so you can focus on the ones that do
- It keeps your voice yours — not generic, not corporate, not AI-sounding
- It steps back when decisions belong to you
- It names when you are becoming dependent on it rather than more capable
- It asks who might be left out when the work touches other people

---

## Who this is for

Anyone using AI tools to do real work: entrepreneurs, coaches, educators, creatives, builders. This is especially useful if you work in or with communities, not just for yourself.

You do not need to be technical to use this. If you use Claude, ChatGPT, Cursor, or any AI assistant, this applies to you.

---

## What's in this repo

```
├── CLAUDE.md        ← The core file. Load this into any Claude Code session.
├── PRINCIPLES.md    ← The seven principles, in plain language and agent-readable form.
├── INTEGRAL.md      ← The philosophical architecture. Integral Theory mapping of the full framework.
├── USAGE.md         ← What actually changes. Concrete examples and real scenarios.
├── install.md       ← How to install for Claude Code, Cursor, and other agents.
├── docs/
│   └── bridges-guide.html  ← Plain-language community guide (for my friends at the Jacksonville Bridges Cohort 24)
└── README.md        ← You are here.
```

---

## Quick install (Claude Code)

Copy `CLAUDE.md` into the root of your project or your home `~/.claude/` directory:

```bash
# For a specific project
curl -o CLAUDE.md https://raw.githubusercontent.com/your-username/human-centered-ai/main/CLAUDE.md

# For global use across all Claude Code sessions
curl -o ~/.claude/CLAUDE.md https://raw.githubusercontent.com/your-username/human-centered-ai/main/CLAUDE.md
```

That's it. Claude Code reads `CLAUDE.md` automatically at session start.

For other agents and tools, see [`install.md`](./install.md).

---

## The seven principles

1. **Amplify, don't replace** — AI enhances human judgment. It does not substitute for it.
2. **Access belongs to everyone** — Don't build or recommend systems that create new gatekeeping.
3. **Transparency as default** — Explain what you're doing and why when it matters.
4. **The human defines what's good** — You don't decide what flourishing looks like for them or their community.
5. **Name what's not working** — Honest failure is more useful than polished success.
6. **Stay adaptable** — Build habits that outlast any single tool.
7. **Human agency is the load-bearing wall** — Every suggestion either expands it, protects it, or refuses to trade it away.

Full breakdown in [`PRINCIPLES.md`](./PRINCIPLES.md).

---

## The idea behind this

AI tools right now are mostly built as products — owned by companies, priced in tiers, designed to keep you engaged. That model subtly optimizes for the tool, not for you.

This repo treats AI differently: as a shared resource that should expand what people can do, decide, and become, without replacing their judgment, their voice, or their community's right to define what good looks like for them.

That idea is grounded in a framework that addresses all four dimensions of human experience: interior individual, exterior individual, interior collective, and exterior collective. Most AI frameworks address only one or two. This one attempts all four.

The full philosophical architecture — including the Integral Theory mapping — is in [`INTEGRAL.md`](./INTEGRAL.md). The plain-language community version is in [`docs/bridges-guide.html`](./docs/bridges-guide.html).

Oh, I want to give a special thanks to Dr. Carlton Robinson, Chief Innovation Officer at the JAX Chamber for his presentation on Human-Centered AI as Applied Infrastructure. A huge part of his idea gave me lanaguage for a structure I have wanted to implement within my organization and personally as adoption of AI skyrockets. 

---

## How to contribute

If you use this and find something worth changing — a principle that needs sharpening, a behavior the agent gets wrong, a context this doesn't cover — open an issue or submit a PR.

This is meant to evolve through real use, not sit as a finished document. 

---

## License

MIT. Use it, fork it, build on it.
