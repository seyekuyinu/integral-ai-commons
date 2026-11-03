# Team conventions

This folder holds the way *this* team works, in whatever shape the team already
uses. A Definition of Done, a Definition of Ready, a working agreement, a review
checklist, a handoff ritual, a brief template: if the team relies on it, it
belongs here. Nothing is required, and nothing is named for you.

## Add a convention

1. Copy `_TEMPLATE.md` to a new file, for example `definition-of-done.md` or
   `working-agreement.md`.
2. Fill in the frontmatter. `answers` matters most: it is how an agent decides
   to open this file instead of loading everything.
3. Write the convention below the frontmatter in your own words.
4. Run `bash commons/map-conventions.sh` from the repo root to list it in
   `commons/MAP.md`. In CI, `bash commons/map-conventions.sh --check` fails
   when the map is out of date.

A new convention is a team decision, so it goes through a proposal and a human
ratifies it, like any other Commons entry.

## Frontmatter fields

| Field | Required | What it does |
|---|---|---|
| `name` | Yes | The name the team uses for it. |
| `answers` | Yes | The questions this file answers, in plain words. |
| `use_when` | No | The moment in the work it applies, such as "before starting a story" or "before a client sends". |
| `gate` | No | The human gate it supports: `decision`, `exception`, `release`, or `none`. |
| `owner` | No | Who keeps it current. |

Files whose names start with `_`, and this README, are never listed in the map.
