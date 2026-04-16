# Installation

How to load the Human-Centered AI operating principles into your AI tools.

No technical background required for the basic install. The advanced options are there if you want them.

---

## Claude Code

Claude Code reads `CLAUDE.md` automatically at the start of every session. There are two ways to install — project-level and global.

### Project-level (one project only)

Copy `CLAUDE.md` into the root of your project folder:

```bash
curl -o CLAUDE.md https://raw.githubusercontent.com/your-username/human-centered-ai/main/CLAUDE.md
```

Every Claude Code session started inside that folder will load these principles automatically.

### Global (all projects)

Copy `CLAUDE.md` into your home `.claude` directory so it loads for every session, regardless of which project you are in:

```bash
# Create the directory if it doesn't exist
mkdir -p ~/.claude

# Download CLAUDE.md globally
curl -o ~/.claude/CLAUDE.md https://raw.githubusercontent.com/your-username/human-centered-ai/main/CLAUDE.md
```

**Note:** If you already have a `CLAUDE.md` in a project folder, that file takes precedence over the global one. You can also append the contents of this file to an existing `CLAUDE.md` rather than replacing it.

---

## Claude (claude.ai)

If you use Claude in the browser or app rather than Claude Code, you can paste the contents of `CLAUDE.md` directly into a custom system prompt or at the start of a conversation.

**To use it once:**
Open `CLAUDE.md`, copy the full contents, and paste it at the top of your conversation before you start working.

**To use it consistently:**
In Claude's settings, look for "Custom Instructions" or "System Prompt." Paste the contents of `CLAUDE.md` there. It will apply to all your conversations.

---

## Cursor

Cursor supports a `.cursorrules` file in your project root that shapes how the AI behaves.

```bash
curl -o .cursorrules https://raw.githubusercontent.com/your-username/human-centered-ai/main/CLAUDE.md
```

Or copy the contents of `CLAUDE.md` manually into your existing `.cursorrules` file.

---

## Other agents and tools

Any AI tool that supports a system prompt, a custom instructions field, or a context file can load these principles.

**The pattern is always the same:**
1. Open `CLAUDE.md` from this repo
2. Copy the full contents
3. Paste into whatever field your tool uses for persistent instructions

Common field names across tools: System Prompt, Custom Instructions, Context, Memory, Persona, Behavior Settings.

---

## Verify it's working

After installing, start a session and ask your agent:

> "What principles are guiding how you work with me?"

A properly loaded agent should reflect back the core ideas: amplifying your capability, keeping your voice yours, naming what it doesn't know, and stepping back on decisions that belong to you.

If it doesn't, the file may not have loaded. Check the location and try again.

---

## Keeping it updated

This repo evolves through real use. To get the latest version:

```bash
# Project-level
curl -o CLAUDE.md https://raw.githubusercontent.com/your-username/human-centered-ai/main/CLAUDE.md

# Global
curl -o ~/.claude/CLAUDE.md https://raw.githubusercontent.com/your-username/human-centered-ai/main/CLAUDE.md
```

---

## Customizing for your context

These principles are a starting point, not a final word. You are encouraged to:

- Add context about who you are and what you are building
- Append principles specific to your industry or community
- Remove anything that does not fit your situation

The only thing worth keeping intact: **the human stays in charge**.
