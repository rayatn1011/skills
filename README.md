# rayatn1011's agent skills

> A growing collection of skills for my work.

## Highlights

- **Small & focused**: each skill does one thing well, no bloated prompts.
- **One-command install**: `npx skills add rayatn1011/skills -g`.

## Skills

| Skill                  | What it does                                                                                                  |                                              |
| ---------------------- | ------------------------------------------------------------------------------------------------------------- | -------------------------------------------- |
| `create-project-port`  | Hashes a folder name into a stable dev-server port (10000–19999); the same name always maps to the same port. | [docs](skills/create-project-port/SKILL.md)  |
| `upgrade-dependencies` | Upgrades npm/pnpm/yarn dependencies safely and in the right order.                                            | [docs](skills/upgrade-dependencies/SKILL.md) |

## Installation

Install globally.

```bash
npx skills add rayatn1011/skills -g
```

Install into the current project.

```bash
npx skills add rayatn1011/skills
```

Install a specific skill.

```bash
npx skills add rayatn1011/skills -g -s upgrade-dependencies
```

`npx skills` works with any skills-aware agent (Claude Code, Codex, Cursor, etc).

See [vercel-labs/skills](https://github.com/vercel-labs/skills) for more information.

## Usage

Once installed, a skill can run two ways:

- **Automatically**: just describe your task and the agent picks the skill from its description:

  ```
  You: let's upgrade our dependencies
  → the upgrade-dependencies skill kicks in
  ```

- **Manually**: invoke it by name:

  ```
  /upgrade-dependencies
  ```

## Author

Made by [rayatn1011](https://github.com/rayatn1011).

## License

Released under the [MIT License](LICENSE).
