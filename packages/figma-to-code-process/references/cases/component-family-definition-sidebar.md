# Component Family Definition — Sidebar

## Status

`verified` — expanded/default coverage remains closed; icon-only collapsed
source has now been confirmed and matched against the existing implementation.

## Source

- Figma file: `iIbL9V4UrFeORPaM7KVji7`
- Expanded board: `1708:30337` (`侧边栏展开`)
- Expanded Sidebar instance: `1990:11765`
- Expanded Sidebar main component: `1708:30408`
- Icon-only collapsed source: `1708:30181`
- Hidden icon-only reference: `1708:30814`

## Scope

Sidebar is a 240px left rail used in the browser shell. The original formal
pass covered the expanded 240×816 Sidebar component. This closeout adds the
source-confirmed icon-only/collapsed-like rail from `1708:30181`.

The collapsed source is not a formal Figma component-set variant. Figma
inspection showed `1990:11765` resolves to a single `COMPONENT`
(`1708:30408`) whose parent is a plain frame (`1714:1024`), not a
`COMPONENT_SET`. Treat `1708:30181` as a separate source-confirmed frame for
the icon-only rail, not as an official variant axis promoted by component
properties.

## Implementation

- File: `agentic-browser-ui/src/components/Sidebar.tsx`
- Verify surface: `agentic-browser-ui/src/App.tsx` Sidebar verify card
- Existing assets:
  - `src/assets/figma/sidebar-toggle@1x.svg`
  - `src/assets/figma/sidebar-new-task@1x.svg`
  - `src/assets/figma/sidebar-collapse@1x.svg`
  - `src/assets/figma/sidebar-auto-run@1x.svg`
  - `src/assets/figma/sidebar-skills@1x.svg`
  - `src/assets/figma/sidebar-project@1x.svg`
  - `src/assets/figma/sidebar-add@1x.svg`
  - `src/assets/figma/sidebar-avatar@1x.svg`

## Component Axes

| Axis | Values | Definition status |
|---|---|---|
| layout | `expanded`, `icon-only` | source-confirmed |
| item interaction | default only | formal for current scope |

Interaction states such as hover/active remain out of scope because the
current Figma sources only expose default visuals.

## Expanded Sidebar

| Property | Value |
|---|---|
| source | `1708:30337` / instance `1990:11765` / component `1708:30408` |
| size | `240 × 816` |
| background | `rgba(0,0,0,0.02)` |
| stroke | right `0.5px rgba(0,0,0,0.08)` |
| horizontal padding | `8px` |
| header | `56px`, `pl 12 / pr 4 / py 4` |
| item row | `216 × 40`, `px 8 / py 5`, icon wrapper `24`, icon `16` |
| history row | `216 × 40`, `px 12 / py 8`, truncating text |

## Icon-Only Sidebar

| Property | Value |
|---|---|
| source | `1708:30181` |
| size | `240 × 816` |
| padding | `16px` |
| content | two 24×24 icon buttons |
| gap | `12px` |
| icons | `16 × 16` |

`1708:30814` is only a hidden 24×24 icon reference. It is useful as an asset
reference, but it is not the complete collapsed Sidebar state.

## Verification Status

| Check | Status |
|---|---|
| Figma source confirmation | passed: `1708:30181` is the icon-only rail source |
| Component-set variant check | passed: expanded Sidebar is a single component, not a variant set |
| Existing implementation shape | passed: `Sidebar.tsx` already exposes `collapsed?: boolean` |
| Build | passed: `npm run build` in `agentic-browser-ui` |
| Browser DOM geometry | passed: collapsed aside `240 × 816`, padding `16px`, icon row `60 × 24`, gap `12px`, two buttons `24 × 24`, icons `16 × 16` |

## Deferred

- Hover/active states for Sidebar rows
- Animation between expanded and icon-only rails
- Promoting `layout=icon-only` into an official Figma component-set variant
