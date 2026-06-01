# figma-verify-implementation

## Goal

Compare implemented UI against the Figma design, annotate mismatches,
classify which differences matter enough to fix, and feed recurring
failure patterns back into the skill set as gotchas.

## When to use

- After an implementation pass — the code exists and can be inspected or
  rendered.
- The team needs an objective comparison instead of visual guessing.
- Recurring drift between design and code should be captured as gotchas
  for future runs.

## When not to use

- Before there is a runnable or inspectable implementation surface — there
  is nothing to compare against yet.
- The design target itself is still unresolved — verify the design first,
  then implement, then verify the implementation.

## Required context

- Tech-stack profile (`target`, `framework`, `verification_surface` — see
  `inventory/tech-stack-profile.md`).
- Design target: the Figma frame or node that was implemented.
- Implementation target: the rendered surface to compare against.
- Evidence mode: full Figma context plus screenshot, screenshot-only, or
  code-review-only. Use this mode to limit the verification status.
- Reuse contract: any existing component, variant, token, or asset the
  implementation claims to reuse.
- Case preflight record for new component slices: component-family card
  or minimum scope note, asset inventory, and stated verification plan.

## Inputs

- Figma frame or node (URL, file key, or node id).
- Built implementation surface:
  - **web**: browser screenshot, local dev server URL, Storybook story, or
    other web preview.
  - **ios**: simulator screenshot or iOS preview surface.
  - **android**: emulator screenshot or Android preview surface.
- Tech-stack profile.
- Optional: project severity rubric for mismatch scoring (e.g. spacing
  delta threshold, color tolerance).
- Relevant implementation files for the rendered target and any reused
  component or variant.

## Outputs

- Annotated mismatch report listing each difference with location and
  description.
- Severity or priority classification for each mismatch:
  - `P1 / blocking`
  - `P2 / significant`
  - `P3 / minor`
  - `intentional`
- Verification status for the case:
  - `coverage-complete`
  - `visual-verification-complete`
  - `partial`
- Implementation feedback: specific changes needed to close each blocking
  or significant mismatch.
- Candidate gotchas: recurring failure patterns worth adding to the
  relevant skill's Gotchas section.

## Workflow

1. Confirm the design target and implementation surface. If either is
   ambiguous, ask before comparing.
   For a new component or component-family slice, also confirm that a
   case preflight record exists. If there is no component-family card or
   minimum scope note, the review may continue, but the case cannot be
   marked closed.
2. Declare the evidence mode before reviewing:
   - `full-visual`: Figma design context plus a design screenshot and a
     real implementation surface are available.
   - `screenshot-only`: only screenshot evidence is available for the
     design. Continue only with an explicit limitation note.
   - `code-review-only`: no reliable rendered comparison is available.
     You may check coverage and obvious structural risks, but you must
     not mark the case `visual-verification-complete`.
3. Fetch the Figma design context:
   - Call `get_design_context` on the target node for layout, tokens, and
     component structure.
   - Call `get_screenshot` to get the reference design image.
4. Collect the implementation screenshot or inspection context using the
   platform-appropriate path (see Inputs).
   - Use the real implementation branch, not a handwritten stand-in built
     only for verification.
   - If the target variant depends on exported assets (especially images
     or media), verify with the real asset rather than a placeholder.
5. Run the component-reuse equivalence gate before visual scoring:
   - List each component, variant, token, and asset the implementation
     claims to reuse.
   - Compare the reused item's design role, dimensions, visible
     structure, state axes, asset slots, and rendered behavior against the
     target node.
   - If a reused item has a different family role or materially different
     structure, classify it as `P1 / blocking` and set the case status to
     `partial`.
   - If a reused item is plausible but missing a required variant, asset,
     or state axis, classify it as `P1 / blocking` until the gap is
     implemented or explicitly deferred.
