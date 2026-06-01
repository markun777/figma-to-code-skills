# figma-execution-shell

## Goal

Provide a stable execution shell for real Figma-to-code component cases.
Use it to force the same checkpoint order across sessions and agents:
load context, resolve source of truth, pass readiness gates, route to the
right implementation skills, verify, and close out. This skill is a
workflow wrapper — it should point to existing rules and skills instead
of duplicating them.

## When to use

- A real component case is starting and the team wants a consistent
  delivery protocol before implementation begins.
- Multiple agents or sessions may touch the same case and need the same
  readiness gates and closeout shape.
- The case should be run through existing Figma read, write,
  implementation, export, and verification skills in a fixed order.
- A new standalone product repo wants to reuse this workflow for product
  restoration. In that case, first apply the product bootstrap/preflight
  package from `inventory/product-restoration-preflight.md` and
  `templates/product-restoration/`, then run board-level implementation
  inside the product repo.

## When not to use

- The task is only one narrow sub-step already covered by a lower-level
  skill (for example: just export slices, just clean a Figma board, or
  just verify an implementation).
- The work is still pure repo maintenance with no active component case.
- The team only wants to update one existing rule or one gotcha, not run
  a full component workflow.

## Required context

- Shared coordination state:
  - `coordination/INDEX.md`
  - `coordination/WORKING-MEMORY.md`
  - issue `#13`
- Tech-stack profile (`target`, `framework`, `token_format`,
  `verification_surface` when relevant).
- Active component target: node id, section id, or clearly named design
  target.
- Codebase target repo and any existing implementation surface if one
  exists.
- For standalone product restoration, the target product repo's local
  preflight artifacts:
  - `docs/FIGMA_BOARD_STATE_MAP.md`
  - `docs/LAYOUT_CONSTANTS.md`
  - `docs/TOKEN_SNAPSHOT.md`
  - `docs/ASSET_MANIFEST.md`
  - `docs/INTERACTION_CONTRACT.md`
  - `docs/PROGRESS.md`

## Inputs

- Component case identifier (component name, node id, or Figma URL).
- Current design status:
  - formal component board
  - approved provisional states
  - known missing states or gaps
- Code repo context and current ownership / PR status.
- Optional: prior review findings or deferred non-blockers from earlier
  runs.

## Outputs

- A checkpointed execution plan for the current case.
- The chosen downstream skill path for each phase.
- Explicit blockers when the case is not ready to implement.
- A standardized closeout summary covering:
  - actions taken
  - blockers cleared
  - deferred non-blockers
  - next step
  - whether the case is only coverage-complete or truly
    visual-verification-complete
  - whether any recurring failure should be promoted into skill gotchas

## Workflow

1. Load shared context before touching the case:
   - Read `coordination/INDEX.md`, `coordination/WORKING-MEMORY.md`, and
     recent issue `#13` updates.
   - Check `git status` and `gh pr list` so ownership is visible before
     claiming the case.
   - Confirm whether the case is new, already in progress, or being
     resumed.
   - If the work is a new product restoration, confirm the product lives
     in its own repo. Do not place active product implementation under
     `figma-to-code-skills` as an untracked subdirectory. Copy/adapt
     `templates/product-restoration/` into the product repo and complete
     the product preflight artifacts before coding.
2. Resolve the source of truth in this order:
   - confirmed project spec or confirmed workflow rules
   - approved formal Figma component board
   - explicitly approved provisional validation states
   - if the above are insufficient, stop and route to
     `figma-capture-design-system` or
     `figma-create-design-system-rules` before implementation;
     when project rules are implicit in existing implementation code
     rather than documented, use the **code-backed capture mode** of
     `figma-capture-design-system`
