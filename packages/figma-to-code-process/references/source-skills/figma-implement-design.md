# figma-implement-design

## Goal

Turn Figma design context plus confirmed rules into implementation code
for the declared platform and framework. Do not guess the platform — if
the profile is missing and it changes the output shape, ask first.

## When to use

- A target design or component should be translated into production code.
- Implementation must follow both the design and the project rule set.
- The platform profile is known and code output is the goal.

## When not to use

- The main task is still clarifying rules — use
  `figma-create-design-system-rules` first.
- The Figma file is too noisy to implement against — use
  `figma-ai-implementation-cleanup` first.
- The platform profile is missing and it would materially change the
  output shape.

## Required context

- Tech-stack profile (required):
  - `target`: `web` | `ios` | `android`
  - `framework`: e.g. `react`, `vue`, `swiftui`, `uikit`, `compose`
  - `token_format`: e.g. `css-vars`, `tailwind-theme`, `swift-tokens`,
    `compose-tokens`
- Design context: the Figma frame, component, or node to implement.
- Rule source: confirmed project spec or output from
  `figma-create-design-system-rules`.
- For a new component-family slice: an existing `Component Family
  Definition` card, or a minimum scope note that names source nodes,
  component boundary, intended states, asset inventory, verification
  surface, and explicit exclusions.

## Inputs

- Figma frame, component, or node (URL, file key, or node id).
- Project spec or captured rules.
- Tech-stack profile.
- Optional: existing codebase component references or naming conventions.

## Outputs

- Implementation code for the declared platform and framework.
- Mapping notes for major layout or component choices (why a specific
  pattern was chosen).
- Unresolved questions when design meaning is still ambiguous after
  reading the context.

## Workflow

1. Confirm the tech-stack profile. If `target`, `framework`, or
   `token_format` are missing, ask before writing any code.
2. Confirm the rule source. If no confirmed spec exists, ask whether to
   use `figma-create-design-system-rules` first or proceed with
   inferred rules marked as provisional.
3. Read the Figma context using the `figma` skill:
   - `get_design_context` for layout, component structure, and code hints.
   - `get_variable_defs` for token values.
   - Read only the target node — do not pull the entire file.
4. Check the codebase for existing components that match the design
   target. Reuse them rather than generating new code from scratch.
5. If this is a new component-family slice, confirm the case preflight
   exists before coding:
   - source Figma node(s)
   - component boundary and state axes
   - asset inventory
   - verification surface
   - explicit exclusions
   Stop and route back to `figma-execution-shell` or
   `figma-create-design-system-rules` if the case only has a loose
   candidate note.
   Apply the same preflight requirement to follow-up expansions of an
   existing component when the work adds a new axis, optional control,
   design-owned asset, or verification surface. Do not treat a closed
   component's new variant as implementation-ready just because the base
   component already exists.
6. Check whether the design depends on real assets such as icons,
   raster images, or exported slices. If yes, route them through
   `figma-export-slices` (or the equivalent asset-export path) before
   final implementation. Do not replace design-owned assets with generic
   placeholders unless the workflow explicitly marks them as unresolved.
   For icons, default to exported `svg` assets rather than hand-coded
   replicas. If the exported source-file icon already exists in the
   repository, use that asset as the geometry source and remove any
   handwritten replacement for the same icon. Do not size the final icon
   directly from the exported SVG canvas dimensions; also inspect the
   icon's actual geometry in its parent component. Use semantic asset and
   variable names in code rather than copying temporary Figma layer names
   verbatim.
   For compact icon actions such as collapse, add, more, or close,
   record three independent sizes before coding:
   - interactive button/hit area
   - icon frame inside that control
   - exported SVG canvas / actual glyph bounds
   Keep them separate in code. Do not assume the exported asset canvas
   already matches the intended rendered icon size.
7. Run a state-geometry scan before writing state variants. If selected,
   hover, active, disabled, focus, error, or loading states add/remove a
   border or stroke, reserve equal stroke space in every state or use
   `outline`, `inset box-shadow`, or pinned dimensions. Do not implement
   state-only `0.5px` borders as a temporary bridge.
8. Map layout, tokens, and components to platform-appropriate patterns:
   - **web**: flexbox/grid, CSS vars or Tailwind tokens, JSX component
     API.
   - **ios**: SwiftUI stacks/modifiers or UIKit layout, Swift token
     references, Apple platform conventions.
   - **android**: Compose layout or XML, Material token mapping, density
     and adaptive layout rules.
