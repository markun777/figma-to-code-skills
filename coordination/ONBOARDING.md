# Onboarding

Quick-start for a new thread, new contributor, or any agent picking up this project mid-stream.

## What this project is

A system for turning messy, non-standard Figma design files into production-quality code — reliably, across multiple agents and sessions.

The core problem: most Figma files are not clean sources of truth. States are missing, rules are implicit, assets are inconsistent. This project builds the workflow, rules, and skill prompts needed to handle that reality instead of pretending it away.

## Why we're building it

The goal is a reusable, agent-executable skill set that any Claude or Codex session can pick up and run a Figma-to-code component case through — with consistent quality, explicit checkpoints, and recoverable failures.

Secondary goal: every real component case teaches us something. Recurring failures get promoted into skill gotchas so the next case doesn't repeat them.

## How the three contributors work together

| Contributor | Role |
|---|---|
| User (markun) | Final decision-maker on priorities, design decisions, provisional-state confirmation, and closeouts |
| Claude Code | Executes component cases, writes/edits code, manages coordination files, and contributes explicitly attributed suggestions |
| Codex | Reviews implementation, runs browser verification, proposes rule tightening, and contributes explicitly attributed suggestions |

Communication channel: GitHub issue [#13](https://github.com/TAI-IPX/figma-to-code-skills/issues/13) — permanent rolling log, never close.

Decision protocol:
- keep suggestion ownership explicit (`user`, `Claude Code`, `Codex`)
- when posting recommendations through the shared GitHub account, prefix
  them with the agent name, for example `Codex:` or `Claude Code:`
- do not collapse an individual recommendation into "the project thinks"
  until contributors have aligned on it
- once a recommendation or objection is raised, sync it to `#13` by
  default so the shared log reflects not just actions, but advice and
  pending decisions as well

## Project phases

| Phase | Status | Summary |
|---|---|---|
| Phase 1 | closed | Rewrote all skill READMEs from spec docs into executable agent prompts |
| Phase 2 | closed | Established tech-stack profile, workflow baseline, coordination structure |
| Phase 3 | closed (2026-04-13) | Tab, InputBox, Toolbar — all verified and committed |
| Phase 4 | closed (2026-04-20) | `figma-execution-shell` merged; Dialog, AIToolsRow, Sidebar (default-only) all closed |
| Phase 5 | closed (2026-04-20) | BrowserResultPage + AssistantSidebarPanel composite family case merged and formally closed |
| Phase 6 | closed (2026-04-22) | WorkspacePage + TaskChatPanel Repeatability case complete. All 8 component cases closed. |

## Current component status

| Component | Status | Notes |
|---|---|---|
| Tab | closed | 8 variants verified |
| InputBox | closed | 4 states verified |
| Toolbar | closed | 5 states verified |
| Dialog | closed | All axes verified, HYQiHei font deferred |
| AIToolsRow | closed | ToolPill family, hover/active, inline SVG icons |
| Sidebar | verified (expanded + icon-only source) | Expanded/default pass closed; icon-only rail `1708:30181` source-confirmed and matched to existing collapsed implementation |
| BrowserResultPage / AssistantSidebarPanel | closed (2026-04-21) | Composite family case; collapsed launcher deferred |
| WorkspacePage / TaskChatPanel | closed (2026-04-22) | Phase 6 Repeatability case; agentic-browser-ui PR #6 pending merge |

## Component Family Definition

Three historical validation cards were written and replay-validated
(2026-04-17). All passed Figma / code / verify three-segment validation.
The format is now formalized as the required component-scoped output of
`figma-create-design-system-rules` when the family boundary is clear.
The three samples remain in `experiments/` as validation evidence across
provisional-axis (AIToolsRow), pure-formal (Dialog), and
composite-formal (Sidebar) cases.

Cards: `experiments/trial-component-family-definition-aitoolsrow.md`, `experiments/trial-component-family-definition-dialog.md`, `experiments/trial-component-family-definition-sidebar.md`

## Current todo

1. Start Phase B — Existing-rule capture validation
   - Open branch `phase-b/existing-rule-capture-validation` in figma-to-code-skills
   - Update `inventory/existing-rule-capture-agentic-browser-ui.md` (8 dimensions, each with code evidence)
   - Run one small downstream task that must cite the captured rules
   - Exit when at least one decision is demonstrably rule-driven
2. Validate a richer stateful candidate only after preflight; Sidebar icon-only is now a source-confirmed closeout, not a new variant-axis case
3. Shared typography pass for HYQiHei font remains a deferred cross-case non-blocker

## Quick entry points

| What | Where |
|---|---|
| Component status + node IDs | `coordination/INDEX.md` |
| Execution rules + component status table | `coordination/WORKING-MEMORY.md` |
| Coordination log | [issue #13](https://github.com/TAI-IPX/figma-to-code-skills/issues/13) |
| Skill prompts | `skills/*/README.md` |
| Workflow baseline | `inventory/workflow-outline.md` |
| Agent instructions | `CLAUDE.md` (Claude Code) / `AGENTS.md` (Codex) |
| Implementation repo | `~/Documents/Codex/Mars/agentic-browser-ui` |
| Figma file | `https://www.figma.com/design/iIbL9V4UrFeORPaM7KVji7` |