3. Run readiness gates for the case:
   - for product restoration, the five product preflight artifacts exist
     before UI code starts: Figma board/state map, layout constants,
     token snapshot, asset manifest, and interaction contract. If any is
     missing, stop and create it first in the product repo.
   - for product restoration, implementation proceeds board by board from
     the board/state map. Do not start by inventing a generally
     reasonable product UI; each state needs a Figma node or approved
     provisional source.
   - tech-stack profile is complete enough to shape implementation
   - component target and variant axes are identified
   - for a new component or new component-family slice, a `Component
     Family Definition` card exists, or a minimum scope note is recorded
     in coordination before implementation starts. The minimum scope note
     must name the source Figma node(s), component boundary, intended
     states, asset inventory, verification surface, and explicit
     exclusions. Do not begin code from only a component name or a loose
     candidate note.
   - every claimed variant axis is mapped to an explicit implementation
     branch, prop, structural fork, or verification case — not just
     mentioned in notes
   - required states are either already present or explicitly approved
   - if the case needs provisional validation states, there is an
     explicit placement plan for where those cards will live; workflow-
     only supplements should default to a standalone or clearly bounded
     validation board, not a formal product page artboard
   - if the case uses a standalone validation board, its placement is
     explicitly non-overlapping and leaves clear canvas separation from
     every existing artboard or board
   - if the case adds provisional state cards, each state is attached to
     the same root control container as the baseline unless the formal
     source explicitly proves a structural state change
   - if the case is proposing a new component or component set, every
     family boundary and state axis needed for that promotion is already
     confirmed; otherwise the work stays provisional
   - if the case depends on approved provisional states because the
     formal component area was incomplete, there is an explicit plan for
     whether those states stay temporary or are promoted back into the
     formal component area after validation
   - asset needs are known, recorded as an asset inventory, and export is
     scheduled before code if real design-owned assets are required. The
     inventory must classify each icon/image as `existing export`,
     `new export required`, `no asset needed`, or `approved code-drawn
     primitive`. A design-owned icon cannot be left as an unclassified
     inline SVG.
   - when exporting icon assets, prefer the icon frame node over the
     inner path/union when a padded frame exists. If exporting the inner
     vector directly, record why that node is canonical and verify the
     visible glyph bounding box matches the Figma inset geometry. When
     a frame-preserving normalization is needed, create an SVG with the
     frame's canvas size and translate the inner path to its inset position.
   - SVG components using `currentColor` require an explicit color applied
     via CSS (e.g. a `text-*` class in Tailwind, or an inline `color`
     style). Without it, the color falls back to black regardless of the
     Figma source. Always set the source color explicitly.
   - state geometry risk has been scanned before implementation: if any
     state uses `border`, `border-*`, or another layout-affecting stroke,
     either all states reserve the same stroke space or the plan uses
     `outline`, `inset box-shadow`, or pinned dimensions. Do not defer
     known 0.5px state-border drift to visual review. For components with
     a fixed Figma frame size, prefer `outline` over `border` to preserve
     exact root dimensions and inner content width.
   - verification surface is not only known, but scoped to cover every
     axis the team intends to claim as verified; if coverage is partial,
     mark the case implementation-ready only, not verification-ready
   - if an existing component case expands scope by adding a new axis,
     optional control, asset, or verification surface, rerun the same
     preflight checks for the expansion before coding. Treat the
     expansion as a small follow-up case, not as a free patch on the
     already-closed component.
   - if the case is expected to close in the same run, there is a real
     plan to visually compare the rendered implementation against the
     target node; axis coverage alone is not enough to claim
     verification-complete
   - for product restoration handoff, a dev server is not enough. There
     must be a build plus production preview/package asset-path check
     before claiming production-preview-verified.
   - for product restoration handoff, temporary demo/test/verification
     UI must be removed from the production-facing product before
     closeout. Preserve verification evidence in docs or PR notes; do
     not delete real automated tests or build scripts unless the user
     explicitly confirms they are obsolete.
4. Route the case to the minimum required downstream skills:
   - use `figma` for read-only design inspection
   - use `figma-ai-implementation-cleanup` if the design file is too
     noisy to implement against safely
   - use `figma-use` for scoped writes such as provisional validation
     boards or canvas normalization
   - use `figma-export-slices` when real assets are needed
   - use `figma-implement-design` for code implementation
   - use `figma-verify-implementation` for post-implementation review
5. Keep the shell active during execution:
   - after each major step, restate whether the case is still blocked,
     implementation-ready, verification-ready, or closeout-ready
   - do not skip a blocked checkpoint just because another downstream
     skill can technically run
   - do not upgrade a case to verification-ready until the visible
     verification surface can explicitly exercise all claimed axes, or
     the uncovered axes are clearly marked as deferred
   - do not upgrade a case from coverage-complete to
     visual-verification-complete until the real rendered implementation
     has been checked against the target Figma node for the main fidelity
     dimensions (structure, spacing, typography, color, asset fit, and
     overlay controls when present)
6. Close out the case in a fixed shape:
   - summarize what was done and against which design source
   - record blocking or significant mismatches still open
   - separate deferred non-blockers from true completion blockers
   - if implementation depended on approved provisional states, state
     whether those states have been promoted back into the formal
     component area; if not, record the explicit reason they are still
     temporary
   - state whether the case is implementation-complete, coverage-
     complete, visual-verification-complete, or still partial
   - update `#13` with actions and conclusions
   - update `coordination/WORKING-MEMORY.md` only if the result changes
     stable project memory
   - propose a gotcha update only when the same failure mode looks
     reusable beyond the current component

## Clarification policy

Ask before proceeding when:
- The active component target is ambiguous.
- The case would rely on provisional states that are not explicitly
  approved.
- The case relies on approved provisional states, but there is no clear
  decision about whether they should be promoted back into the formal
  component area after validation.
- The formal component board appears incomplete and the missing detail
  changes implementation shape.
- A new component slice does not yet have a component-family card or
  minimum scope note with source nodes, states, assets, verification
  surface, and exclusions.
- A design-owned asset appears in the source node but has not been
  classified in the asset inventory.
- A state changes visual strokes/borders and the implementation plan does
  not reserve geometry or use non-layout-affecting strokes.
- The case needs provisional validation cards, but their landing zone is
  still unclear or they would fall inside a formal product page artboard
  without explicit approval.
