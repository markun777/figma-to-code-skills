# Code-Backed Capture Mode Validation — Toolbar

> validation date: 2026-04-24
> skill: `figma-capture-design-system` (code-backed mode)
> target: `Toolbar.tsx` in `agentic-browser-ui`
> goal: verify the code-backed capture workflow produces evidence-backed rules
>   that match the existing inventory, and surface any new findings

---

## Tech-Stack Profile (confirmed from codebase)

| Field | Value |
|---|---|
| target | web |
| framework | react (Vite + TypeScript) |
| token_format | css-vars + Tailwind v4 |
| verification_surface | browser (local dev server) |

---

## Capture Run — Extracted Rules

### Asset Import Pattern `evidence-type: file:line`

- `?react` imports → use as React component with `className` for `currentColor` theming
  - Evidence: `Toolbar.tsx:2-7` — `BackSvg`, `ForwardSvg`, `RefreshSvg`, `ProxySvg`, `MoreSvg`, `ExpandSvg` all use `?react`
- Regular import → use as `<img src={...}>` for icons with hardcoded baked colors
  - Evidence: `Toolbar.tsx:8` — `toolbar-bookmark-icon@1x.svg` imported as regular; SVG contains `fill="#FFCA28"` (baked)

### Structural Inline SVG Exception `evidence-type: file:line`

- `NavDivider` (8×24, single stroke path, `currentColor`) — `Toolbar.tsx:10-16`
- `RightDivider` (2×24, single stroke path, `currentColor`) — `Toolbar.tsx:18-24`
- Both meet all three exception criteria: structural separator / simple geometry / `currentColor`

### Icon Sizing `evidence-type: file:line`

- `size-[24px]` button wrapping `size-[16px]` icon — confirmed on all three nav buttons
  - Evidence: `Toolbar.tsx:60-82` — Back, Forward, Refresh buttons all follow this pattern

### Prop API Conventions `evidence-type: file:line`

- Boolean props with defaults: `canGoBack = true`, `canGoForward = false`, `bookmarked = false`, `urlFocused = false` — `Toolbar.tsx:42-46`
- Optional callbacks: `onBack?`, `onForward?`, `onRefresh?`, `onBookmark?`, `onMore?`, `onChat?` — `Toolbar.tsx:33-38`
- ReactNode slot: `assistantButton?: ReactNode | null` — `Toolbar.tsx:32,134-148`
  - `undefined` → render default Chat button; `null` → render nothing; value → render that value

### Interaction State Pattern `evidence-type: file:line`

- Fully prop-driven, no local `useState` — all state externally controlled
- Disabled state: `disabled={!canGoBack}` + `opacity-30` class — `Toolbar.tsx:62-63,70-71`

### Typography `evidence-type: file:line`

- `HYQiHei:55S` — URLBar text (12px, `leading-[14px]`) — `Toolbar.tsx:103`
- `SF Pro` — Bookmark label and Chat label (12px) — `Toolbar.tsx:122,143`

### Color Usage `evidence-type: file:line`

- Nav icons: `text-[var(--color-text-secondary)]` — `Toolbar.tsx:66,74,81`
- URLBar text default: `text-[var(--color-text-tertiary)]` — `Toolbar.tsx:101`
- Dividers: `text-[var(--color-text-disabled)]` — `Toolbar.tsx:12,20`
- Bottom border: `bg-[rgba(0,0,0,0.08)]` — matches `--color-border-subtle` value — `Toolbar.tsx:88`

---

## Comparison Against Existing Inventory

### Rules correctly reproduced (all with matching evidence type)

| Rule | Inventory status | Capture result |
|---|---|---|
| SVG import pattern (`?react` vs regular) | confirmed standard | ✓ reproduced — `Toolbar.tsx:2-8` |
| Color baking rule | confirmed standard | ✓ reproduced — bookmark icon has baked `#FFCA28` |
| Structural inline SVG exception | confirmed standard (PR #34) | ✓ reproduced — NavDivider/RightDivider both qualify |
| Icon sizing (24×24 / 16×16) | confirmed standard | ✓ reproduced — all three nav buttons |
| Prop API conventions (boolean props, callbacks, ReactNode slot) | confirmed standard | ✓ reproduced — `Toolbar.tsx:26-54` |
| Interaction state pattern (prop-driven baseline) | confirmed standard | ✓ reproduced — no local state in Toolbar |
| Typography (HYQiHei:55S for input/URL, SF Pro for labels) | confirmed standard | ✓ reproduced — `Toolbar.tsx:103,122,143` |

### New findings — token audit (2026-04-27)

| Finding | Location | Classification | Action |
|---|---|---|---|
| URLBar focused text previously used `text-[#333]` instead of `text-[var(--color-text-primary)]` | pre-fix `Toolbar.tsx:101` | **implementation drift** — `#333` = `#333333` = `--color-text-primary` value | fixed in agentic-browser-ui PR #8 |
| URLBar focused border `rgba(31,99,237,0.25)` | `Toolbar.tsx:94` | **intentional component-specific** — semi-transparent tint of `--color-border-focus` (#1f63ed); no token at this opacity | document only |
| Bookmark active bg `rgba(255,202,40,0.12)` | `Toolbar.tsx:115` | **intentional component-specific** — tint of the baked bookmark icon color (#FFCA28); active-state visual feedback | document only |
| More button bg `rgba(255,255,255,0.12)` | `Toolbar.tsx:129` | **intentional component-specific** — subtle frosted-glass overlay; distinct from `--color-surface-overlay-white` (0.8 opacity) | document only |
| Chat button gradient `rgba(65,231,154,0.3)` → `rgba(106,181,255,0.3)` | `Toolbar.tsx:137` | **intentional component-specific** — AI branding gradient; no token equivalent expected | document only |

---

## Validation Conclusion

**Skill workflow: confirmed working.**

The code-backed capture mode successfully reproduced all major confirmed-standard rules from the existing inventory, with correct evidence types (`file:line` for all code-backed rules). The workflow followed the documented steps: read component file → extract rules → classify → assign evidence type.

**Token audit (2026-04-27):** five non-token color findings classified.
- One implementation drift fixed: `text-[#333]` → `text-[var(--color-text-primary)]` (agentic-browser-ui).
- Four intentional component-specific values documented; no token additions needed.

**Exit criterion met:** the capture run produced an evidence-backed reference that matches the existing inventory without re-reading Figma. The skill is validated for web/React projects.