6. Run the asset-source gate:
   - Confirm every design-owned icon or image uses the exported Figma
     asset or an approved currentColor conversion from that asset.
   - Search new or changed component files for inline `<svg>` blocks and
     handwritten shape paths. Each inline SVG must be traceable to an
     exported asset/currentColor conversion or explicitly approved as a
     code-drawn primitive in the asset inventory.
   - Confirm the exported node granularity matches the rendered intent:
     do not export a wrapper/control frame and then render it as the inner
     glyph, or export an inner glyph and render it as the full control.
   - Confirm the rendered size matches the source node being used. If a
     `24px` wrapper asset contains a `16px` icon, either render the
     wrapper at `24px` or export the inner `16px` icon directly.
   - If the implementation uses handwritten geometry, placeholder media,
     or a similarly named but different asset family, classify it as
     `P1 / blocking` when it changes the visible structure or required
     state, otherwise `P2 / significant`.
   - If the implementation scales an exported wrapper asset down to mimic
     an inner icon, or scales an inner icon up to mimic a wrapper,
     classify it as `P2 / significant`; upgrade to `P1 / blocking` when
     the asset becomes visibly wrong or masks a missing required node.
7. Run the state-geometry gate:
   - Inspect changed component files for state-dependent
     `border`, `border-*`, stroke wrappers, or layout-affecting
     separators.
   - If one state adds a border/stroke and another state removes it,
     classify as `P2 / significant` until equal space is reserved or the
     stroke becomes non-layout-affecting.
   - Upgrade to `P1 / blocking` when the drift changes exact Figma
     dimensions, causes a visible state jump, or affects a compact
     control whose size is part of the source node contract.
8. Compare the two surfaces across these dimensions in order:
   - **Structure**: component hierarchy, nesting, element count.
   - **Spacing**: padding, margin, gap values against token or pixel spec.
   - **Typography**: font family, size, weight, line height, color.
   - **Color**: fills, borders, shadows against token values.
   - **States**: hover, focus, disabled, error, empty — are all required
     states present?
   - **Component behavior**: interactive elements, scroll, overflow.
   - **Media / overlays when present**: image fit, crop, mask, overlay
     controls, and any variant-specific shell differences from text
     versions.
9. Classify each mismatch:
   - **P1 / blocking**: wrong component family, wrong major structure,
     missing required state, missing required asset, wrong breakpoint,
     placeholder masking the real target, or any issue that materially
     changes the user's visible UI.
   - **P2 / significant**: clear layout, spacing, typography, color,
     token, or behavior drift that should be fixed before final closeout.
   - **P3 / minor**: small visual delta or style-system cleanup with low
     user-visible impact.
   - **Intentional**: a known platform-specific deviation (document it).
10. Decide the verification status:
   - `coverage-complete`: all intended variant axes are rendered through
     real implementation branches or explicitly deferred, but a full
     visual check is still outstanding.
   - `visual-verification-complete`: the rendered implementation has been
     visually checked against the target node in `full-visual` evidence
     mode and no `P1 / blocking` or `P2 / significant` mismatches remain.
   - `partial`: required axes are still missing, a placeholder is still
     masking the real target, a reuse/asset gate failed, or `P1 /
     blocking` / `P2 / significant` mismatches are still open.
11. Produce the mismatch report. For each `P1 / blocking` or `P2 /
    significant` item, include the specific fix needed.
12. Identify any recurring failure patterns across this and prior runs.
   For each pattern, propose a gotcha entry for the relevant skill's
   README.

## Clarification policy

Ask before proceeding when:
- The implementation surface does not clearly correspond to the target
  design (e.g. wrong breakpoint, wrong state, wrong platform build).
- A new component slice has no component-family card or minimum scope
  note, and the team expects the review to close the case.
- A component is marked as reused, but its role, dimensions, state axes,
  or asset slots do not clearly match the target node.
- A difference may be intentional because of platform-specific conventions
  (e.g. iOS safe area insets, Android status bar handling) — ask whether
  to classify it as intentional before marking it as a mismatch.
