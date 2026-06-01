# Figma to Code Skills

This repository holds the executable prompts, workflow rules, gotchas,
and coordination memory for the Figma-to-code system we are refining
across real component cases.

## What This Repo Does

The project is built to make messy or non-standard design files
implementable in code without pretending the design draft is already a
clean source of truth.

Default operating model:

- prefer an existing project spec or design-system rule set when one
  exists
- treat the active Figma file as implementation input, not automatic
  canonical truth
- extract and confirm missing rules before broad implementation
- route real assets through export instead of hand-drawing substitutes
- verify implemented UI against Figma and record recurring failures as
  reusable gotchas

## Decision Protocol

This repo is built collaboratively by the user, Claude Code, and Codex.

- attribute every recommendation to its source unless it has already
  become an explicit team consensus
- when posting recommendations or opinions under the shared GitHub
  account, prefix them with the agent name, for example `Codex:` or
  `Claude Code:`
- treat agent suggestions and reviews as inputs, not final decisions
- only mark something as shared consensus after the contributors have
  aligned on it
- the user makes the final decision on priority, scope, and closeout
- sync recommendation or opinion changes into issue `#13` by default so
  advice does not stay trapped in a single chat or PR

## Start Here

- **New to this project?** Read [coordination/ONBOARDING.md](coordination/ONBOARDING.md) first.
- Current shared coordination:
  [coordination/INDEX.md](coordination/INDEX.md)
- Compact stable memory for new threads:
  [coordination/WORKING-MEMORY.md](coordination/WORKING-MEMORY.md)
- Current workflow baseline:
  [inventory/workflow-outline.md](inventory/workflow-outline.md)
- Product restoration bootstrap/preflight:
  [inventory/product-restoration-preflight.md](inventory/product-restoration-preflight.md)
- Skill inventory:
  [skills/README.md](skills/README.md)
- Copyable templates:
  [templates/README.md](templates/README.md)
- Installable process package:
  [packages/README.md](packages/README.md)

## Installable Process Package

The full workflow can be installed as one agent-facing package:

```bash
scripts/install-figma-to-code-process.sh
```

This installs a single `figma-to-code-process` entry point for Codex,
Claude Code, and generic agent-skill directories. Internal phase skills stay
inside the package as references so agents follow one workflow instead of
choosing from separate sub-skills.

## Repository Layout

- `skills/`: executable skill prompts used by agents
- `packages/`: installable agent packages generated from workflow sources
- `inventory/`: workflow rules, templates, and stack profiles
- `templates/`: copyable starter files for product repos and case work
- `coordination/`: shared status, active case memory, and handoff context
- `experiments/`: case writeups, provisional findings, and workflow tests

## Current Focus

Phase N closed (2026-05-22). No open PRs.

Lettered phases A–N complete. Components closed: Tab, InputBox, Toolbar, Dialog, AIToolsRow, Sidebar,
BrowserResultPage/AssistantSidebarPanel, WorkspacePage, TaskResultPage,
FileListCard, NavigationMenu, SearchBar, ModelCard, TopTabBar (Phase I+J),
UpgradeDialog (Phase K+L), BookmarkItem (Phase M), BookmarkBar (Phase N).

No active track. Next: browser-ai-tools-product (independent product track).

See [coordination/INDEX.md](coordination/INDEX.md) for full phase history
and [coordination/WORKING-MEMORY.md](coordination/WORKING-MEMORY.md) for
compact current state.
