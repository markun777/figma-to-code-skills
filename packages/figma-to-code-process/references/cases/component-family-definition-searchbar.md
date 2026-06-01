# Component Family Definition — SearchBar

## Status

`verified` — default (empty) and focused with-value states confirmed via browser DOM measurement. Micro-drift follow-up fixed the icon-to-text gap and input text color in agentic-browser-ui PR #18.

## Source

- Figma file: `iIbL9V4UrFeORPaM7KVji7`
- Instance in NavigationMenu spec: `2080:8086` (240×32, named "Search")
- Master component: "Search bar" component set (library, not directly accessible)
- Context board: `2080:7520` (顶栏 documentation board)

## Scope

SearchBar is a 240×32 search input used in the NavigationMenu right slot. The instance `2080:8086` shows the active/typing state (text + cursor + clear button). The default (empty) state is inferred: no clear button, placeholder text, lighter border.

The master component is in a linked library and cannot be accessed directly. Spec is derived from the instance design context.

## Implementation

- File: `agentic-browser-ui/src/components/SearchBar.tsx`
- Integration: `agentic-browser-ui/src/components/NavigationMenu.tsx` — `showSearch` + `onSearch` props
- Verify surface: `agentic-browser-ui/src/App.tsx` SearchBar verify cards + NavigationMenu showSearch cards
- Assets:
  - `src/assets/figma/nav-search-icon@1x.svg` — search icon (18×18, currentColor)
  - `src/assets/figma/nav-clear-icon@1x.svg` — clear/× icon (18×18, currentColor)

## Component Axes

| Axis | Values | Definition status |
|---|---|---|
| value | empty / with-value | source-confirmed |
| focus | default / focused | inferred (focus-within border darkens) |

## Geometry

| Property | Value |
|---|---|
| source | `2080:8086` instance |
| size | `240 × 32` |
| border | `1.5px solid rgba(51,51,51,0.12)` default; `rgba(51,51,51,0.9)` focused |
| border-radius | `12px` |
| padding | `px-[8px]` |
| shadow | `0px 0px 20px rgba(0,0,0,0.06)` |
| search icon | `18 × 18`, `currentColor` |
| search icon → text gap | `6px` |
| clear icon | `18 × 18`, `currentColor`, visible only when value non-empty |
| input → clear icon gap | `8px` |
| text | `14px`, `leading-[22px]`, `#000`, HYQiHei:60S |
| cursor | `1px × 22px`, `#1f2329` |

## Verification Status

| Check | Status |
|---|---|
| Figma instance design context | passed: `2080:8086` spec extracted |
| Asset inventory | passed: nav-search-icon + nav-clear-icon exported |
| Build | passed: `npm run build` in agentic-browser-ui |
| DOM — container | passed: `h-[32px] w-[240px] rounded-[12px] border-[1.5px]` |
| DOM — search icon | passed: SVG 18×18 with circle + path |
| DOM — default state | passed: no clear button, empty input |
| DOM — focused with-value state | passed: value="字幕", clear button rendered, focused border `rgba(51,51,51,0.9)` |
| DOM — spacing | passed: icon-to-text gap `6px`, input-to-clear gap `8px` |
| DOM — text/caret color | passed: text `rgb(0,0,0)`, caret `rgb(31,35,41)` |
| DOM — font | passed: `HYQiHei:60S, PingFang SC, sans-serif` |
| git diff --check | passed |

## Deferred

- Hover state on clear button (color transition)
- Keyboard interaction (Escape to clear)
- Master component variant confirmation (library access required)
- Default border color confirmation (inferred as `rgba(51,51,51,0.12)`)
