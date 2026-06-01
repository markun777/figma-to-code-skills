# Component Family Definition — TopTabBar

## Status

`closed` — full bar implemented from Figma `2080:8062`.
Phase I (operation + tab-strip, PR #20) and Phase J (global actions, PR #21) both merged.

## Source

- Figma file: `iIbL9V4UrFeORPaM7KVji7`
- Source node: `2080:8062` — Tab bar, 1166×52
- Confirmed state: home-selected (only state present in source node)

## Scope

TopTabBar is the application top bar. Full implementation covers:

- Back/forward navigation buttons (32×32, disabled at `opacity-30`)
- 3-tab strip: 主页 (home-selected), 设置 (inactive), 小程序名称 (inactive)
- 全局操作 right-side area (gated by `showGlobalActions` prop, default `true`):
  - 功能组: 新版本 pill, 签到 pill, user chip
  - 窗口控制: pin/minimize/maximize/close (each 32×32)

This is a distinct component family from:
- `Tab.tsx` — browser page tabs, 40px height, close controls
- `NavigationMenu.tsx` — pill-style content nav

## Implementation

- File: `agentic-browser-ui/src/components/TopTabBar.tsx`
- Verify surface: `agentic-browser-ui/src/App.tsx` TopTabBar verify cards (full bar + showGlobalActions=false)
- PRs: agentic-browser-ui #20 (Phase I) + #21 (Phase J); figma-to-code-skills #54 + #56
- Exported assets (12 total):
  - `topbar-nav-arrow@1x.svg` — forward arrow (node `2080:3949`); rotated 180° for back
  - `topbar-home@1x.svg` — frame-preserving normalization of node `1020:11765`; 18×18 canvas, Union glyph 12.16×14.33 at translate(2.92, 1.84); `currentColor` fill → `#3f4046`
  - `topbar-settings@1x.svg` — manually composed from two child paths of node `6198:451788`; `currentColor` stroke → `#18181b`
  - `topbar-apps-logo@1x.png` — PNG 36×36 (node `I2080:8062;1122:12338;1494:53862`), rendered at 18×18
  - `topbar-version-icon@1x.svg` — 16×16 Frame (node `2080:3962`), rendered rotate(180deg)
  - `topbar-gift-icon@1x.svg` — manually composed from 4 gradient layers (node `2080:3975`), 11.667×10.5 canvas
  - `topbar-user-icon@1x.svg` — 20×20 user avatar (node `2080:4007`)
  - `topbar-expand-icon@1x.svg` — 6×3.5 chevron (node `1020:12026`)
  - `topbar-pin-icon@1x.svg` — 16×16 pin (node `2080:4030`)
  - `topbar-minimize-icon@1x.svg` — 14×1.4 line (node `2080:4034`)
  - `topbar-maximize-icon@1x.svg` — 12×12 (node `I2080:8062;1122:12560;1122:61677`)
  - `topbar-close-icon@1x.svg` — 10.4×10.4 X (node `2080:3943`)

## Component Axes

| Axis | Values | Definition status |
|---|---|---|
| selectedTabId | any tab id | prop-driven |
| canGoBack | true / false | prop-driven |
| canGoForward | true / false | prop-driven |
| showGlobalActions | true / false | prop-driven, default true |

## Geometry

| Property | Value |
|---|---|
| root size | `1166 × 52` |
| padding | `px-[14px] py-[10px]` |
| nav button size | `32 × 32` |
| nav button gap | `4px` |
| nav arrow SVG | `11.5 × 11.5` |
| gap: nav → tabs | `16px` |
| tab height | `32px` |
| tab min/max width | `38px / 200px` |
| tab padding | `px-[10px]` |
| active tab bg | `white`, `rounded-[8px]`, `drop-shadow-[0px_0.5px_0px_rgba(0,0,0,0.05)]` |
| inactive divider | `1px × 17px`, `rgba(0,0,0,0.16)`, absolute right-0 top-[7.5px], non-layout-affecting |
| icon size (tabs) | `18 × 18` |
| icon-text gap (tabs) | `6px` |
| tab text | `12px / 18px`, HYQiHei:60S, `#18181b` |
| disabled nav opacity | `0.3` |
| gap: tabs → global | `pl-[64px]` on global container |
| 功能组 gap | `8px` |
| 新版本 pill | `h-28`, `rounded-[100px]`, `bg-[rgba(255,255,255,0.72)]`, `pl-6 pr-10` |
| 签到 pill | `h-28 w-58`, `rounded-[32px]`, gradient `#667dff→#e878c6`, `pl-6 pr-10` |
| user chip | `h-28`, `rounded-[100px]`, `bg-[rgba(255,255,255,0.72)]`, `p-4` |
| window control size | `32 × 32` each, `gap-[4px]` |

## Verification Status

| Check | Status |
|---|---|
| Figma design context | passed: node `2080:8062` inspected (Phase I + J) |
| Asset inventory | passed: 12 assets exported/normalized, all recorded in slices-name-map.json |
| State-geometry scan | passed: inactive divider is absolute-positioned, non-layout-affecting; hover backgrounds are background-color-only and do not affect geometry |
| Build | passed: `npm run build` in agentic-browser-ui |
| Lint | passed: `npm run lint` |
| git diff --check | passed |
| Codex DOM review (Phase I) | passed (3 rounds): bar 1166×52; nav buttons 32×32; tabs 200×32; active home bg white; home slot 18×18 path 12.16×14.33 at #3F4046; settings 18×18 stroke #18181B; apps img 18×18; divider 1×17 |
| Codex DOM review (Phase J) | passed: global group 388×32 pl-64 gap-4; feature group 180×28 gap-8; 新版本 70×28; 签到 58×28; user chip 36×28; window buttons 32×32; all icon sizes match source |

## Durable Lessons

- **Frame-preserving normalization**: export from the frame node, not the inner path. Inner path viewBox stretches the glyph when rendered at frame size. Fix: 18×18 canvas SVG with path translated to correct inset position.
- **currentColor requires an explicit color class**: SVG components using `currentColor` render black without a `text-*` class. Always set the source color explicitly.
- **Shared arrow with rotation**: one directional arrow SVG serves both back and forward via `rotate(180deg)` — no need to export two assets.
- **Multi-layer gradient icon composition**: complex icons with multiple gradient layers (e.g. gift box) can be composed into a single SVG by translating each layer to its correct inset position within a shared canvas.

## Deferred

- Hover/active states for nav buttons, tabs, and window controls (no component set or hidden variants found in source node)
