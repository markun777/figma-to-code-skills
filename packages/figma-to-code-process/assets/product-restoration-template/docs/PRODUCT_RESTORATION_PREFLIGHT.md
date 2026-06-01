# Product Restoration Preflight

Status: `[not-started | in-progress | complete]`

## Source

- Product name: `[PRODUCT_NAME]`
- Figma file: `[FIGMA_FILE_KEY_OR_URL]`
- Source section/page: `[SOURCE_SECTION_OR_PAGE]`
- Target platform: `[web | ios | android | other]`
- Framework/runtime: `[FRAMEWORK]`
- Build command: `[BUILD_COMMAND]`
- Preview/package check: `[PREVIEW_COMMAND_OR_PACKAGE_CHECK]`

## Required Artifacts

| Artifact | Status | Notes |
|---|---|---|
| `FIGMA_BOARD_STATE_MAP.md` | `[ ]` | Board/state nodes mapped before code |
| `LAYOUT_CONSTANTS.md` | `[ ]` | Stable geometry and responsive limits |
| `TOKEN_SNAPSHOT.md` | `[ ]` | Colors, type, radii, shadows, effects |
| `ASSET_MANIFEST.md` | `[ ]` | Export plan and asset paths |
| `INTERACTION_CONTRACT.md` | `[ ]` | Confirmed actions and blocked inventions |

## Implementation Gate

Implementation may start only after:

- [ ] the first board/state has a Figma node;
- [ ] layout constants for the first board are recorded;
- [ ] required assets are classified and exported or scheduled;
- [ ] interaction rules for the first slice are confirmed;
- [ ] verification surface is defined.
- [ ] handoff cleanup rule is defined: temporary demo/test/verification
      UI must be removed from the production-facing product before
      closeout.

## Handoff Cleanup Gate

Before final handoff:

- [ ] temporary demo pages/routes are removed or excluded from production
- [ ] verify cards, screenshot-only boards, and mock panels are removed
      from the user-facing flow
- [ ] debug labels, test controls, and fixture selectors are not visible
      in the production preview/package
- [ ] browser/DOM/build evidence is recorded in docs or PR notes
- [ ] automated tests, build scripts, verification docs, and reusable
      fixtures are preserved unless explicitly obsolete

## Blockers

| Blocker | Owner | Resolution Needed |
|---|---|---|
| `[BLOCKER]` | `[OWNER]` | `[NEXT_STEP]` |

## Handoff Status

Current status:

- `[ ]` preflight-complete
- `[ ]` implementation-ready
- `[ ]` board-verified
- `[ ]` production-preview-verified
- `[ ]` handoff-cleaned
- `[ ]` blocked