9. Write the implementation. Prefer confirmed rules over inferred ones.
   Mark any inferred choices in comments or mapping notes.
10. If implementation temporarily depends on an approved provisional state
   because the formal component board was incomplete, record that
   dependency and treat promotion back into the formal component area as a
   closeout task rather than a forever-state.
11. Surface unresolved ambiguity explicitly — do not silently pick a
   default for anything that changes the component's behavior or
   structure.

## Clarification policy

Ask before proceeding when:
- The platform profile is missing or incomplete.
- Component boundaries are unclear (e.g. should this be one component or
  two?).
- A new component-family slice has no component card or minimum scope note
  with source nodes, states, asset inventory, verification surface, and
  exclusions.
- Interaction behavior or content hierarchy changes the code shape (e.g.
  a list that could be static or dynamic).
- A design-owned icon/image appears in the target node but the asset
  inventory does not classify it as existing export, new export required,
  no asset needed, or approved code-drawn primitive.
- A state variant changes border/stroke usage and the design or rules do
  not make the geometry handling clear.
- The product appears to need interaction states or affordances that the
  current component board does not explicitly show (e.g. hover-only close
  button, selected affordance, focus treatment). Confirm the required
  states before implementing them by default.
- The implementation would rely on newly added provisional Figma state
  cards rather than an already confirmed component board. Ask whether
  those provisional states are approved before coding against them.
- The implementation would rely on an approved provisional state, but it
  is unclear whether the team wants that state promoted back into the
  formal component board after validation.
- An implementation choice would be expensive to undo (e.g. choosing a
  state management pattern or a layout approach that affects many
  components).

Do not ask when:
- The design context and rules together make the correct choice
  unambiguous.
- The choice is purely cosmetic and reversible.

## Gotchas

- Never silently default to web when the platform is unspecified. Ask.
- Do not output code that ignores the declared framework conventions
  (e.g. writing class-based React when the project uses hooks, or using
  UIKit patterns in a SwiftUI project).
- Do not invent reusable rules during implementation. If a pattern looks
  like it should be a shared rule, flag it for `figma-create-design-system-rules`
  rather than encoding it silently in the output.
- Do not optimize only for pixel similarity. A structurally wrong
  component that looks correct in a screenshot will break under real
  content and state changes.
- Do not start implementation of a design-owned icon or image until the
  export check is complete. If the asset already exists in the repository,
  import it. If it does not exist yet, export it first. Do not leave a
  component implemented with placeholder blocks, improvised SVGs, ad hoc
  CSS shapes, or handwritten replacement geometry as a temporary bridge.
- Do not treat an inline `<svg>` in a new component as harmless because it
  is small or simple. If it represents a design-owned icon, the asset
  inventory must prove it is an exported asset/currentColor conversion, or
  explicitly record it as an approved code-drawn primitive before it can
  ship.
- Do not implement a new component slice from only a Figma node name and a
  quick code draft. The case must have either a component-family card or a
  minimum scope note before code is treated as implementation-ready.
- Code Connect snippets returned by `get_design_context` are the
  authoritative component reference. Use them instead of generating new
  component code from scratch.
- If a component-set property changes child structure across values (different
  icon, background presence, divider existence, etc.), implement it as a
  structural branch — not as a single template with minor prop tweaks. Treating
  structural variants as visual-only differences will produce incomplete or
  broken rendering for the missed variants.
- Do not add product-common interaction affordances by default when the
  formal component set does not include them. Confirm the required states
  first, then implement them as a product-layer behavior or a provisional
  validated state.
- Common interaction patterns may justify proposing a provisional state,
  but they do not justify silently treating that state as canonical.
- Do not leave implementation permanently anchored to an approved
  provisional state if the team has already accepted it as canonical. Use
  the provisional state as a temporary bridge, then promote it back into
  the formal component area and retire or archive the provisional copy.
- Do not assume a state card is correct just because it looks close in a
  screenshot. If hover/active are expressed by appending a new child
  rectangle, wrapper, or overlay layer to the default control, treat that
  as suspect unless the formal component source explicitly shows a
  structural state change.
- Default, hover, and active variants should preserve the same root
  control structure unless the formal component source proves otherwise.
  Prefer changing border, fill, shadow, opacity, or text/icon color on
  the existing container instead of introducing a new state-only layer.
- Do not treat a newly created component set as canonical if its family
  boundary or one of its state axes is still marked provisional or
  proposal-only.
