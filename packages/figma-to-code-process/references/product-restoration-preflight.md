# Product Restoration Preflight

Use this workflow when a new product or prototype repo wants to reuse
the Figma-to-code process proven in this repository.

The goal is not to put the product under `figma-to-code-skills`. This
repo is the workflow source, template library, and quality gate. Each
product should have its own repository with copied/adapted instructions,
preflight docs, assets, code, and verification evidence.

## Repository Boundary

- `figma-to-code-skills` is the process/control repo.
- A product implementation lives in its own repo.
- Do not nest active product work under this repo as an untracked
  subdirectory.
- Copy only the templates, gates, and proven gotchas needed by the
  product.
- Product-specific Figma node IDs, assets, implementation code, and
  progress logs belong in the product repo.

## Required Preflight Outputs

Before writing product UI code, create these five artifacts in the
product repo:

1. `docs/FIGMA_BOARD_STATE_MAP.md`
   - Lists every implementation board/state in order.
   - Maps each state to a Figma node ID.
   - Names the role of each board: default, panel open, hover, process,
     error, success, and so on.
   - Marks source gaps, hidden layers, provisional cards, and deferred
     boards explicitly.
   - When one product targets phone and pad, maps the boards for each
     form factor separately and marks intentionally shared states.
2. `docs/LAYOUT_CONSTANTS.md`
   - Records stable frame sizes, rails, panels, chrome, toolbars,
     spacing, z-order, and responsive limits.
   - Separates reusable constants from one-off board measurements.
   - Notes any geometry-sensitive strokes that must not participate in
     layout.
   - For mobile targets, records source-frame size, safe-area/window
     insets, status/navigation bar ownership, and any Figma-pixel to
     platform-unit interpretation.
   - For phone-and-pad targets, records layout adaptations rather than
     treating the pad composition as a stretched phone frame.
3. `docs/TOKEN_SNAPSHOT.md`
   - Captures colors, typography, radii, shadows, and effects used by
     the product.
   - States whether tokens come from existing code, Figma variables, or
     extracted draft rules.
   - Names the confirmed default design-system/variable library, its
     source page or node, collections/modes, and which form factors
     consume it.
   - Defines the binding rule: when a default variable library exists,
     product surfaces use its semantic tokens by default; raw values or
     new local tokens require a recorded exception.
   - Flags unresolved token conflicts instead of silently picking one.
4. `docs/ASSET_MANIFEST.md`
   - Classifies every design-owned image/icon as `existing export`,
     `new export required`, `no asset needed`, or `approved code-drawn
     primitive`.
   - Records export node IDs, target paths, format, and render size.
   - States which assets must be PNG or SVG and why.
   - For Android targets, records drawable/vector packaging and density
     bucket decisions before implementation depends on those assets.
5. `docs/INTERACTION_CONTRACT.md`
   - Lists confirmed user actions, state transitions, and forbidden
     inferred interactions.
   - Blocks implementation of modals, panels, recommendations, hover
     states, or process flows that are not present in Figma or explicitly
     approved by the user/team.
   - Includes a transition table for multi-state products.

## Implementation Gate

Implementation may start only when:

- all five preflight artifacts exist and have enough information to
  implement the first board;
- the tech-stack profile identifies target, framework, token format,
  verification surface, and any mobile device/system-UI policy that
  affects layout;
- the default token/design-system source and binding policy are recorded,
  or the preflight explicitly states that no confirmed baseline exists;
- every claimed form factor has a source frame/state mapping and a
  verification device or surface;
- every implemented state can point back to a Figma node or an approved
  provisional source;
- required assets are exported or scheduled before code;
- the interaction contract confirms the state transitions that the code
  will implement;
- the first verification surface is defined.

If any of these are missing, stop and complete the preflight artifact
first.

## Mobile Platform Gate

For Android or iOS products, settle these questions before UI code:

- Which source device/frame is being implemented, and how are Figma
  dimensions mapped to platform units?
- If both phone and pad are required, which layout regions are shared,
  which recompose, and what adaptive layout policy selects them?
- If phone and pad share a confirmed variable library, which semantic
  tokens are mandatory across both surfaces and how are exceptions
  reviewed?
- Do the status bar and system navigation area belong to the operating
  system, an edge-to-edge app layout, or a design-only reference frame?
- What density/scale asset output and package resource locations are
  required?
- Which simulator/emulator/device captures will prove visible fidelity
  for every claimed form factor?

Do not silently render designed system bars as ordinary app content or
drop their insets from measurements.

## Board-First Delivery

Restore the product board by board:

1. Implement board 1 default.
2. Verify it against its Figma node.
3. Implement the next board/state.
4. Verify the new state and any transition from previous states.
5. Record evidence and gotchas before moving on.

Do not start by inventing a generally reasonable product UI. The first
implementation path should be:

- board 1 default
- board 2 panel open
- board 3 hover/process
- later states in the source order

Every rendered state must be traceable to a Figma node or an approved
provisional card.

## Verification Gate

A development preview alone is not enough.

Before handoff, run:

- the project build command;
- a production preview, installed build, or equivalent packaged artifact
  check appropriate to the target;
- rendered verification against the implemented state, such as browser
  evidence for web or emulator/simulator evidence for mobile;
- asset path or packaged resource verification in the delivered build.
- a handoff cleanup pass that removes temporary demo/test/verification
  UI from the production-facing product.

## Handoff Cleanup Gate

Product restoration often needs temporary routes, verify cards, mock
fixtures, or debug controls while the implementation is being built.
Those are allowed during restoration, but they must not remain in the
final product surface or production package unless explicitly approved.

Before handoff:

- remove temporary demo pages, verify cards, screenshot-only boards,
  mock data panels, debug labels, and test controls from the
  user-facing product flow;
- keep rendered-verification/build/package evidence in docs or PR notes
  instead of rendering it in the product UI;
- confirm the delivered preview or installed build starts on the
  intended product surface, not a validation playground;
- do not delete real automated tests, build scripts, verification
  evidence, or reusable fixtures unless they are explicitly obsolete.

The handoff should state whether the result is:

- preflight-complete;
- implementation-ready;
- board-verified;
- delivery-surface-verified;
- handoff-cleaned;
- still blocked.

## Template Package

Copy `templates/product-restoration/` into the product repo at project
start, then replace the bracketed placeholders with product-specific
values.

`docs/GOTCHAS.md` is a living file. After each completed product
restoration loop, write the non-obvious lessons back into the template's
`GOTCHAS.md` so the next product repo starts with accumulated knowledge.
The first proof loop is `browser-ai-tools-product` (2026-05-20).
