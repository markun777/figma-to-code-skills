---
name: figma-to-code-process
description: End-to-end Figma-to-code delivery workflow package. Use when an agent needs to turn Figma designs into code, restore a product from Figma boards, capture design-system rules, export implementation assets, implement UI, verify rendered output, or coordinate multi-agent Figma-to-code work across Codex, Claude Code, or other coding agents.
---

# Figma To Code Process

Use this as the single entry point for the whole Figma-to-code workflow.
Do not expose the internal phase skills as separate user choices. Route the
work through this process, then load only the reference files needed for the
current phase.

## First Moves

1. Read the local agent instructions before touching files:
   `AGENTS.md`, `CLAUDE.md`, `CONTRIBUTING.md`, or the equivalent for the
   current repo.
2. Check ownership and branch state with the repo's normal commands. If the
   repo has GitHub coordination rules, check open PRs/issues before claiming
   work.
3. Classify the request:
   - `component-case`: implement or verify one component/state from Figma.
   - `product-restoration`: rebuild a product screen or app board by board.
   - `design-system-capture`: extract or confirm tokens, components, or rules.
   - `asset-export`: export Figma-owned image/vector assets for implementation.
   - `verification`: compare rendered UI against a Figma source.
   - `canvas-write`: create or clean Figma boards, provisional states, or
     design-system structures.
   - `skill-evolution`: convert a reusable lesson from real use into a
     reviewable skill/workflow improvement proposal.
4. Open `references/process-overview.md` for the phase map and checkpoint
   order.
5. Load the narrow reference file for the active phase from
   `references/source-skills/`. Avoid loading the full package unless the task
   genuinely crosses phases.
6. When an example would help, load `references/examples/README.md` and then
   the one distilled example that matches the current failure mode. Do not
   treat examples as source-of-truth for the current product.
7. When the user asks whether this installed package is current, or when an
   update check is explicitly useful, run
   `scripts/check-for-updates.sh` from this package if it exists. If it reports
   an update, tell the user to refresh from the source repo or run the install
   script from the checked-out repository.

## Required Gates

Run these gates for every real implementation case:

1. **Source of truth:** prefer confirmed product rules and design-system specs,
   then formal Figma component boards, then approved provisional states.
2. **Tech profile:** record target platform, framework, token format, asset
   pipeline, and verification surface before coding.
3. **Asset inventory:** classify each design-owned image/icon as existing
   export, new export required, no asset needed, or approved code-drawn
   primitive.
4. **State geometry scan:** identify layout-affecting borders/strokes, hidden
   state layers, frame-preserving icon needs, and responsive/form-factor risks.
5. **Rendered verification:** build/run the target surface and compare the
   rendered result to the Figma source. A clean build alone never closes a
   visual task.
6. **Closeout:** record evidence, blockers, deferred non-blockers, and any
   gotcha worth feeding back into the workflow. Do not silently mutate
   installed skills; route reusable lessons through source-repo proposals
   and PRs.

## Phase Routing

- For full cases, start with `references/source-skills/figma-execution-shell.md`.
- For Figma inspection, use the local Figma MCP/read tools and
  `references/source-skills/figma.md`.
- For Figma writes, load `references/source-skills/figma-use.md`.
- For messy source files, load
  `references/source-skills/figma-ai-implementation-cleanup.md`.
- For design-system discovery, load
  `references/source-skills/figma-capture-design-system.md`.
- For rule drafting, load
  `references/source-skills/figma-create-design-system-rules.md`.
- For assets, load `references/source-skills/figma-export-slices.md`.
- For implementation, load `references/source-skills/figma-implement-design.md`.
- For verification, load
  `references/source-skills/figma-verify-implementation.md`.
- For product restoration, load `references/product-restoration-preflight.md`
  and copy `assets/product-restoration-template/` into the product repo.
- For web motion only after state/source confirmation, load
  `references/source-skills/ui-motion-patterns.md`.
- For reusable workflow lessons, load
  `references/source-skills/figma-to-code-skill-evolution.md` and use the
  contribution templates in `references/evolution/`.
- For compact reusable examples, load `references/examples/README.md`.

## Clarification Policy

Ask before proceeding when:

- the target Figma node, file, or product board is unknown;
- the implementation repo or target platform is unknown;
- a state is missing from Figma and would need a provisional source;
- product restoration lacks a board/state map, token snapshot, asset manifest,
  layout constants, or interaction contract;
- another open PR or coordination note appears to own the same area;
- the requested output would bypass rendered verification.

Do not ask when local files, coordination notes, Figma metadata, or existing
product docs can answer the question safely.

## Closeout

End every run with:

- what was implemented or verified;
- exact source Figma nodes or docs used;
- build/run/verification commands and whether they passed;
- any unresolved drift or blocked gate;
- where the next agent should resume;
- whether a reusable workflow lesson was found. If yes, include the
  proposed generic rule, scope classification, and where the contribution
  proposal or PR lives.