- The implementation includes interaction states or affordances that are
  not present in the formal component board, and it is unclear whether
  they were explicitly approved as product-layer behavior — ask before
  classifying them as mismatches.
- The severity rubric is unclear and the project has not defined
  acceptable tolerances — ask what threshold separates minor from
  significant.
- The case is about to be marked as visually verified, but the current
  surface still uses placeholders, hand-built stand-ins, or otherwise
  avoids the real implementation branch.
- Changed files contain inline SVG or hand-drawn icon geometry that is
  not traceable to the asset inventory.
- State variants add/remove layout-affecting border or stroke treatment,
  and the correct geometry-safe pattern is unclear.
- The design can only be reviewed from screenshots and the user expects
  exact token, node, or hidden-state verification.

Do not ask when:
- The mismatch is clearly unintentional and the correct value is
  specified in the design or token system.
- The implementation reuses a visibly different component family from the
  target node. Mark it `P1 / blocking`; do not treat that as a design
  judgment call.
- The difference is structural — classify it based on impact: blocking if
  it affects reusability, state correctness, layout stability, or
  behavior; significant if it is a meaningful deviation without functional
  impact; intentional if it is a known platform-specific adaptation.

## Gotchas

- Do not treat every visual delta as equally important. A 1px spacing
  difference is not the same as a missing interactive state.
- Do not ignore structural mismatches just because the screenshot looks
  close. A wrong component hierarchy will break under real content and
  state changes.
- Do not accept a reuse claim based on a similar name. A reused component
  must match the target node's role, dimensions, structure, states, and
  asset slots before it can count as covered.
- Do not mark code-review-only results as `visual-verification-complete`.
  Without a real rendered surface checked against the design target, the
  highest status is `coverage-complete`.
- Screenshot-only review is allowed only as a limited review. State that
  exact tokens, node structure, and hidden states were not verified.
- Do not compare against the wrong state, breakpoint, or platform target.
  Verify the correct build variant before starting.
- Platform-specific deviations (safe areas, status bars, density
  differences) are not bugs — classify them as intentional and document
  them.
- Token mismatches (wrong color value, wrong spacing unit) are always at
  least significant — they indicate the implementation is not using the
  design system correctly.
- Enumerate all variant axes from the component set before building the
  verification surface. A grid that covers only a subset of axes will miss
  entire classes of rendering bugs. A missing axis is itself a blocking
  mismatch.
- A variant axis is not actually covered until the verification surface
  drives the real implementation branch for that axis. Listing the axis
  in notes or drawing a lookalike verification card is not enough.
- Verify cards must render the real implementation path. Handwritten
  stand-ins can help explain intent, but they do not prove the component
  actually matches Figma.
- Media or image variants should be checked with the real exported asset,
  not a placeholder. Otherwise fit, crop, masking, or overlay-control
  bugs will stay hidden until later.
- Do not assume a media/image variant can reuse the same spacing shell as
  a text variant. Re-check outer padding, internal wrappers, and overlay
  controls independently for the media branch.
- Overlay controls (for example a circular close button over an image) are
  easy to miss if verification only checks structure or text-based
  variants first. Inspect image/media branches explicitly.
- Stateful stroke or border treatments that change box geometry between
  states (e.g. adding a border only in selected state) are a significant
  mismatch. The default state must pre-allocate the same stroke space, or
  the implementation must use a non-layout-affecting layer such as inset
  shadow or outline.
- Do not approve icon sizing just because the exported SVG file "looks"
  correct in isolation. Verify the icon against its in-component geometry
  in Figma. If the implementation sized the icon from raw asset canvas
  dimensions instead of the component's icon frame and glyph bounds,
  classify that as a significant mismatch.
- Do not confuse wrapper assets with glyph assets. If Figma shows a
  `24px` action wrapper containing a `16px` icon, export or render the
  correct layer for the implementation slot instead of scaling the wrong
  layer to fit.
