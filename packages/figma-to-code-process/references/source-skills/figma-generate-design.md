# figma-generate-design

## Goal

Create or update composed Figma screens, views, or multi-section
containers from existing code, a running UI, or a structured product
description.

The output is editable Figma canvas content built from real design-system
components, variables, and styles whenever they exist. This skill is the
code-to-canvas complement to `figma-implement-design`; it is not a code
implementation or final verification skill.

## When to use

- A running app/page should be brought back into Figma for design review.
- A codebase page, modal, drawer, sidebar, or multi-section view should be
  assembled in Figma from existing design-system parts.
- A product description should become an editable Figma screen using an
  existing component library.
- The team wants code-first or vibe-coded UI visible on the Figma canvas
  before deciding what to keep, revise, or implement back into code.

## When not to use

- The deliverable is production code from a Figma design — use
  `figma-implement-design`.
- The task is a narrow canvas write or component mutation — use
  `figma-use` directly.
- The task is to create or normalize reusable foundations/components —
  use `figma-generate-library`.
- The task is to validate existing code against a source Figma node — use
  `figma-verify-implementation`.
- The file has no confirmed design-system components, variables, or
  styles and the user expects canonical library output rather than a
  provisional screen draft.

## Required context

- Target Figma file or page to write into.
- Source input:
  - code files for the page/view, or
  - a running local URL / browser surface, or
  - a structured screen description.
- Available design-system context:
  - existing Figma screens using the same system, or
  - published components, variables, and styles, or
  - a reviewed rule set from `figma-create-design-system-rules` or
    `figma-capture-design-system`.
- Tech-stack profile when the source comes from code.

## Inputs

- Figma file URL, file key, page name, or target frame.
- Source page/view path, local URL, screenshot/capture, or structured
  description.
- Optional: component map, token map, or existing screen reference to
  inspect before building.

## Outputs

- New or updated editable Figma screen/view composed from reusable
  components and variables where possible.
- Notes listing which sections used real design-system instances vs.
  provisional primitives.
- Source mapping notes from code sections to Figma sections.
- Follow-up decisions needed before the screen can become canonical.

## Workflow

1. Confirm the deliverable is a Figma canvas output, not implementation
   code or post-implementation verification.
2. Understand the source view before writing:
   - read relevant code files when source is code
   - identify page sections and reusable components
   - note images, media, or remote assets that may need special handling
3. Inspect existing Figma content before creating anything:
   - prefer existing screens in the same file as the component map
   - discover published components, variables, and styles only after
     checking whether local examples already provide the mapping
4. Build a section plan that maps each source section to:
   - a design-system component instance
   - a variable/style binding
   - a provisional primitive only when no reusable component exists
5. If the source is a web app that can be rendered, use a live capture or
   screenshot as a layout reference for proportions, spacing, and images.
   Treat that capture as reference material, not as the final component
   structure.
6. Load `figma-use` before any canvas write. Create the wrapper frame
   first, then add sections incrementally inside it. Do not create
   top-level orphan sections and reparent them later.
7. Build one section at a time. After each write, verify with metadata or
   screenshot before continuing.
8. Replace hardcoded primitives with component instances, variables, and
   styles whenever a reliable design-system match exists.
9. Mark unresolved or guessed sections as provisional. Do not silently
   promote the generated screen into the canonical product source of
   truth.
10. Hand the Figma output back for review and list any follow-up design
    or implementation decisions.

## Clarification policy

Ask before proceeding when:
- The target Figma file or page is ambiguous.
- The source view has multiple routes, breakpoints, or states and the
  user has not selected which one to capture or assemble.
- A reusable component match is unclear or several components could serve
  the same role.
- The generated screen would introduce new canonical component states or
  token names.
- The source contains remote images or media and the available capture
  path is unclear.

Do not ask when:
- The target file, source view, and reusable component mapping are clear.
- A section is clearly provisional and will be labeled as such.

## Gotchas

- Do not draw hardcoded rectangles, colors, and text styles when real
  design-system components, variables, or styles are available.
- Do not confuse code-to-canvas review with implementation verification.
  A screen captured from running code is useful for design alignment, but
  it does not prove that code matches an original source Figma node.
- Do not use generated/captured frames as the final system source without
  human review. They are review artifacts until confirmed.
- Do not mutate formal product artboards with workflow-only experiments.
  Put exploratory output in a clearly labeled generated or provisional
  area unless the user explicitly asks to update the canonical screen.
- Do not rely only on local variables. If local variable discovery is
  empty, check linked libraries before concluding that no variables exist.
- Do not batch a whole page into one large canvas write. Incremental
  section writes are easier to verify and recover.

## Verification

- The output is editable Figma content, not a flattened screenshot.
- Reusable components, variables, and styles were used wherever reliable
  matches existed.
- Provisional primitives are labeled and listed in the closeout notes.
- The generated view visually corresponds to the source page or
  description at the selected state/breakpoint.
- Metadata or screenshots confirm each major section landed in the
  intended wrapper.
- The closeout distinguishes review artifacts from canonical design
  source-of-truth updates.
