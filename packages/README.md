# Installable Packages

This directory contains agent-installable packages built from the source
workflow docs in this repository.

## `figma-to-code-process`

`figma-to-code-process` is the single-entry package for the full workflow.
It is intentionally not a set of separately installed skills. The package
installs one agent-visible entry point, then keeps the internal phase rules and
distilled examples as references loaded only when needed.

Install locally:

```bash
scripts/install-figma-to-code-process.sh
```

Default destinations:

- Codex: `${CODEX_HOME:-$HOME/.codex}/skills/figma-to-code-process`
- Claude Code: `$HOME/.claude/skills/figma-to-code-process`
- Claude Code command: `$HOME/.claude/commands/figma-to-code.md`
- Generic agents: `$HOME/.agent-skills/figma-to-code-process`

Refresh package contents from source docs:

```bash
scripts/build-figma-to-code-process-package.sh
```

Run a no-write install preview:

```bash
scripts/install-figma-to-code-process.sh --dry-run
```

Check an installed Codex copy for updates:

```bash
~/.codex/skills/figma-to-code-process/scripts/check-for-updates.sh
```

The checker reports whether the installed commit matches the current
`main` branch and prints refresh commands when an update is available.
