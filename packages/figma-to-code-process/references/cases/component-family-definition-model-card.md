# Component Family Definition — ModelCard

## Status

`closed` — first slice covers the 模型广场 Card states from Figma
`2080:40041`. User visual review follow-up corrected the visible DeepSeek
icon glyph size after PR #50.

## Source

- Figma file: `iIbL9V4UrFeORPaM7KVji7`
- Component board: `2080:40041`
- Slice source nodes:
  - `2080:40042` — 所属模块=模型广场, 状态=Normal
  - `2080:40051` — 所属模块=模型广场, 状态=Hover
  - `2080:40064` — 所属模块=模型广场, 状态=loading
  - `2080:40079` — 所属模块=模型广场, 状态=Selected

## Scope

ModelCard is a fixed-size model entry card. This first validation slice is
limited to the 模型广场 module because it is compact but still exercises real
state behavior:

- Normal default card
- Hover download overlay (`下载 DeepSeek-R1-7B 本地版` + `立即下载`)
- Loading progress overlay (`下载中...`)
- Selected card with black stroke

The larger Card board also includes 写作助手, AI 搜索, and AI Space variants.
Those are intentionally out of scope for this pass.

## Implementation

- File: `agentic-browser-ui/src/components/ModelCard.tsx`
- Verify surface: `agentic-browser-ui/src/App.tsx` ModelCard verify cards
- PRs: agentic-browser-ui #17, figma-to-code-skills #50
- Exported assets:
  - `src/assets/figma/modelcard-deepseek-vector@1x.svg`
  - `src/assets/figma/modelcard-deepseek-vector-inner@1x.svg` — rendered as
    the visible glyph
  - `src/assets/figma/modelcard-loading-progress@1x.svg`

## Component Axes

| Axis | Values | Definition status |
|---|---|---|
| module | 模型广场 | source-confirmed |
| state | Normal / Hover / loading / Selected | source-confirmed |
| local tag | hidden | out of scope for first slice |

## Geometry

| Property | Value |
|---|---|
| root size | `284 × 132` |
| radius | `16px` |
| normal stroke | `0.5px rgba(0,0,0,0.1)` |
| selected stroke | `1px #000` |
| padding | `18px` |
| content gap | `8px` |
| title | `16px / 24px`, HYQiHei:85S |
| description | `12px / 18px`, max height `36px` |
| DeepSeek icon | `20 × 20` slot; visible blue glyph `18 × 13.25` |
| overlay inset | full-card overlay, inner content left/right `20px` |
| loading progress | track `244 × 6`, fill `73 × 6` |

## Verification Status

| Check | Status |
|---|---|
| Figma design context | passed: all four source nodes inspected |
| Asset inventory | passed: DeepSeek vectors and progress mask exported locally |
| Build | passed: `npm run build` in agentic-browser-ui |
| Lint | passed: `npm run lint` |
| Browser DOM measurement | passed: all four cards `284 × 132`; DeepSeek icon slot `20 × 20`; visible glyph `18 × 13.25`; Normal/Hover/loading outline `0.5px`; Selected outline `1px #000`; Hover button `88 × 32`; loading track `244 × 6`; loading fill `73 × 6` |
| Visual review | passed: browser render checked after build |
| git diff --check | passed |

## Deferred

- Remaining Card board modules: 写作助手, AI 搜索, AI Space
- Optional local-model tag (`showTag=true`)
- Interactive wiring for starting a download