- Hidden Figma layers are a valid source for alternate states. When a frame
  contains layers marked `hidden="true"` that are confirmed to represent a
  distinct product state (e.g. completed vs. running, not legacy or noise),
  call `get_design_context` with the hidden layer's node ID directly to
  extract its styles and copy. Do not reconstruct alternate-state content by
  guessing — use the hidden node as the authoritative source, the same way
  you would use a visible node.
- Figma layer name prefixes such as `【H2】`, `【H3】`, or similar full-width
  bracket markers are design annotation labels in Chinese Figma workflows,
  not visible copy. Strip them before rendering. Align the rendered text to
  the typography spec on the node (font size, weight, line-height), not to
  the label text itself.
- Stateful stroke or border treatments must not change box geometry between
  states. Reserve the same border/stroke space in all states (e.g. transparent
  border in default, colored border in selected), or use a non-layout-affecting
  layer such as inset box-shadow or outline. Geometry drift between states is a
  visible layout jump. This applies equally to static components: when Figma
  specifies exact section heights (e.g. header 58px, footer 64px), use
  `outline` or `box-shadow: inset` for visual strokes rather than `border`,
  so the strokes do not consume layout space. When using `outline` on a
  component that also has `overflow: hidden`, apply the outline to the element
  itself (not a parent), so it is not clipped.
- This stroke rule is a pre-implementation gate, not only a review
  gotcha. Before coding a stateful component, inspect whether any state
  adds/removes borders or strokes. If yes, choose the geometry-safe
  treatment first instead of waiting for visual verification to catch it.
- Figma CDN image URLs returned by design-context tools are temporary signed
  links that expire. Download assets into the repository (or use the
  `figma-export-slices` workflow) immediately during implementation. Do not
  hardcode signed URLs in source code.
- Exported SVG canvas dimensions are not the source of truth for rendered
  icon size. Match the icon's in-component geometry from Figma (button size,
  icon-frame size, and actual glyph bounds), otherwise the asset will often
  render too large, too small, or visually off-center.
- When `get_design_context` returns a CSS transform (e.g. `-rotate-90`) on
  an icon or asset, verify whether the exported SVG already encodes the
  intended orientation before copying the transform. Figma may apply a
  rotation to a component wrapper while the exported asset is already
  rendered in the correct direction. Copying the transform blindly will
  produce a double-rotation and the wrong visual result.
- Do not preserve unresolved Figma layer names as final code identifiers.
  Generic names such as `ic_` or `icon` are acceptable as tracing clues in
  Figma, but code should use a semantic identifier based on the confirmed
  product role. If the role is still unclear, ask or mark it provisional
  instead of pretending the name is settled.
- For compact action icons, do not collapse the button size and icon size
  into one number. A common pattern is `24×24` interactive area with a
  `16×16` glyph. If code renders the icon at the full button size, or if
  the exported SVG still carries a larger padded canvas, the control will
  look visibly too large or too small even when the CSS seems "correct."
- When Figma defines a section header as a label plus an optional action
  button, model those as separate slots in code instead of treating the
  whole row as an undifferentiated heading. This keeps spacing, alignment,
  and optionality stable across similar list or panel headers.
- If Figma gives an explicit row or item width inside a wider parent
  container, preserve that width in implementation unless the confirmed
  spec says the item should stretch. Defaulting to `w-full` will often
  make list items look close in isolation but wrong in the real component.
- When review feedback says an icon button is "the wrong size," debug it
  in this order before changing layout:
  1. measure the outer button box
  2. measure the rendered icon box
  3. inspect the exported SVG canvas / viewBox
  Many size bugs come from asset padding or mismatched icon-frame sizing,
  not from the parent layout.

## Verification

- The output targets the declared platform and framework — not a default
  guess.
- The code respects confirmed rules before inferred ones.
- The result is structurally correct, not only visually similar.
- New component-family slices have a component-family card or minimum
  scope note before implementation.
- The asset inventory has no unclassified design-owned inline SVG,
  placeholder, or hand-drawn replacement.
- State variants do not add/remove layout-affecting strokes without
  reserved geometry or non-layout-affecting treatment.
- State variants preserve the expected root structure and do not rely on
  ad hoc appended state-only layers unless that structural difference was
  explicitly confirmed in Figma.
- Mapping notes explain non-obvious choices.
- Unresolved ambiguity is listed, not hidden.
- If the code depended on an approved provisional state, the output or
  closeout notes state whether that state has already been promoted back
  into the formal component board or is still pending for an explicit
  reason.
