# Skills

Each skill has its own folder so we can refine, version, and share it
independently later.

## How to read this list

For each skill:

- `Role`: the place it occupies in the workflow
- `Scope`: what it is expected to do well
- `Not for`: what should be handled by a different skill

## Foundation skills

### `figma`

- `Role`: base read layer for Figma
- `Scope`: fetch design context, screenshots, variables, metadata, and
  node-level references for downstream skills
- `Not for`: writing to canvas, restructuring files, or modifying nodes

### `figma-use`

- `Role`: base write layer for Figma
- `Scope`: execute scoped canvas edits through the Figma Plugin API,
  including creating, editing, organizing, and normalizing nodes
- `Not for`: read-only inspection when no write is needed, or direct code
  implementation output

## Core delivery skills

### `figma-execution-shell`

- `Role`: workflow protocol wrapper for real component cases
- `Scope`: load context, resolve source of truth, enforce readiness
  gates, route to the right downstream skills, and standardize closeout
- `Not for`: replacing lower-level implementation or verification
  skills, or duplicating existing rule content

### `figma-capture-design-system`

- `Role`: capture existing team knowledge before implementation
- `Scope`: interview the team, extract undocumented rules, and turn them
  into explicit platform-aware implementation guidance
- `Not for`: inferring a system only from raw design when team rules
  already exist and can be confirmed directly

### `figma-ai-implementation-cleanup`

- `Role`: prepare messy design files for implementation
- `Scope`: reduce noise, isolate active frames, improve naming/grouping,
  and remove ambiguity that hurts later rule extraction or coding
- `Not for`: redefining the product, inventing new system rules, or
  replacing verified specs

### `figma-create-design-system-rules`

- `Role`: draft or extend implementation rules
- `Scope`: infer missing layout, token, typography, spacing, and
  component rules when an adequate spec does not yet exist, and identify
  which confirmed parts are candidates for `Variables` or reusable
  `样式`
- `Not for`: overriding a strong existing design system or finalizing
  rules without human review

### `figma-implement-design`

- `Role`: design-to-code execution layer
- `Scope`: translate Figma design context plus confirmed rules into code
  for the declared target platform and framework
- `Not for`: deciding the source of truth, cleaning messy files, or
  validating implementation after the fact

### `figma-verify-implementation`

- `Role`: post-implementation quality gate
- `Scope`: compare built UI with the intended Figma target, classify
  mismatches, and feed findings back into code or skill gotchas
- `Not for`: initial implementation, broad design-system inference, or
  free-form visual exploration

## System linkage and infrastructure skills

### `figma-code-connect-components`

- `Role`: map design components to code components
- `Scope`: connect repeated Figma components to real implementation
  components when the target stack supports Code Connect
- `Not for`: general design-to-code conversion when no component mapping
  exists yet

### `figma-generate-library`

- `Role`: design system library builder
- `Scope`: build or update variables, styles, components, variants, and
  library structure in Figma from a reviewed system definition
- `Not for`: one-off screen implementation or quick cleanup of a single
  draft

### `figma-export-slices`

- `Role`: asset export layer
- `Scope`: export slices and image/vector assets using platform-aware
  density and format rules, with icon resources defaulting to exported
  `svg` where possible
- `Not for`: deciding what the design system should be or implementing UI
  code, but it should be invoked when implementation depends on real
  design-owned assets

## Gap-filling and acceleration skills

### `figma-sketch-to-system-components`

- `Role`: fill missing coverage from low-fidelity inputs
- `Scope`: expand sketches or rough drafts into components that stay
  inside the established system
- `Not for`: redefining an existing visual language or bypassing
  confirmed system rules

### `figma-generate-design`

- `Role`: code-to-Figma or structure-to-Figma generation
- `Scope`: create or update composed Figma screens, views, modals,
  sidebars, or multi-section containers from existing code, running UI,
  or structured descriptions by reusing real components, variables, and
  styles where possible
- `Not for`: final code implementation, canonical library generation, or
  verifying implementation quality against a source Figma node

### `figma-create-new-file`

- `Role`: setup utility
- `Scope`: create a blank Figma or FigJam file so downstream workflows
  have a target workspace
- `Not for`: any design-system reasoning, implementation, or validation

### `ui-motion-patterns`

- `Role`: web interaction motion rule and template layer
- `Scope`: adapt lightweight CSS/JavaScript motion patterns for tabs,
  dropdowns, modals, panels, cards, badges, icon/text/number swaps, and
  page transitions after the relevant state source is confirmed
- `Not for`: static design implementation, unapproved interaction-state
  invention, non-web platform motion, or complex timelines/gestures that
  justify a dedicated animation library

## Workflow shorthand

- Read layer: `figma`
- Write layer: `figma-use`
- Rule capture: `figma-capture-design-system`
- Rule drafting: `figma-create-design-system-rules`
- Cleanup: `figma-ai-implementation-cleanup`
- Implementation: `figma-implement-design`
- Verification: `figma-verify-implementation`
- Component mapping: `figma-code-connect-components`
- Library building: `figma-generate-library`
- Asset export: `figma-export-slices`
- Gap-filling: `figma-sketch-to-system-components`
- Screen generation: `figma-generate-design`
- Web motion templates: `ui-motion-patterns`
- Workspace setup: `figma-create-new-file`

## Official Figma Skill Alignment

The current alignment with official Figma MCP skills is tracked in
`inventory/official-skills-alignment.md`.

Treat official skills as the upstream boundary reference, but preserve
local stricter gates when validated cases have proven they are needed:
asset export-first, provisional-state approval, hidden-layer product-state
confirmation, Code Connect maturity checks, and platform/rendered
verification before closeout.
