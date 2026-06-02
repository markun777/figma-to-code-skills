# AI Install Instructions

If a user gives you this repository URL and says "install this skill", install
the single skill package at:

```text
packages/figma-to-code-process
```

The installed skill name is:

```text
figma-to-code-process
```

## Preferred Install Command

For Codex, Claude Code, and generic agent-skill directories, run:

```bash
curl -fsSL https://raw.githubusercontent.com/markun777/figma-to-code-skills/main/scripts/install-from-github.sh | bash
```

This installs to:

- `${CODEX_HOME:-$HOME/.codex}/skills/figma-to-code-process`
- `$HOME/.claude/skills/figma-to-code-process`
- `$HOME/.claude/commands/figma-to-code.md`
- `$HOME/.agent-skills/figma-to-code-process`

## Check For Updates

After installing, agents can check whether a local copy is current by
running the package helper from the installed location:

```bash
~/.codex/skills/figma-to-code-process/scripts/check-for-updates.sh
```

If it reports an update, rerun the preferred install command.

## Codex Skill Installer Alternative

If you are using Codex's built-in `skill-installer`, install only the Codex
skill with:

```bash
python3 /Users/markun/.codex/skills/.system/skill-installer/scripts/install-skill-from-github.py \
  --repo markun777/figma-to-code-skills \
  --path packages/figma-to-code-process
```

Or use the direct GitHub tree URL:

```text
https://github.com/markun777/figma-to-code-skills/tree/main/packages/figma-to-code-process
```

## After Install

Tell the user to restart the agent app if it requires restart to pick up new
skills. Then invoke:

```text
Use $figma-to-code-process to implement this Figma design in the target repo.
```
