# Product Restoration Gotchas

Lessons from completed product restoration loops. Copy relevant items
into your product repo's `docs/PROGRESS.md` or PR notes.

---

## browser-ai-tools-product (2026-05-20)

Source: Figma file `brmnTFUvvtOb0lMkOcIJS1`, section `66:7890`.
Framework: Vite + vanilla JS/CSS.

### Asset pipeline

**PNG icons exported from Figma may have wrong node IDs if you use the
inner vector instead of the wrapper frame.**
The `_export` boundary in Figma is the wrapper frame node, not the inner
path or group. If you export the inner node, you get a cropped or
misaligned asset. Always export the `icon/..._export` or
`image/..._export` wrapper node.

**Figma section `66:7890` mixes product-state boards with repeated
generic layer names (`主动推荐` appears twice).**
Rename boards to stable `screen/` names in Figma before starting
implementation. Canonical names prevent confusion when referencing nodes
in code comments and docs.

**SVG icons exported from Figma may use `currentColor` fill but render
black without an explicit CSS color.**
Always set `color` on the icon's container or use a `text-*` Tailwind
class. Do not assume the parent's color cascades correctly — verify in
the browser.

### Layout

**Panel open/close causes layout shift if the content area uses a fixed
pixel width.**
Use `flex-grow` on the content area and fixed widths only on the AI
panel (400px) and side rail (48px). This matches the Figma layout model
and avoids reflow artifacts.

**The browser shell is 1600×1000px — do not scale it to viewport.**
The Figma source is a fixed-size desktop frame. Implement at 1600×1000
and let the outer page scroll or clip. Do not use `100vw`/`100vh` unless
the product explicitly targets responsive layout.

### Interaction model

**Proactive recommendation state is tab-switch-triggered, not
time-triggered.**
The recommendation appears only after switching from the new-tab tab to
the Medium tab. Do not implement a timer or scroll trigger. The Figma
board `42:3895` shows the state after the tab switch, not a timed popup.

**Process close vs. pin are independent.**
Closing a running process removes its toolbar icon. A pinned shortcut
for the same tool remains. These are two separate data axes (`processes`
and `pinnedToolIds`). Do not conflate them.

**Live external content (Medium) must not be rebuilt as local static
cards.**
The Figma board marks the Medium content area as
`external-content/medium.com-live-site`. Implement as an `<iframe>` or
link, not as local mock cards. Rebuilding the feed as static content
creates a maintenance burden and misrepresents the product surface.

### Design tokens

**Hardcoded colors in CSS will drift from the Figma source.**
Extract all colors into CSS custom properties (`--color-*`) before
implementing component-level styles. A single token migration pass early
is cheaper than hunting down drift later.

### Handoff cleanup

**Temporary debug/demo UI is easy to leave in production accidentally.**
After implementation, grep for `debug`, `demo`, `seed`, `skeleton`,
`test-control`, and `fixture` strings in `src/` and `dist/`. Remove any
that are visible in the production-facing page. Keep evidence in docs or
PR notes.

**`npm run build` alone is not sufficient handoff evidence.**
Also run the production preview (`npm run preview` or equivalent) and
verify that key asset paths resolve with `--noproxy`. A build that
passes locally may still have broken asset paths in the production
package if `public/` assets are referenced with wrong relative paths.
