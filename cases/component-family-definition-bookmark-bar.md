# Component Family Definition — BookmarkBar

## Status

`closed` — full bar implemented from Figma `1708:30228`. agentic-browser-ui PR #30 pending merge.

## Source

- Figma file: `iIbL9V4UrFeORPaM7KVji7`
- Source node: `1708:30228` — 书签, 135×24, Agentic Browser page

## Scope

BookmarkBar is the bookmark section in the browser toolbar right area.
Structure: `[divider 2×24] [BookmarkItem(s)] [More button 24×24]`

Reuses `BookmarkItem` (Phase M, `1708:30231~30233`) for each item.

**Component boundary:** distinct from `Toolbar.tsx` — BookmarkBar is the
bookmark section only; Toolbar wraps the full toolbar row.

## Implementation

- File: `agentic-browser-ui/src/components/BookmarkBar.tsx`
- Verify surface: `agentic-browser-ui/src/App.tsx` BookmarkBar verify cards
- PRs: agentic-browser-ui #30; figma-to-code-skills #67
- Exported assets (3):
  - `bookmark-bar-divider@1x.svg` (source: `1708:30229`)
  - `bookmark-bar-more-dot@1x.svg` (source: `I1708:30242;368:41942`)
  - `bookmark-bar-more-icon@1x.png` (source: `1708:30242`)

## Component Axes

| Axis | Values | Definition status |
|---|---|---|
| items | `Array<{label, appIconSrc?, appIconBg?, appIconRadius?, onClick?}>` | prop-driven |
| onMore | callback | prop-driven |

## Geometry

| Property | Value |
|---|---|
| container | `flex gap-[12px] items-center h-[24px]` |
| divider | `2 × 24`, stroke `#CCCCCC`, segment `y:8–16` |
| BookmarkItem slot | `h-[24px]`, width content-driven |
| More button | `24 × 24`, `rounded-[99px]`, `bg: rgba(255,255,255,0.12)`, `border: 0.5px solid rgba(0,0,0,0.08)` |
| More icon | `16 × 16`, three 2×2 dots at x=4/10.5/17 y=11, fill `#666` |

## Verification Status

| Check | Status |
|---|---|
| Figma design context | passed: `1708:30228` inspected; divider, BookmarkItem, More button all confirmed |
| Asset inventory | passed: 3 assets exported and recorded in slices-name-map.json |
| State-geometry scan | passed: single state, no hidden variants |
| Build | passed: `npm run build` |
| Lint | passed: `npm run lint` |
| git diff --check | passed |
| `npm run gate` | passed: 82 SVGs, 25 source files, 1 banned asset — all pass |

## Durable Lessons

- **All icons must be exported, not hand-drawn**: even simple geometry (dots, dividers) must come from Figma exports. The pre-implementation asset check is a hard gate — no exceptions.
