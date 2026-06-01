# figma-code-connect-components

## Goal

Connect published Figma components or component sets to their matching
code implementations through Figma Code Connect, so Dev Mode and MCP
context can reference the real component usage patterns.

This is a mapping and design-code linkage skill. It does not implement
new UI code and does not mutate the Figma canvas directly.

## When to use

- The team has stable, published Figma library components.
- Matching code components already exist or can be clearly identified.
- Developers should be able to navigate from Figma Dev Mode to the code
  component.
- MCP context should include component usage snippets, imports, prop
  mappings, or custom instructions for core components.

## When not to use

- The Figma component is not published to a team library.
- The user is not on a plan that supports Code Connect.
- The component API or Figma variant model is still provisional.
- The task is to generate production code from a design — use
  `figma-implement-design`.
- The task is to build or edit a Figma screen — use `figma-generate-design`
  or `figma-use`.
- The implementation component does not exist yet and the user has not
  approved creating it first.

## Required context

- Figma URL or selected node containing the components to connect.
- Confirmation that the components are published to a team library.
- Codebase access and target framework.
- Candidate code component files and exported component names.
- Approval from the user or team before sending mappings.

## Inputs

- Figma component or component-set node.
- Codebase root.
- Optional: known component path(s), framework label, or existing Code
  Connect conventions.

## Outputs

- Proposed mapping list for user review.
- Accepted Code Connect mappings.
- Summary of connected, skipped, already-connected, and unresolved
  components.

## Workflow

1. Confirm Code Connect is the right deliverable. If the user actually
   wants code or canvas output, route to the matching skill.
2. Confirm prerequisites:
   - Figma component is published to a team library
   - plan/access supports Code Connect
   - URL includes a node id, or desktop selection is available
3. Get Code Connect suggestions for the selected Figma scope. Stop if no
   published components are found or all components are already mapped.
4. Search the codebase for matching component implementations. Compare
   more than names:
   - prop API
   - variant/state axes
   - structure and child slots
   - asset slots
   - default values
5. Present proposed mappings to the user. Include close candidates when
   there is no exact match. Do not guess silently when multiple mappings
   could be valid.
6. Send only the mappings the user approved.
7. Summarize results and record any unresolved components or API gaps.

## Key rule

This skill must check whether Code Connect support matches the target
framework before relying on it.

Current official Figma docs indicate Code Connect CLI support for:

- React and React Native
- HTML-based stacks including Angular and Vue
- SwiftUI
- Jetpack Compose

## Clarification policy

Ask before proceeding when:
- The selected Figma scope contains unpublished components.
- The codebase has multiple plausible matching components.
- A Figma variant/property does not map cleanly to a code prop.
- A component path or exported component name is unclear.
- The mapping would connect to a component with a materially different
  role or structure.

Do not ask when:
- The suggestion is already connected.
- No published components are found. Report the prerequisite issue and
  stop.

## Gotchas

- Code Connect only works for published components or component sets. A
  local draft component can be visually correct and still be unmappable.
- Do not treat name similarity as enough. The code component must match
  role, structure, props, variants, and asset slots.
- Do not create mappings for provisional component APIs. Stabilize the
  component first, then connect it.
- Do not send all suggestions automatically. Present mappings and wait
  for confirmation.
- Code Connect is a maturity layer, not a substitute for implementation
  or verification. A connected component can still render incorrectly if
  its implementation drifted from Figma.

## Verification

- Every created mapping points to an existing code component path and
  exported component name.
- The mapping label matches the actual framework.
- Accepted mappings were confirmed by the user or team.
- Skipped and unresolved components are listed.
- Any mapping gaps are routed back to component implementation or rule
  capture rather than hidden.
