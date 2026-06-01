# Official Figma Skills Alignment

This note aligns the repo's local skills with the official Figma MCP
skills and records which official ideas we adopt, defer, or override with
project-tested rules.

Sources checked:

- Figma Help Center: Figma skills for MCP
  https://help.figma.com/hc/en-us/articles/39166810751895-Figma-skills-for-MCP
- Figma Developer Docs: Implement Design
  https://developers.figma.com/docs/figma-mcp-server/skill-figma-implement-design/
- Figma Developer Docs: Build / Update Screens from Design System
  https://developers.figma.com/docs/figma-mcp-server/skill-figma-generate-design/
- Figma Developer Docs: Code Connect integration
  https://developers.figma.com/docs/figma-mcp-server/code-connect-integration/
- Figma Developer Docs: Code Connect Components skill
  https://developers.figma.com/docs/figma-mcp-server/skill-figma-code-connect-components/

## Alignment Principle

Official Figma skills are the upstream baseline for skill boundaries and
task routing. This repo keeps local rules when real validation has proven
that the generic official workflow is not enough for reliable
implementation.

Local rules may be stricter than official skills when they are backed by
evidence from `agentic-browser-ui`, Figma node context, browser DOM
measurement, or verified workflow failures.

## Skill Map

| Official capability | Local skill or rule | Local status |
|---|---|---|
| `figma-use` write-to-canvas foundation | `skills/figma-use` | Aligned, with extra local gotchas for write verification, `createNodeFromSvg`, `currentColor`, and provisional-board placement. |
| `figma-use-figjam` | none | Deferred. Not needed for current design-to-code validation unless we start using FigJam for architecture, ERD, or planning boards. |
| `figma-code-connect-components` | `skills/figma-code-connect-components` | Aligned as a later maturity step. Must stay gated on published Figma components, plan support, codebase match, and explicit user confirmation. |
| `figma-create-design-system-rules` | `skills/figma-create-design-system-rules`, `skills/figma-capture-design-system` | Aligned, but split locally into rule drafting vs. capture of existing human/code-backed rules. |
| `figma-create-new-file` | `skills/figma-create-new-file` | Utility only. Keep low priority until workflows require a new target file. |
| `figma-implement-design` | `skills/figma-implement-design`, `skills/figma-export-slices`, `skills/figma-verify-implementation` | Aligned, with stricter local gates for exported assets, hidden layers, geometry measurement, provisional states, and implementation verification. |
| `figma-generate-library` | `skills/figma-generate-library` | Aligned as a future code-to-Figma design-system sync path. Local rule: run only after rules are confirmed, never from speculative inferred values. |
| `figma-generate-design` | `skills/figma-generate-design` | Newly aligned. Treat as code/page -> Figma canvas workflow using real design system components, variables, and styles; not a substitute for implementation verification. |
| Community skills | none | Use as references only after an intake check. Do not import a community skill wholesale without mapping it to local source-of-truth, asset, verification, and coordination gates. |

## Local Extensions Beyond Official Skills

The following local skills are not direct official equivalents, but they
remain valuable because they capture project-tested gaps in the generic
workflow:

- `figma-execution-shell`: coordination wrapper for real component cases.
  It enforces source-of-truth, ownership, readiness, closeout, and issue
  sync before lower-level skills run.
- `figma-export-slices`: explicit asset export layer. Official skills say
  to use Figma-provided assets; this repo makes export/import a hard gate
  so implementation does not drift into handwritten replacement geometry.
- `figma-verify-implementation`: post-implementation quality gate. Official
  skills require validation, but this repo formalizes evidence modes,
  reuse gates, asset-source gates, DOM measurement, and severity.
- `figma-capture-design-system`: captures undocumented rules from humans
  or existing code before broad implementation. This keeps existing
  project reality above inferred design rules.
- `figma-ai-implementation-cleanup`: prepares messy files before rules or
  code generation.
- `figma-sketch-to-system-components`: fills missing coverage from
  low-fidelity inputs while respecting existing rules.
- `ui-motion-patterns`: captures lightweight web interaction motion
  standards and copy-adaptable CSS/JS templates. It is intentionally
  downstream of source-of-truth confirmation: motion may enhance a
  confirmed state, but it must not invent canonical component states or
  mask static geometry drift.

## Adopted Official Ideas

1. Skills should route by deliverable:
   - code output -> `figma-implement-design`
   - Figma canvas writes -> `figma-use`
   - composed Figma screen/view from code or description ->
     `figma-generate-design`
   - Figma library/foundations from code or rules ->
     `figma-generate-library`
   - Dev Mode component-to-code mapping ->
     `figma-code-connect-components`
   - agent rule files from codebase conventions ->
     `figma-create-design-system-rules`
2. Write-to-canvas workflows should use real Figma components, variables,
   and styles instead of drawing hardcoded primitives when a design system
   exists.
3. Code-to-canvas is useful for reviewing live UI side by side in Figma,
   but it is a review and alignment loop, not proof that implementation
   matches a source Figma node.
4. Code Connect is a maturity layer that helps MCP context include real
   component usage snippets, imports, prop mappings, and custom
   instructions. It should start with core components and stay current as
   code APIs change.
5. `figma-generate-library` should be phased and checkpointed:
   discovery, foundations, file structure, components, integration/QA.
   It should not be treated as a one-shot canvas mutation.

## Local Overrides And Harder Gates

These repo rules intentionally go beyond the official baseline:

- Do not implement design-owned icons or images until the export check is
  complete. Existing exported source assets must be reused as the geometry
  source.
- Exported SVG canvas dimensions are transport metadata, not the final
  rendered-size contract. Measure the asset in its component context.
- Hidden Figma layers are valid alternate-state sources only when
  confirmed as distinct product states, not legacy/noise.
- Provisional states must be explicitly approved before implementation
  and should not remain as a permanent parallel source of truth.
- `0.5px` borders/strokes must not participate in layout when exact
  geometry matters. Use `outline`, `inset box-shadow`, or pinned section
  heights.
- Build success is not enough for visual closeout. Browser DOM geometry
  or another platform-specific rendered measurement must match the Figma
  target for exact-size cases.

## Next-Step Use In This Repo

Near term, this alignment does not require switching workflows. The next
validation case should still be a narrow untouched component or state
slice from the active Figma file.

Medium term, use this alignment to choose the next larger track:

1. **Code-to-canvas review loop:** use `figma-generate-design` to bring a
   running `agentic-browser-ui` page/state back to Figma for side-by-side
   review.
2. **Library sync loop:** use `figma-generate-library` to promote confirmed
   tokens, styles, and component structures from code/rules into a Figma
   library shape.
3. **Code Connect loop:** once the component library is stable and
   publishable, connect core components so MCP context can include real
   usage snippets instead of generic inferred code.

## Community Skill Intake Gate

Before adopting any official community skill, check:

1. What deliverable it owns: code, canvas, library, mapping, verification,
   or documentation.
2. What source of truth it assumes: Figma node, codebase, published
   library, screenshot, user prompt, or generated draft.
3. Whether it respects local gates: asset export, provisional approval,
   hidden-layer confirmation, DOM/platform verification, and issue #13
   coordination.
4. Whether it adds durable workflow knowledge or only duplicates an
   existing local skill.
5. Whether it can be used as a reference without importing its entire
   persona, prompt style, or unchecked assumptions.
