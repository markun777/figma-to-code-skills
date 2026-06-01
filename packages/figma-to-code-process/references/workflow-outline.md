# Workflow Outline

## Primary Objective

Given a set of design files with no ready-made spec, no clean design
system, and possible historical clutter, we still want to produce code
with good fidelity and stable implementation quality.

If a project already has a usable spec, design system, or implementation
rules, those should be the default source of truth for delivery.

## Source Of Truth Priority

1. Existing project spec, design system, and implementation rules.
2. Confirmed human edits to any rough rule draft we generate.
3. The current active design frames in Figma.
4. Inferred rules extracted from messy or inconsistent design drafts.

## Platform Profile Priority

Before implementation, export, or verification, we should confirm the
target delivery profile instead of assuming a default platform.

Minimum profile:

- `target`: `web` | `ios` | `android`
- `framework`: for example `react`, `swiftui`, `compose`
- `token_format`: for example `css-vars`, `swift-tokens`,
`compose-tokens`

## Additional Capabilities We Likely Need

### 1. Capture an existing design system into a reusable skill or rule set

This should be part of the workflow.

Reason:

- many teams already have rules, but they are undocumented
- implementation quality improves if those rules are captured before code
generation
- this helps us preserve the principle of "existing spec first"

Suggested role in the workflow:

1. interview the user or team
2. capture the existing rules, tokens, component expectations, and edge
  cases
3. save them into a reusable project skill or editable rule document

### 2. Expand sketches or low-fidelity drafts into design-system components

This is also useful, but it is a secondary capability, not the default
path.

Reason:

- some projects have incomplete design coverage
- a sketch can help define missing states, cards, or sections
- this can accelerate iteration before final code implementation

Constraint:

- it should extend an existing system when one exists
- it should not override the source-of-truth priority above
- it should be used for gap-filling, not for redefining the whole project

### 3. Verify implemented UI against design and annotate differences

This should be part of the workflow, not treated as optional polish.

Reason:

- visual similarity alone is not enough
- structural issues, overrides, and implementation drift need explicit
review
- verification findings can improve both the code and the skill set

## Core Workflow

1. Confirm the target tech-stack profile.
2. Check whether a trusted spec or design-system rule set already
  exists.
3. If yes, use it as the implementation baseline and only use the design
  draft for screen-specific details.
4. If not, intake the design draft.
5. Identify noise vs. reusable patterns.
6. Clean the draft just enough for implementation.
7. Extract a rough implementation spec from the design itself.
8. If the current task is centered on a component family and the family
  boundary is clear enough, produce a `Component Family Definition` card
  as the formal component-scoped rule artifact before implementation.
  Update the same card as definition or verification status changes.
  If the case is a small new slice and a full card would be premature,
  record a minimum scope note before implementation instead. That note
  must include source node(s), component boundary, intended states, asset
  inventory, verification surface, and explicit exclusions.
9. Let a human editor adjust the rough spec or the component-family card.
10. Map the confirmed part of that revised spec into Figma foundations:
  variables for reusable tokens, styles for reusable presentation
   patterns, and only keep low-confidence mappings as provisional.
11. If we add or expand provisional validation states in Figma to cover
  missing product states, get explicit user or team confirmation that the
   provisional cards match the intended behavior before treating them as
   implementation input. Unconfirmed provisional states are candidates, not
   implementation-ready truth. By default, place workflow-only
   provisional cards in a standalone or clearly bounded validation board
   on the same page, not inside a formal product page artboard. A
   standalone validation board must also sit in clear empty canvas space
   with visible separation from every existing artboard or board.
12. Export implementation assets when the design depends on real icons,
  images, or slices. All icon resources should go through the export
   workflow, with `svg` as the default preferred format when feasible.
   Use the asset profile and export workflow rather than replacing them
   with placeholders or hand-drawn substitutes. If the exported source-file
   asset already exists in the repository, implementation must use that
   asset as the geometry source and must not keep or add a handwritten
   replacement icon. Do not assume the exported asset canvas dimensions are
   the final rendered size in code; match the asset's in-component geometry
   from Figma. Name exported assets by their confirmed product role in code,
   not by temporary raw layer names such as `ic_`, `Group 12`, or `Frame 1`.
13. Before implementing stateful components, scan for layout-affecting
  state strokes. If one state adds/removes a border or stroke, reserve the
   same geometry in every state or use `outline`, `inset box-shadow`, or
   pinned dimensions. This is a preflight gate, not only a review gotcha.
14. If the file already contains external variable aliases or mixed
  foundation sources, decide whether to preserve, remap, or bridge
   them before broad component binding begins.
15. Use the revised spec plus design context to implement code for the
  chosen platform.
16. Validate the result against the design using the platform-specific
  verification surface and feed issues back into the
   spec.
17. Record recurring mistakes as gotchas for the relevant skill.

## What The Workflow Must Handle

- messy layer structure
- inconsistent naming
- hidden or legacy frames mixed with active frames
- multiple visual variants without clear component boundaries
- repeated patterns that imply rules but are not documented
- one-off exceptions that should not become standards
- assets that need export naming and implementation mapping
- pre-existing external variable aliases that may conflict with newly
created local foundations

## Key Principle

The system should not assume the design file is already a clean source of
truth.

Instead, it should:

