# Existing Rule Capture — agentic-browser-ui

> captured: 2026-04-20
> enriched: 2026-04-23 (code evidence pointers added)
> source: code inspection across all 8 components + index.css
> status: confirmed-standard / tentative / unresolved-gap (per rule)

---

## Tech-Stack Profile

| Field | Value |
|---|---|
| target | web |
| framework | react (Vite + TypeScript) |
| token_format | css-vars + Tailwind v4 (`@import "tailwindcss"`) |
| design_system | custom-ds (provisional label) |
| component_source | code-components (no Figma library link) |
| asset_profile | SVG `@1x` for icons; PNG `@1x` for raster content |
| verification_surface | browser (local dev server) |

---

## Token System

### Color tokens (repo-defined — defined in `src/index.css`)

| Token | Value | Usage |
|---|---|---|
| `--color-text-primary` | `#333333` | body text, icon default |
| `--color-text-secondary` | `#666666` | secondary labels |
| `--color-text-tertiary` | `#999999` | placeholder, muted |
| `--color-text-disabled` | `#cccccc` | disabled text, dividers |
| `--color-surface-base` | `#ffffff` | card / input background |
| `--color-surface-app-bg` | `#ebeef5` | page-level background |
| `--color-surface-window` | `#fafafa` | browser window shell |
| `--color-surface-overlay-white` | `rgba(255,255,255,0.8)` | model toggle pill |
| `--color-surface-button-secondary` | `rgba(0,0,0,0.1)` | send button bg |
| `--color-border-default` | `#d9d9d9` | standard border |
| `--color-border-subtle` | `rgba(0,0,0,0.08)` | subtle separator |
| `--color-border-input-default` | `#000000` | (unused in practice — tentative) |
| `--color-state-hover-overlay` | `rgba(0,0,0,0.04)` | hover overlay layer |
| `--color-focus-ring` | `rgba(0,128,255,0.2)` | focus ring (unused in practice — tentative) |
| `--color-border-focus` | `#1f63ed` | input focus border |
| `--color-border-error` | `#e53b33` | input error border |
| `--color-surface-disabled` | `#f9f9fa` | disabled input bg |

**Unresolved gap:** `--color-border-input-default` and `--color-focus-ring` are defined but not consumed by any component. Likely stale or reserved.

### Spacing tokens

| Token | Value |
|---|---|
| `--spacing-4` | `4px` |
| `--spacing-8` | `8px` |
| `--spacing-12` | `12px` |
| `--spacing-16` | `16px` |
| `--spacing-24` | `24px` |

**Tentative:** spacing tokens are defined but components use Tailwind arbitrary values directly rather than consuming the CSS vars. The tokens exist as documentation, not as enforced constraints. Evidence: `InputBox.tsx:50` — `gap-[12px] pb-[12px] pt-[16px] px-[12px]`; `Sidebar.tsx:61,86` — `px-[12px] py-[8px]`.

### Radius tokens

| Token | Value | Usage |
|---|---|---|
| `--radius-8` | `8px` | buttons, tab inner, model toggle |
| `--radius-12` | `12px` | prompt chips |
| `--radius-24` | `24px` | InputBox shell |
| `--radius-99` | `99px` | pills, send button |

**Confirmed standard:** radius tokens are consumed via `rounded-[var(--radius-*)]` in InputBox and some components. Inconsistently applied elsewhere (arbitrary values used in parallel). Evidence: `InputBox.tsx:50,70,73,85,94` uses `var(--radius-*)` consistently; other components mix arbitrary values.

---

## Icon Rules

