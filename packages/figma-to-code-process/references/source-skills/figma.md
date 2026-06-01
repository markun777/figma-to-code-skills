# figma

## Goal

Fetch design context, screenshots, variables, metadata, and assets from a
Figma file. Use this skill whenever a workflow needs authoritative design
information before generating or verifying code.

## When to use

- A workflow needs design context grounded in a real Figma node.
- Another skill needs screenshots, metadata, variables, or node details as
  input.
- Implementation must be based on actual Figma content, not guesswork.

## When not to use

- The task requires writing or restructuring the Figma file — use
  `figma-use` instead.
- The task is specifically about creating or editing nodes, pages, or
  variables on the canvas.

## Required context

- A Figma file key, URL, or node id.
- A clear goal for the read operation (what downstream step will consume
  the result).

## Inputs

- Figma URL, file key, or node id.
- Optional: project context or tech-stack profile when the read will
  directly support implementation.

## Outputs

- Design context (layout, properties, component structure).
- Screenshots of the target node or frame.
- Variable definitions (colors, spacing, typography tokens).
- Metadata and asset download references.

## Workflow

1. Parse the Figma URL or reference to extract `fileKey` and `nodeId`.
2. If `nodeId` is missing or the reference is page-level (plain file key
   or broad file URL), call `get_metadata` on the root or page first to
   inspect the tree and identify the correct target node.
3. Call `get_design_context` with the resolved `fileKey` and `nodeId`.
   This is the primary tool — it returns code hints, a screenshot, and
   contextual metadata in one call.
4. If the result is still too large or ambiguous, call `get_metadata` to
   narrow further, then re-call `get_design_context` on the specific node.
5. Call `get_variable_defs` only when token values are needed for
   implementation or verification.
6. Call `get_screenshot` only when a visual check is needed and
   `get_design_context` did not already return a screenshot.
7. Pass the collected context to the downstream skill (implement, verify,
   capture-design-system, etc.).

## Clarification policy

Ask before proceeding when:
- The URL or reference points to a page root or large frame with many
  candidate components — ask which specific component or frame to target.
- Multiple frames share a similar name and the task does not specify which
  one — ask the user to confirm the correct node.

Do not ask when:
- A single unambiguous node id is provided.
- The task goal makes the target obvious (e.g. "implement the login card"
  and there is only one login card in the file).

## Gotchas

- `get_metadata` returns structure only (ids, names, positions). It does
  not return design tokens or code hints. Do not use it as a substitute
  for `get_design_context`.
- A raw screenshot alone is not the full source of truth. If
  `get_design_context` returns variable references or code hints, use
  those — they are more precise than pixel inspection.
- Do not read the entire file when a specific node is enough. Large reads
  waste context and slow down the workflow. For broad references, narrow
  to the correct page before calling `get_metadata` on the root — root
  reads on large files return noisy results fast.
- Node ids in URLs use `-` as separator (e.g. `1-2`). Convert to `:` when
  passing to tools (e.g. `1:2`).
- `get_design_context` may return Code Connect snippets if the file has
  Code Connect set up. Treat those as the authoritative component
  reference, not the raw generated code.
- When reading a component set, enumerate all variant properties before
  starting implementation. If a property value changes child structure
  (different icon, background presence, divider, etc.), it drives a
  structural branch — not a visual tweak. Missing one axis means an entire
  rendering path goes unimplemented.
- Image URLs returned in `get_design_context` responses are temporary Figma
  CDN signed links. Do not pass them to the implementation as asset sources.
  Export the asset to the repository first.

## Verification

- The fetched node clearly matches the intended frame or component (confirm
  via screenshot or name).
- The result contains enough structure for the downstream task — layout,
  tokens, or component references as needed.
- No unnecessary sibling nodes or full-page reads were included.
