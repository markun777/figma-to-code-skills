# figma-use

## Goal

Execute write operations inside a Figma file — create, edit, organize, and
normalize canvas content. Use this skill whenever a workflow needs to
modify the Figma file, not just read from it.

## When to use

- A workflow needs to create or edit pages, frames, components, or
  variables in the Figma canvas.
- Cleanup or normalization must happen inside the Figma file (e.g.
  renaming layers, fixing auto-layout, applying tokens).
- A higher-level skill (generate-design, implement-design, etc.) needs
  structured canvas writes as a sub-step.

## When not to use

- The task only needs read-only design context — use `figma` instead.
- The user wants code output without changing the Figma file.

## Required context

- A Figma file key or URL.
- A clear write intent (what to create, edit, or normalize).
- The target node id, page name, or frame reference when the write is
  scoped to a specific location.

## Inputs

- Figma file key or URL.
- Node ids or page targets when the write is not at the root level.
- Description of the desired write operation.
- Optional: tech-stack profile when the write supports platform-specific
  cleanup or organization (e.g. naming conventions tied to a component
  library).

## Outputs

- Modified Figma file structure.
- Created or updated frames, components, pages, variables, or layout
  settings.

## Workflow

1. Identify the exact write target — resolve the node id or page name
   before writing. If the target is ambiguous, call `get_metadata` to
   inspect the tree first.
2. Determine the minimum safe write scope. Prefer scoped edits over
   broad canvas operations.
3. If the write adds a validation-only supplement board, make it
   explicitly provisional and declare the intended landing zone before
   writing:
   - existing component board supplement area
   - standalone validation board on the same page
   - never a formal product page artboard unless the user or team
     explicitly approved that placement
   Prefer the standalone validation board when there is any risk of
   mixing workflow-only material into formal page content. Standalone
   validation boards must sit in clear empty canvas space and must not
   overlap any existing artboard, component board, or validation board.
   Leave a visible safety gap instead of butting boards directly
   together.
4. If the write adds or edits component state cards, default to applying
   the state treatment on the same root control container used by the
   default state. Do not append a new state-only rectangle, wrapper, or
   overlay shape unless the formal source of truth explicitly proves that
   the state is structurally different.
5. Execute the write via `use_figma` with a JavaScript snippet targeting
   the resolved node.
6. Verify the result: call `get_screenshot` or `get_metadata` on the
   affected node to confirm the change landed correctly.
7. Hand the updated node reference or file state to the next workflow
   step.

## Clarification policy

Ask before proceeding when:
- The write could affect multiple candidate nodes with similar names —
  ask the user to confirm the correct target.
- The requested change would alter a shared component or master style
  that other frames depend on — ask whether the intent is to change the
  source or only a local instance.
- The write scope is unclear (e.g. "clean up the file" without a
  specified frame) — ask for a specific target.
- The intended provisional supplement would land inside a formal product
  page artboard rather than a component board or standalone validation
  board — ask whether that exception is actually intended.
- The standalone validation board placement is ambiguous, crowded, or
  likely to overlap an existing artboard or board — ask before placing
  it.
- The proposed state treatment only works by adding a new child shape,
  wrapper, or overlay, and it is unclear whether the formal component
  really changes structure across states.

Do not ask when:
- A single unambiguous node id is provided and the write intent is clear.
- The write is purely additive (creating a new frame or page) with no
  risk of overwriting existing content.

## Gotchas

- `use_figma` executes JavaScript via the Figma Plugin API. Syntax errors
  in the snippet will silently fail or produce partial results — always
  verify after writing.
- `use_figma` does not return a structured execution result. Treat every
  write as fire-and-check: follow it with `get_metadata`,
  `get_design_context`, or another read path to confirm the change
  landed as intended.
- For the font "Inter", the style name is `"Semi Bold"` (with a space),
  not `"SemiBold"`. Wrong font style names cause silent fallback to the
  default weight.
- `figma.currentPage` cannot be set directly. Use
  `await figma.setCurrentPageAsync(page)` to switch pages.
- Component and variable edits are high-impact — they propagate to every
  instance. Confirm scope before editing a master component.
- Do not use write actions when a read-only inspection is enough. Writes
  that touch shared components can break other frames in the file.
- Before creating new components, call `search_design_system` to check
  whether an existing component can be reused via
  `importComponentByKeyAsync`.
- `createNodeFromSvg` wraps the imported SVG in a Frame. In auto-layout
  parents, that new node may also land at the end of the child list.
  Check the resulting wrapper structure and reorder with `insertChild()`
  or equivalent if position matters.
- SVGs that rely on `currentColor` render black when inserted directly
  into Figma because the canvas has no CSS color context. If a
  provisional board or other Figma write needs the final icon color,
  replace `currentColor` with the intended hex value before insertion.
- Do not place workflow-only provisional boards inside a formal product
  page artboard by default. Keep validation material in a clearly
  labeled supplement area or a standalone provisional board on the same
  page.
- Do not treat "outside the artboard" as sufficient placement logic.
  A standalone provisional board still needs its own clear canvas area
  and should not overlap, touch, or visually merge into neighboring
  artboards or boards.
- Do not build state variants by appending ad hoc rectangle layers to a
  control unless the formal component source explicitly proves that the
  state introduces a structural layer. Default, hover, and active should
  normally share the same root container and differ only in container-
  level styling.
- If a provisional supplement grows beyond its parent board, move it into
  a standalone validation board on the same page instead of stretching
  the formal board.
- When validating large components, reflow the board into multiple rows
  before shrinking the component content. Avoid layouts that clip or
  overlap neighboring artboards.

## Verification

- The intended node or page was changed, not a neighboring one (confirm
  via screenshot or metadata check).
- Any new provisional validation board landed in the declared parent
  area rather than inside a formal product page artboard by accident.
- Any standalone provisional board sits in clear empty canvas space with
  a visible buffer and does not overlap any existing artboard or board.
- State cards preserve the same root control structure as the baseline
  unless the formal source explicitly proves a structural state change.
- No unintended broad canvas changes were introduced.
- The edit moved the workflow forward — reduced ambiguity, created the
  required structure, or normalized the target correctly.
