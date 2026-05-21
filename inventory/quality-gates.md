# Quality Gates

Executable checks for `agentic-browser-ui`. Run before opening a PR or after
exporting new assets.

## Available gates

```
npm run gate               # run both checks
npm run gate:empty-svgs    # SVG geometry check only
npm run gate:external-urls # external URL check only
```

## gate:empty-svgs

**What it catches:** SVG files in `src/assets/figma/` with no visible geometry
(no path, circle, ellipse, rect, polygon, polyline, or line elements).

**Why it matters:** Figma can export an ellipse node as an empty SVG group when
the fill is `visible=false`. Without this gate, an agent may misread the empty
export as a missing asset and hand-author geometry that should not exist.
*(Incident: UpgradeDialog `upgrade-fail-circle` — ellipse fill was hidden, but
the empty SVG was restored as a pink circle.)*

**Exemption:** Add a `"note"` to the asset's entry in `slices-name-map.json`
explaining why the empty SVG is intentional. The gate will print `[ok-exempt]`
and pass.

**When to run:** After every new SVG export from Figma.

## gate:external-urls

**What it catches:** External `http/https` image URLs in `src/**/*.tsx` used as
`src=`, `appIconSrc=`, or `href=` prop values. Also catches Figma MCP asset
URLs (`figma.com/api/mcp/asset/`) which are short-lived and must not be
committed.

**Why it matters:** External URLs in verify/demo cards can be blocked by browser
ORB policy, making the verify card silently invalid (image loads as 0×0,
`naturalWidth=0`). The verify surface appears to work but proves nothing.
*(Incident: BookmarkItem Wikimedia URLs — blocked by ORB, app favicon variants
were never actually verified.)*

**Exemption:** Add `// allow-external-url` as a comment on the same line if the
external URL is intentional and the ORB risk is accepted.

**When to run:** Before opening any PR that adds or modifies verify/demo cards.

## Process rule

Both gates should pass before a component case is marked `closed` in its case
card. Add a `gate` row to the Verification Status table:

| Check | Status |
|---|---|
| `npm run gate` | passed |
