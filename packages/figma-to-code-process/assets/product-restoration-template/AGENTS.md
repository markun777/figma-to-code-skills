# AGENTS.md

Instructions for Codex, Claude, or any other agent working in this
standalone product repo.

## Project Goal

Restore and validate `[PRODUCT_NAME]` from the Figma source of truth.

- Figma file: `[FIGMA_FILE_KEY_OR_URL]`
- Source section/page: `[SOURCE_SECTION_OR_PAGE]`
- Product surface: `[ONE_SENTENCE_PRODUCT_SURFACE]`

This repo is independent from `figma-to-code-skills`. Treat
`figma-to-code-skills` as the workflow/template source, not as the
product worktree.

## Before Touching Files

1. Run `git status --short --branch` from this product repo.
2. Read:
   - `docs/PRODUCT_RESTORATION_PREFLIGHT.md`
   - `docs/FIGMA_BOARD_STATE_MAP.md`
   - `docs/LAYOUT_CONSTANTS.md`
   - `docs/TOKEN_SNAPSHOT.md`
   - `docs/ASSET_MANIFEST.md`
   - `docs/INTERACTION_CONTRACT.md`
   - `docs/PROGRESS.md`
   - `docs/GOTCHAS.md` (if present — lessons from prior loops)
3. If the relevant board or interaction is not documented, update the
   preflight docs before coding.
4. If a state cannot point to a Figma node or approved provisional card,
   stop and ask for confirmation.

## Required Gates

- Do not implement product UI before the preflight artifacts exist.
- Do not invent modals, panels, recommendations, hover states, process
  flows, or hidden states without Figma source or explicit approval.
- Do not rebuild design-owned icons, widgets, screenshots, or
  illustrations in code unless they are approved code-drawn primitives.
- Export design-owned assets before wiring code that depends on them.
- Implement board by board in the order recorded in
  `FIGMA_BOARD_STATE_MAP.md`.
- Every implemented state must have browser verification evidence.
- A dev server preview is not sufficient handoff evidence; run the build
  command and verify the production preview/package path.
- Before handoff, remove temporary demo/test/verification UI from the
  production-facing product. Keep evidence in docs or PR notes, not in
  the final user flow.
- Do not delete real automated tests, build scripts, verification docs,
  or reusable fixtures unless the user explicitly confirms they are
  obsolete.

## Documentation Rules

- Update `docs/PROGRESS.md` whenever a board cleanup, asset export pass,
  interaction milestone, implementation slice, or verification pass is
  completed.
- Record source gaps and deferred audits instead of silently choosing an
  interpretation.
- Keep product-specific docs in this repo. Do not push product state
  back into `figma-to-code-skills` unless it is a reusable workflow
  gotcha.

## Verification

Before handoff, run:

1. `[BUILD_COMMAND]`
2. `[PREVIEW_COMMAND_OR_PACKAGE_CHECK]`
3. Browser verification for the current board/state.
4. Asset path check for production output.
5. Handoff cleanup check: no temporary demo route, verify card,
   screenshot-only board, mock panel, debug label, or test control is
   visible in the production-facing product.

Report what passed, what was not run, and any remaining drift.