- prefer existing project rules when available
- treat the design file as raw material
- infer a first-pass rule set
- expose that rule set for fast human correction
- turn the confirmed subset into explicit Figma foundations where useful
(`Variables`, `样式`, and later component bindings)
- treat design-owned icons and images as real assets that need export,
not as optional placeholders or hand-coded stand-ins
- treat exported asset dimensions as transport metadata, not as the source
of truth for rendered icon size; verify the icon's actual in-component
geometry before wiring it into code
- decide how local foundations and any pre-existing external aliases
should coexist before broad rebinding
- implement code from the corrected rule set, not directly from the raw
mess whenever possible

## Important Process Question

### Can we create rules from a messy design draft?

Yes, but only as a draft, and only when an authoritative rule set does
not already exist or does not cover the needed scope.

The workflow should support:

1. extracting an initial rule set from the draft
2. allowing direct human edits to that rule set
3. using the edited rule set as the implementation reference

This is important because many real projects do not begin with a proper
design system.

## Decision Rule

- if a valid spec already exists, implement against the spec first
- if the spec is partial, keep the spec as baseline and only infer the
missing parts
- if no spec exists, generate a rough rule set from the design and let a
human revise it
- if rules exist but are undocumented, capture them before broad
implementation work
- if the design is incomplete, sketches or low-fi drafts can be expanded
to fill missing pieces, but they must respect the existing rule set
- if a new component slice has no component-family card yet, record the
minimum scope note before code starts; a loose candidate note is not
enough
- if the platform profile is missing and platform affects the output,
clarify the profile before implementation proceeds

## Clarification Policy

The model should not freely invent product or design intent when key
information is missing.

It should actively confirm with the user when the uncertainty affects:

- component boundaries
- interaction behavior
- which interaction states are actually required for the product when the
current component board does not show them completely
- content hierarchy
- visual rules that may become reusable standards
- implementation choices that could cause rework later
- target platform, framework, or token format when they change the output

It may make small, low-risk assumptions when the missing detail is local
and does not change product meaning, but those assumptions should be easy
to revise.

## Practical Rule

- ask when ambiguity changes meaning
- ask when ambiguity could create the wrong reusable pattern
- ask when a decision would be expensive to undo
- if the product needs hover/focus/pressed/disabled/error/loading or
selected-affordance states that the current component board does not
fully express, confirm the required states first, then decide whether
to add provisional validation states
- common interaction patterns may help propose candidate missing states,
but they are not permission to silently redefine canonical component
rules
- do not ask about every tiny visual detail if a safe local assumption is
enough
- never present guessed intent as confirmed project truth
- never silently default to web when the project target is unknown

## Skill Authoring Guidelines

- encode workflow knowledge, not only tool syntax
- separate foundational tool usage from project-specific standards
- prefer composable smaller skills where it improves reuse
- allow orchestrating skills on top of smaller skills
- add a `gotchas` section when a failure pattern repeats
- revise skills using real project feedback, not only theory

## Skill Implications

- `inventory/official-skills-alignment.md`
Records how local skills map to official Figma MCP skills. Use it as the
boundary reference before adding a new skill or importing a community
skill.
- `figma-ai-implementation-cleanup`
Prepare messy files so later steps have less noise.
- `figma-create-design-system-rules`
Generate a first-pass rule set from the draft and project context,
guided by the target platform profile, then identify which confirmed
parts are ready to become candidate variables and styles. For
component-scoped work with a clear family boundary, emit a `Component
Family Definition` card as the formal first output.
- `figma`
Read design context, screenshots, variables, and metadata.
- `figma-use`
Make structured edits in the Figma file when cleanup or normalization is
needed, including creating standalone validation boards when
supplemental state coverage would otherwise overflow, overlap, or
contaminate formal artboards or neighboring boards.
- `figma-generate-library`
Promote confirmed rules into explicit Figma foundations such as
variables, styles, and later library components — but only after human
confirmation of naming and semantics.
- `figma-code-connect-components`
Link repeated design patterns to real code components once the mapping is
clear enough, but only when Code Connect support matches the target
framework, the Figma components are published to a team library, and the
user or team has approved the proposed code mappings.
- `figma-implement-design`
Produce code from the design plus the corrected rule set for the target
platform and framework.
- `figma-capture-design-system`
Capture implicit team rules and turn them into an explicit reusable
implementation reference, including platform-specific conventions.
- `figma-sketch-to-system-components`
Fill missing components or states from sketches while staying inside the
project's established system.
- `ui-motion-patterns`
Add lightweight web interaction motion only after the relevant state has
an approved source of truth. Use it for reusable CSS/JS templates and
motion verification, not for inventing missing states or covering static
geometry drift.
- `figma-verify-implementation`
Compare built UI against design, classify mismatches, and feed the
findings back into code and rules using the correct verification path
for web, iOS, or Android.
- `figma-generate-design`
Create or update composed Figma screens/views from existing code, running
UI, or structured descriptions by reusing real components, variables, and
styles. Treat generated screens as review artifacts until confirmed, not
as implementation verification or canonical library output.

## Near-Term Deliverables

- a clean description of the messy-design-to-code workflow
- a standard rule-draft format that humans can edit quickly
- a standard tech-stack profile format that all major skills can consume
- a repeatable path from rough rules to candidate `Variables` and
`样式`
- a checklist for deciding whether a visual pattern is a rule or an
exception
- a better boundary between cleanup, rule extraction, and final
implementation
- a clear boundary between "capture existing rules" and "invent missing
UI from sketches"
- a reusable gotcha format for mature skills
