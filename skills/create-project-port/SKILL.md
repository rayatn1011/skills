---
name: create-project-port
description: Compute a stable dev server port (10000–19999) for a project folder via deterministic hash — same name always yields the same port. Use when the user asks what port to use for a project (or "run projectPort"), or wants to check for port collisions across several projects.
---

## What this does

The folder name is the only input — no config file or registry. Different names can still hash to the same port, which is why multi-project runs check for collisions.

## How to use it

Use `scripts/project-port.sh` — pass one or more folder names as arguments.

**Single project:**
```bash
bash <skill-dir>/scripts/project-port.sh <name>
```

**Multiple projects (with collision check):**
```bash
bash <skill-dir>/scripts/project-port.sh <name1> <name2> <name3> …
```

**No name specified** — default to the current folder:
```bash
bash <skill-dir>/scripts/project-port.sh "$(basename "$PWD")"
```

## Output format

Always show the **port number** prominently, then the folder name. For multi-project runs, show a sorted table and explicitly state whether collisions were found.
