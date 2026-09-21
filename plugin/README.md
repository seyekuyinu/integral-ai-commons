# human-centered-ai (Claude Code plugin)

The seven principles, shipped as mechanisms instead of prose.

A file in context is a request an agent can drift from. A skill fires when its
trigger conditions are met, at the moment it matters.

## Install

```
/plugin marketplace add seyekuyinu/integral-ai-commons
/plugin install human-centered-ai
```

## What's in it

| Skill | Fires when | Principle |
|---|---|---|
| `agency-check` | Before an irreversible or human-owned decision | 7 — agency is load-bearing |
| `dependency-check` | When deferral becomes a pattern in a session | 1 — amplify, don't replace |
| `voice-check` | Before anything sent or published in their name | 1 — keep their voice theirs |

Each skill is plain markdown. Read them, edit them, delete the one that does not
fit your work. They are in `skills/`.

## Why skills and not hooks

A hook that injected a check into every turn would be the same failure the
principles warn about: interrogating instead of moving, and treating vigilance as
a substitute for judgment. Skills load when relevant and stay out of the way when
they are not.

## Relationship to `AGENTS.md`

`AGENTS.md` is the always-on layer — the orientation. The plugin is the
situational layer — the checks. Use the file alone if you want the philosophy.
Add the plugin if you want it to actually interrupt something.
