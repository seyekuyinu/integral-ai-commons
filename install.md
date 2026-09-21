# Installation

How to load the Human-Centered AI operating principles into your AI tools.

No technical background required for the basic install. The advanced options are there if you want them.

---

## The file to install

The canonical file is **`AGENTS.md`**. It is plain markdown with no tool-specific
syntax, and it is the file most coding agents now read by convention — Claude
Code, Codex, Cursor, Gemini CLI, and others.

Installing one portable file instead of one file per tool is principle 6 in
practice: no lock-in, nothing to re-copy when you switch tools.

Throughout this page:

```bash
RAW=https://raw.githubusercontent.com/seyekuyinu/integral-ai-commons/main
```

---

## Any agent that reads `AGENTS.md` (recommended)

Drop it in your project root:

```bash
curl -o AGENTS.md $RAW/AGENTS.md
```

That covers Claude Code, Codex, Cursor, Gemini CLI, Amp, and anything else that
has adopted the convention. Start a session in that folder and the principles
load automatically.

---

## Claude Code

Claude Code reads `AGENTS.md` and `CLAUDE.md`. Either works.

### Project-level (one project only)

```bash
curl -o AGENTS.md $RAW/AGENTS.md
```

### Global (all projects)

```bash
mkdir -p ~/.claude
curl -o ~/.claude/AGENTS.md $RAW/AGENTS.md
```

**Note:** A file in your project folder takes precedence over the global one. If
you already have instructions there, append these rather than replacing them.

### As a plugin (principles that actually run)

A file in context is a request. A plugin is a mechanism. This repo ships one:

```bash
/plugin marketplace add seyekuyinu/integral-ai-commons
/plugin install human-centered-ai
```

You get the principles as always-on context, plus three skills that fire when
they are relevant — an agency check before consequential actions, a dependency
check across a working session, and a voice check before anything you will send
or publish.

See [`plugin/README.md`](./plugin/README.md) for what each one does.

---

## Cursor

Cursor reads `AGENTS.md` in the project root. That is the simplest install:

```bash
curl -o AGENTS.md $RAW/AGENTS.md
```

If you prefer Cursor's own rules format, it lives in `.cursor/rules/` as `.mdc`
files with a small frontmatter header. The older single `.cursorrules` file is
deprecated — do not use it for a new install.

```bash
mkdir -p .cursor/rules
{
  printf -- '---\ndescription: Human-centered AI operating principles\nalwaysApply: true\n---\n\n'
  curl -s $RAW/AGENTS.md
} > .cursor/rules/human-centered-ai.mdc
```

---

## Claude (claude.ai)

If you use Claude in the browser or app rather than Claude Code, paste the
contents of `AGENTS.md` into a custom system prompt or at the start of a
conversation.

**To use it once:** open `AGENTS.md`, copy the full contents, and paste it at the
top of your conversation before you start working.

**To use it consistently:** in Claude's settings, look for "Custom Instructions"
or "System Prompt" and paste the contents there. It applies to all your
conversations.

---

## Other agents and tools

Any AI tool with a system prompt, a custom instructions field, or a context file
can load these principles.

**The pattern is always the same:**

1. Open `AGENTS.md` from this repo
2. Copy the full contents
3. Paste into whatever field your tool uses for persistent instructions

Common field names across tools: System Prompt, Custom Instructions, Context,
Memory, Persona, Behavior Settings.

---

## Verify it's working

After installing, start a session and ask your agent:

> "What principles are guiding how you work with me?"

A properly loaded agent should reflect back the core ideas: amplifying your
capability, keeping your voice yours, naming what it doesn't know, and stepping
back on decisions that belong to you.

If it doesn't, the file may not have loaded. Check the location and try again.

For a harder test than self-report, see [`EVIDENCE.md`](./EVIDENCE.md) — it
compares agent behavior with and without the file on the same task.

---

## Keeping it updated

This repo evolves through real use. To get the latest version:

```bash
# Project-level
curl -o AGENTS.md $RAW/AGENTS.md

# Global (Claude Code)
curl -o ~/.claude/AGENTS.md $RAW/AGENTS.md
```

If you installed the plugin, run `/plugin update human-centered-ai` instead.

---

## Customizing for your context

These principles are a starting point, not a final word. You are encouraged to:

- Add context about who you are and what you are building
- Append principles specific to your industry or community
- Remove anything that does not fit your situation

The only thing worth keeping intact: **the human stays in charge**.