- Do not hand-draw small divider or stroke assets just because they look
  simple. Export/check the real Figma node first; many divider assets use
  a larger canvas with a shorter centered stroke.
- Do not let new component slices bypass the preflight record. If there
  is no component-family card or minimum scope note, report the missing
  process evidence even when the code itself builds.
- Do not approve inline SVG in changed component files without tracing it
  to an exported asset/currentColor conversion or an explicit approved
  code-drawn primitive. "Small icon" is not an exception to the asset
  source gate.
- Do not rely on visual inspection alone for selected/normal border
  changes. Review the class/state branches for border/stroke asymmetry and
  verify DOM geometry when exact dimensions matter.
- When creating verify cards, default the container width to the Figma
  source component's original width. For adaptive or flex components,
  treat the Figma width as the reference lower bound, then propose a
  suggested adaptive range (e.g. min / max) and let the user confirm
  before adding responsive test cases. Never set the container narrower
  than the component's natural expanded width — doing so compresses flex
  children and makes the verify surface misleading.
- **Frame-preserving icon normalization**: when verifying icon sizing,
  check whether the exported SVG was taken from the icon frame node or
  the inner path/union. An inner-path export gives a viewBox matching
  the path bounds; rendering it at the frame size stretches the visible
  glyph to fill the slot. If the inner vector was exported directly,
  confirm the visible glyph bounding box matches the Figma inset geometry
  rather than the full slot. Verify: icon slot size matches the intended
  frame dimensions, and the visible glyph bounding box matches the inset.
- **currentColor requires an explicit color**: SVG components using
  `currentColor` inherit from CSS `color`. If no explicit color is set
  on the component (e.g. a `text-*` class in Tailwind, or an inline
  `color` style), the color falls back to black regardless of the Figma
  source. Always verify that the rendered fill/stroke color matches the
  Figma source, not just that the icon renders.
- **Outline not border for exact-size surfaces**: `border` participates
  in layout under `border-box` sizing and shifts both root height and
  inner content width. For components with a fixed Figma frame size,
  use `outline` or `inset box-shadow` instead. Verify: root DOM size
  matches Figma frame exactly; inner content width equals frame width
  minus padding (not minus padding minus border).
- **Progress bar compression in fixed-height flex columns**: in a
  fixed-height flex column, a progress bar without `shrink-0` will be
  compressed by sibling elements. Verify: progress bar height matches
  Figma spec (e.g. 8px); label row has a fixed height and `shrink-0`
  so it does not grow and squeeze the bar.

## Verification

- The comparison uses the correct platform path and the correct build
  variant.
- The verification surface uses the real implementation branch and the
  real exported assets for the target variant where applicable.
- New component slices have a component-family card or minimum scope note,
  or the missing record is listed as a process blocker before closeout.
- Every claimed component reuse has passed the equivalence gate: role,
  dimensions, structure, states, assets, and rendered behavior match the
  target node or the difference is explicitly deferred.
- Every design-owned asset has passed the asset-source gate; no
  handwritten or similarly named substitute is masking the target.
- Changed component files have no unclassified inline SVG or handwritten
  icon geometry.
- State variants preserve geometry across border/stroke changes or use
  non-layout-affecting treatments.
- Exported asset node granularity matches the implementation slot:
  wrapper assets are rendered as wrappers, glyph assets as glyphs, and
  divider/stroke assets preserve their source canvas and visible stroke
  geometry.
- Mismatches are prioritized by severity, not dumped as an undifferentiated
  list.
- The final result clearly distinguishes `coverage-complete` from
  `visual-verification-complete`.
- `visual-verification-complete` is only used for `full-visual` evidence
  mode with no open `P1 / blocking` or `P2 / significant` findings.
- Intentional platform deviations are documented, not silently ignored.
- Recurring failure patterns are identified and proposed as gotcha entries
  for the relevant skill.
