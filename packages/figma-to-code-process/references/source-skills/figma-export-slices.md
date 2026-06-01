# figma-export-slices

Working folder for the Figma export slices skill.

## Required context

- tech-stack profile
- asset profile

## Key rule

Asset export settings should be platform-aware.

Implementation rule:

- If the design depends on real icons, raster images, or slices, route
  them through this asset workflow instead of substituting placeholders,
  fake SVGs, or ad hoc CSS shapes.
- All icon resources should default to this workflow. Prefer exporting
  the real asset as `svg` first, then fall back to raster exports only
  when SVG is not viable for the target platform or the source asset.
- Export and name the real asset first, then wire the code to that
  asset. Use a semantic repo-facing name based on the icon's role in the
  component, not the raw Figma layer name.
- Once the exported source-file icon exists in the repository, that file
  becomes the required geometry source for implementation. Do not keep,
  add, or refine a handwritten substitute SVG for the same icon after
  export.
- Treat the exported file's canvas size as packaging data, not as the
  rendered size contract. Before implementation, also inspect the icon's
  parent frame and visual bounds in Figma so code matches the in-component
  geometry, not just the raw SVG width and height.

Examples:

- web: prefer `svg` for icons, plus modern raster formats when needed
- iOS: support scale-based exports such as `@1x`, `@2x`, `@3x`
- Android: support density buckets such as `mdpi` through `xxxhdpi`

## Gotchas

- Figma CDN image URLs returned by `get_design_context` and related tools are
  temporary signed links. They expire and must not be used as asset sources in
  code. Always export the asset through this workflow and commit it to the
  repository before wiring it into the implementation.
- Some Figma components are built from multiple vector sub-nodes (e.g. an X
  icon made of two separate rotated strokes). Exporting a single sub-node
  produces an incomplete asset. Inspect the component structure first and
  compose a single complete SVG from all constituent paths before committing
  the asset.
- After exporting an SVG, inspect its stroke and fill values before wiring
  it into code. If the values are hardcoded design-system colors (e.g.
  `#333333`, `#999999`, `#cccccc`) the icon needs color theming and must be
  inlined as an SVG component with `currentColor` — do not use `<img>`.
  Only use `<img>` for icons whose colors are intentionally fixed (e.g. a
  white arrow on a colored button, a brand logo). This check must happen at
  export time, not after the component is already wired.
- When inlining SVG into JSX, replace all `stroke` and `fill` color values
  with `currentColor` and control the color via a CSS class on the SVG
  element. Do not use `<img>` for icons that need color theming —
  `img` does not inherit CSS `color`.
- Exported asset dimensions are not the source of truth for final icon
  sizing. Figma may wrap a small glyph inside a larger export canvas or icon
  frame. Record the asset's in-component geometry (container size, icon-frame
  size, and visual glyph bounds) before implementing it, otherwise the icon
  will be rendered too large or too small in code.
- Do not carry ambiguous raw layer names such as `ic_`, `icon`, `Group 12`,
  or `Frame 1` into the repository as final asset names. Inspect the glyph in
  its component context, rename the export to a semantic product-facing name,
  and keep the node-id mapping separately if traceability is still needed.
- If an exported SVG contains a `<mask>` element with `fill="white"` paired
  with a path that uses `fill="currentColor" mask="url(...)"`, the icon was
  built as a `BOOLEAN_OPERATION` with an inside stroke in Figma. Replacing
  `#333333` with `currentColor` on the mask path will not work — the white
  mask fill renders as a solid block in most contexts. Fix by rewriting the
  path as `fill="none" stroke="currentColor" stroke-width="1"` (or the
  correct stroke width from Figma). Verify the result visually before
  committing.