**Confirmed standard** `evidence-type: pattern-compliance`
- All design-owned icons must be exported from Figma source before implementation (hard gate).
- If the asset exists in `src/assets/figma/`, import it. If not, export it first.
- Do not ship inline SVG or handwritten geometry while the export check is incomplete.
- Conformance: 8 of 8 components follow this rule. Previously `Tab.tsx` defined `CloseIcon` as inline SVG despite exported assets existing — resolved in B.2 (PR #7, `agentic-browser-ui`).

**SVG import pattern** `evidence-type: file:line`
- `?react` import → use as React component with `className` for `currentColor` theming (theme-reactive icons)
  - Evidence: `Toolbar.tsx:2-6`, `Sidebar.tsx:2-6`, `AIToolsRow.tsx:2-6` — all nav/action icons use `?react`
- Regular import → use as `<img src={...}>` for icons with hardcoded colors baked into the SVG
  - Evidence: `InputBox.tsx:1-4`, `Dialog.tsx:1-3`, `Toolbar.tsx:8` — control icons with baked colors use regular import

**Confirmed standard — color baking rule** `evidence-type: file:line`
- Exported SVGs with hardcoded `#333333` = `--color-text-primary` → use as `<img>`
- Exported SVGs with hardcoded `#999999` = `--color-text-tertiary` → use as `<img>`
- Exported SVGs using `currentColor` → use as `?react` component
- Evidence: `Dialog.tsx:1-3` imports `close-default/hover/circle` as regular (baked colors); `Toolbar.tsx:2-6` imports nav icons as `?react` (currentColor)

**Confirmed standard — structural inline SVG exception** `evidence-type: file:line`
- Structural separators that meet all three criteria do not require exported asset wiring:
  1. The element is a layout/structural separator, not a design-owned icon with visual identity
  2. The geometry is simple and purely structural (single path or minimal shape — no fills, gradients, or multi-element composition)
  3. It uses `currentColor` for theme reactivity (no hardcoded color values)
- Evidence: `Toolbar.tsx:10-24` — `NavDivider` (8×24, single stroke path) and `RightDivider` (2×24, single stroke path) both qualify
- This exception does not apply to icons that have a Figma source node or that carry visual identity (e.g. brand icons, action icons, state indicators)

**Resolved (B.2 — PR #7, `agentic-browser-ui`):** `Tab.tsx` previously defined `CloseIcon` as an inline SVG (`Tab.tsx:6-14`) but exported assets `close-off@1x.svg` / `close-on@1x.svg` already existed in `src/assets/figma/`. Wired to exports in B.2.

**Confirmed standard — icon sizing** `evidence-type: file:line`
- Compact action-icon controls: `24×24` hit area, `16×16` icon frame (default pattern)
- Evidence: `Sidebar.tsx:71-72` — `size-[24px]` button wrapping `size-[16px]` icon; same pattern in `SidebarSectionHeader` at `Sidebar.tsx:53-75`
- Exported SVG canvas size is packaging data, not rendered-size contract — normalize via `className` size, not by changing layout

---

## Stateful Border Rule

**Confirmed standard:** stateful borders must not change geometry between states. Visual ring expressed via `inset box-shadow` (not border-width change) to avoid layout shift. Evidence: `InputBox.tsx:18-23` — all four states (`default`, `focus`, `disabled`, `error`) use `border-[1.5px] border-transparent` with varying `inset` shadow values.

---

## Component Prop API Conventions

**Confirmed standard** `evidence-type: file:line`
- Boolean props for simple on/off states: `selected`, `hovered`, `bookmarked`, `urlFocused`
  - Evidence: `Tab.tsx:11-12,20-21` — `selected?`, `hovered?` in interface; `selected = false, hovered = false` defaults
- Optional callback props: `onClick?`, `onClose?`, `onSend?`
  - Evidence: `InputBox.tsx:14,39` — `onSend?: (value: string) => void`
- Optional `ReactNode` slots for composition: `assistantButton?: ReactNode | null`
  - `undefined` → render default; `null` → render nothing; provided value → render that value
  - Evidence: `Toolbar.tsx:32,134-148`
- Default prop values always provided (no required props except label/content)
  - Evidence: `Tab.tsx:20-21` — `selected = false, hovered = false`

---

## Interaction State Pattern

**Confirmed standard:** prop-driven state is the baseline pattern for explicitly verifiable states.
- `Toolbar.tsx:30-31,45-46` — `bookmarked`, `urlFocused` boolean props
- `Dialog.tsx:9,30-31` — `CloseIcon` uses `variant` prop to force hover state for verify purposes

**Tentative:** local `useState` + mouse event handlers (`onMouseEnter`, `onMouseLeave`, `onMouseDown`, `onMouseUp`) is a recurring implementation tactic for interactive hover/active controls where the state is pointer-driven and not externally observable.
- `AIToolsRow.tsx:17-24` — `ToolPill` uses `hovered`/`active` local state
- `Tab.tsx:27,32-33` — close button uses `closeHovered` local state
Not a mandatory pattern — prop-driven and pointer-driven approaches coexist in this codebase.

---

## Typography

**Confirmed standard** `evidence-type: file:line`
- `HYQiHei:60S` — primary body text, labels, button text (14px / 20px leading)
  - Evidence: `AIToolsRow.tsx:39`; `Dialog.tsx:76-78,173,191`
- `HYQiHei:55S` — input placeholder (16px / 24px leading); also section header labels
  - Evidence: `InputBox.tsx:60`; `Sidebar.tsx:65`
- `PICO_Sans_VFE_SC:Light` — assistant chip label (12px)
  - Evidence: `AssistantSidebarPanel.tsx:35`
- `SF Pro` — browser tab active label (12px, Latin/system context)
  - Evidence: `Toolbar.tsx:103,122`
- All font families applied via inline `style={{ fontFamily: ... }}` with `PingFang SC` or `sans-serif` fallback
  - Evidence: `AssistantSidebarPanel.tsx:61` — `fontFamily: "'HYQiHei:60S', 'PingFang SC', sans-serif"`

**Unresolved gap:** HYQiHei font loading is deferred across all components. Font may not render correctly in all environments. Shared typography pass is a known non-blocker.

**Unresolved gap:** `fontFeatureSettings: "'ss01' 1, 'cv01' 1, 'cv11' 1"` applied inconsistently — present on `AssistantSidebarPanel.tsx:62`, `TaskChatPanel.tsx:80`, `Sidebar.tsx:92`; absent on `InputBox.tsx`, `Tab.tsx`, `Toolbar.tsx` HYQiHei:60S usages.

---

## Layout Conventions

**Confirmed standard:**
- Fixed pixel dimensions for component shells (no fluid sizing within components). Evidence: `AssistantSidebarPanel.tsx:88` — `h-[856px] w-[400px]`; `BrowserResultPage.tsx:78` — `h-[856px] w-[1592px]`
- `w-full` only used inside a component when the parent constrains width
- If Figma gives an explicit inner row width, preserve it. Evidence: `AssistantSidebarPanel.tsx:112` — `w-[368px]` for prompt list inside 400px panel
- Overflow hidden on shells that clip content. Evidence: `BrowserResultPage.tsx:60,78,89,90`; `Sidebar.tsx:38,86`

**Confirmed standard — section headers with optional actions:**
- Model as separate slots (`label` + optional `action`) not as a single undifferentiated row
- Evidence: `Sidebar.tsx:53-75` — `SidebarSectionHeader` accepts `label: string` and `action?: { icon, ariaLabel }`

---

## Asset Naming Convention

**Confirmed standard** `evidence-type: file:line`
- Pattern: `{component}-{descriptor}@{scale}.{ext}`
- Evidence (import sites): `InputBox.tsx:1-4`, `Dialog.tsx:1-3`, `Toolbar.tsx:2-8`, `AIToolsRow.tsx:2-6`
- Examples from `src/assets/figma/`:
  - `toolbar-back@1x.svg`, `inputbox-send@1x.svg`, `dialog-close-default@1x.svg`, `aitoolsrow-knowledge@1x.svg`

All assets live in `src/assets/figma/`. Source node mapping tracked in `src/assets/figma/slices-name-map.json`.

---

## Provisional State Rules

**Confirmed standard** `evidence-type: canvas-rule`
- Provisional boards must be standalone (not inside a formal artboard), with clear canvas separation
- Provisional state cards must apply state to the root control container, not by appending extra layers
- Do not promote a component set to canonical while any family boundary or state axis is still provisional
- Note: these are Figma canvas structure rules — no code file:line evidence exists by nature.

**Code-side correspondence** `evidence-type: file:line`
- `Tab.tsx:27,29-38` — close hover state implemented as pointer-driven local state, corresponding to the Tab hover-close provisional board on canvas

---

## Unresolved Gaps Summary

| Gap | Location | Status |
|---|---|---|
| `--color-border-input-default` and `--color-focus-ring` unused | `index.css` | stale or reserved — confirm or remove |
| Spacing tokens not consumed by components | all components | tokens exist as docs only; components use arbitrary Tailwind values |
| Radius tokens inconsistently applied | mixed | some components use `var(--radius-*)`, others use arbitrary values |
| `fontFeatureSettings` inconsistently applied | multiple | present on some HYQiHei:60S usages, absent on others |
| HYQiHei font loading | all components | deferred non-blocker, shared typography pass needed |

## Resolved Gaps

| Gap | Location | Resolution |
|---|---|---|
| Tab.tsx `CloseIcon` inline SVG | `Tab.tsx` | resolved-by-B.2 (PR #7) — wired to `close-off@1x.svg` / `close-on@1x.svg` |
| `NavDivider` / `RightDivider` inline SVG in Toolbar | `Toolbar.tsx` | structural inline SVG exception rule documented (see Icon Rules) |
