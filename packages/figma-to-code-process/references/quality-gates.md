# Quality Gates

Reusable gate patterns for Figma-to-code implementation repos. Adapt the
command names and paths to the target repository.

## Available gates

```text
<project gate command>                # run all configured checks
<empty-svg gate command>              # SVG geometry check only
<external-url gate command>           # external URL check only
<banned-asset gate command>           # banned/legacy asset usage check only
```

## gate:empty-svgs

**What it catches:** SVG files in `src/assets/figma/` with no visible geometry
(no path, circle, ellipse, rect, polygon, polyline, or line elements).

**Why it matters:** Figma can export an ellipse node as an empty SVG group when
the fill is `visible=false`. Without this gate, an agent may misread the empty
export as a missing asset and hand-author geometry that should not exist.

**Exemption:** Add a `"note"` to the asset's entry in `slices-name-map.json`
explaining why the empty SVG is intentional. The gate will print `[ok-exempt]`
and pass.

**When to run:** After every new SVG export from Figma.

## gate:banned-assets

**What it catches:** Source files that import or reference assets whose
`slices-name-map.json` note contains `must not render`, `visible=false`,
`legacy/unused`, or similar keywords.

**Why it matters:** An asset can have visible geometry but still be banned from
rendering when the source layer is hidden, deprecated, or explicitly marked as
not part of the product state. `gate:empty-svgs` may pass after a later edit
adds geometry back to the file, so a separate banned-asset gate is still needed.

**Exemption:** Remove the `must not render` / `visible=false` language from the
`slices-name-map.json` note only if the asset is genuinely re-enabled by a
confirmed Figma source change.

**When to run:** Before opening any PR that adds or modifies asset imports.

## gate:external-urls

**What it catches:** External `http/https` image URLs in `src/**/*.tsx` used as
`src=`, `appIconSrc=`, or `href=` prop values. Also catches Figma MCP asset
URLs (`figma.com/api/mcp/asset/`) which are short-lived and must not be
committed.

**Why it matters:** External URLs in verify/demo cards can be blocked by browser
ORB policy, making the verify card silently invalid (image loads as 0×0,
`naturalWidth=0`). The verify surface appears to work but proves nothing.

**Exemption:** Add `// allow-external-url` as a comment on the same line if the
external URL is intentional and the ORB risk is accepted.

**When to run:** Before opening any PR that adds or modifies verify/demo cards.

## Process rule

All configured gates should pass before a case is marked closed. Record the
gate command and result in the closeout or verification artifact:

| Check | Status |
|---|---|
| `<project gate command>` | passed |