- The proposed standalone validation board still overlaps or crowds
  neighboring artboards or boards, even if it is technically outside the
  target artboard.
- The proposed provisional state card only works by appending a new
  shape, wrapper, or overlay layer and it is unclear whether the formal
  source actually changes structure between states.
- The case wants to promote a new component set, but some family
  boundaries, state axes, or state values are still provisional.
  **This gate applies even when the user explicitly requests promotion.
  A direct instruction to "promote" or "make it a formal component" does
  not bypass the readiness check — confirm that every family boundary and
  state axis is resolved before executing the promotion.**
- A claimed variant axis has no explicit implementation branch or no
  explicit verification case yet, and the team still expects the case to
  count as fully verified.
- The verification surface is missing, but the team expects the case to
  be closed in the same run.
- The team wants to call the case verification-complete, but the current
  evidence only proves axis coverage rather than a real visual check
  against the target node.
- Multiple downstream skill paths are plausible and would produce
  materially different output.

Do not ask when:
- The source of truth is clear and the next downstream skill is obvious.
- A reversible, low-risk routing decision is already implied by the
  existing workflow rules.

## Gotchas

- Do not let this shell become a second rule system. It should point to
  existing rule sources, not restate every asset, state, or verification
  rule inline.
- Do not start implementation just because the design target looks
  understandable. The case must still pass readiness gates.
- Do not treat a rule in a README as sufficient enforcement. New cases
  need explicit preflight evidence: scope/card, asset inventory, state
  geometry scan, and verification plan. If those are missing, the case is
  not ready even if the same rule exists elsewhere.
- Do not hand-code a "simple" icon during an initial implementation pass
  just because the design context is obvious. Unclassified inline SVGs are
  a failed asset gate until proven to be approved code-drawn primitives.
- Do not rely on review to catch state-only borders later. If selected,
  hover, active, or disabled states add/remove `0.5px` borders, the
  execution shell should block implementation until geometry handling is
  planned.
- Do not confuse "variant axes identified" with "variant axes actually
  exercisable." An axis that is only described in prose but cannot be
  driven through component props, structural branches, or verify cases is
  not ready to claim as covered.
- Do not treat "we can verify later" as equivalent to "the case is
  ready to close." Missing verification may be acceptable for progress,
  but it is not a closed state.
- Do not confuse `coverage-complete` with
  `visual-verification-complete`. Rendering every named axis is
  necessary, but it is still not enough if the real implementation has
  not been visually checked against the target node.
- Do not let approved provisional states become a permanent shadow
  system. If the team accepts them as canonical, promotion back into the
  formal component area is part of closeout, not an optional future
  cleanup.
- Do not treat a note-only provisional frame as equivalent to actual
  state coverage. Until the cards themselves exist in the intended
  landing zone, the case is still in clarification or setup, not ready
  for implementation.
- Do not confuse "not inside the artboard" with "placed correctly."
  Standalone validation boards still fail the workflow if they overlap
  other artboards or boards or if they are dropped into crowded canvas
  with no clear separation.
- Do not treat a state overlay layer as proof of a correct state card.
  If hover/active only work by appending a new rectangle or wrapper to
  the default control, the card is still suspect unless the formal
  source explicitly shows that extra structure.
- Do not promote a provisional family decision or proposal-only state
  into a formal component set. Canonical promotion comes after state and
  family confirmation, not before.
- Do not update `coordination/WORKING-MEMORY.md` for every transient
  action. Only write back stable state that a new session would need.
- Do not promote every case-specific compromise into a shared gotcha.
  Only recurring failure patterns belong in skill maintenance.

## Verification

- The shell clearly identified the source of truth before implementation.
- The case passed or failed readiness gates explicitly; nothing important
  was left implicit.
- New component slices have a component-family card or minimum scope note
  before code starts.
- The asset inventory is complete and no design-owned asset remains as an
  unclassified inline SVG or placeholder.
- State-border geometry has been checked before implementation when
  state changes affect strokes/borders.
- Every claimed variant axis is either:
  - explicitly mapped to implementation and verification coverage, or
  - explicitly marked as deferred / not yet verified.
- Any provisional validation layer used by the case was created in the
  intended validation area rather than inside a formal product page
  artboard by default.
- Any standalone validation board used by the case has clear separation
  from every neighboring artboard or board and is not merely shifted a
  few pixels into another crowded area.
- Provisional state cards preserve root structure by default and do not
  rely on ad hoc appended state layers unless a structural state change
  is explicitly proven.
- No new component or component set was treated as canonical while its
  family boundary or state axis was still explicitly provisional.
- If the case used approved provisional states as implementation input,
  closeout makes clear whether those states were promoted back into the
  formal component area or are still temporary for a named reason.
- If the case is being called verified rather than merely covered, the
  real rendered implementation has been visually checked against the
  target node for the main fidelity dimensions.
- Downstream skills were invoked in a sensible order rather than by habit
  or guesswork.
- Closeout separated blockers, deferred non-blockers, and next actions.
- The run produced a reusable protocol shape the next component case can
  follow again.
