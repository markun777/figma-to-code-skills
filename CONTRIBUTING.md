# Contributing

This repo is worked on by humans, Claude Code, and Codex.
These rules apply to everyone equally.

## Branch strategy

- Never push directly to `main`.
- Every change goes through a feature branch and a pull request.
- Branch naming: `<area>/<short-description>`
  - Examples: `skill/figma-implement-design`, `setup/branch-protection`,
  `fix/capture-ds-clarification-policy`
- Keep each branch focused on one skill or one topic.

## Skill ownership

Each skill folder is owned by one contributor at a time to avoid conflicts.

Before editing a skill:

1. Check open PRs and branches to confirm no one else is working on it.
2. If it is free, claim it by opening a branch and a draft PR promptly.
3. If it is taken, wait for the PR to merge or coordinate with the owner.

Current ownership is tracked in open PRs.
A skill with no open PR is available to claim.

## What goes where

- `skills/<skill-name>/README.md`
The executable skill prompt. Write it so an agent can follow it
directly, not so a human can read about it.
Deployment is environment-specific: Claude Code copies it to
`~/.claude/skills/<skill-name>.md`; other runtimes (Codex, CI, etc.)
may package or sync it differently. The README format does not assume
any single deployment path.
- `inventory/`
Strategy documents, workflow outlines, templates, and profiles.
Do not edit strategy documents (e.g. `skills-strategy-overview.md`,
`workflow-outline.md`) without opening an issue first.
Small related updates to `skill-template.md` or `tech-stack-profile.md`
are allowed inside a skill PR when the change is directly required by
the skill being written. Include a brief rationale in the PR description.
- `experiments/`
Throw anything here: test prompts, sample outputs, Figma URLs used
during testing, rough drafts. No ownership rules apply.
- `references/`
External docs, screenshots, example files, and notes.
Add freely. Do not remove others' references without asking.

## Skill README format

All skill READMEs must follow `inventory/skill-template.md`.
The required sections are: Goal, When to use, When not to use,
Required context, Inputs, Outputs, Workflow, Clarification policy,
Gotchas, Verification.

Write in first-person imperative instructions, not third-person
description. The reader is Claude or another agent executing the skill,
not a human reading about it.

Good: "Confirm the tech-stack profile. If it is missing, ask before
proceeding."
Bad: "This skill should confirm the tech-stack profile."

## Commit messages

- First line: imperative, under 72 characters.
- Reference the skill or area in the message when relevant.
- Examples:
  - `rewrite figma-implement-design as executable prompt`
  - `add platform notes to figma-capture-design-system`
  - `fix clarification policy in figma-verify-implementation`

## Pull requests

- Title: same style as commit messages.
- Description: what changed and why. Link to a related issue if one
exists.
- Keep PRs small. One skill per PR is the default.
- PRs that touch `inventory/` need a brief rationale.

## Issues

Use GitHub Issues for decisions that need input from more than one
contributor. If you are unsure whether a design choice is right, open an
issue before writing code. This is the shared communication channel
between all contributors.

Current shared coordination happens in issue `#13` (Coordination Log,
permanent). Use it for cross-skill and cross-PR updates, status handoff,
and action summaries after each task.

Treat issue `#4` as the historical coordination thread for the Phase 1
rewrite only.

## Gotchas section upkeep

When a skill produces a recurring wrong output during real testing,
add an entry to its `Gotchas` section in the same PR that fixes it.
Do not save failure patterns only in your memory.

## Skill evolution proposals

When a lesson might improve the reusable Figma-to-code process but the
right target is not obvious, create a proposal under
`contributions/inbox/` from `contributions/TEMPLATE.md` before changing
long-lived rules. Classify the lesson as generic, platform-specific,
project-specific, or uncertain. Promote accepted lessons through the
smallest source artifact and a PR; do not silently rewrite installed
local skills.
