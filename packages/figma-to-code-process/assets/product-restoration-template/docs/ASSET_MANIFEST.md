# Asset Manifest

## Export Rules

- Export design-owned icons, widgets, screenshots, logos, and
  illustrations before wiring code that depends on them.
- Do not rebuild internal artwork in code unless it is an approved
  code-drawn primitive.
- Prefer SVG for theme-reactive icons when the source supports it.
- Prefer PNG for screenshots, widgets, composite illustrations, and
  assets with masks or complex raster content.
- Render size in code comes from the Figma component context, not from
  the exported file canvas alone.
- For Android, decide whether each asset is a vector drawable or a
  density-bucket raster resource, and verify it resolves in the packaged
  app on the named emulator/device profile.

## Assets

| Product Role | Figma Node | Format | Target Path / Resource Bucket | Render Size | Status | Notes |
|---|---|---|---|---|---|---|
| `[ROLE]` | `[NODE_ID]` | `[svg | png | vector drawable | webp]` | `[PATH_OR_ANDROID_BUCKET]` | `[W x H]` | `[existing export | new export required | no asset needed | approved code-drawn primitive]` | `[NOTES]` |

## External Content Boundaries

| Boundary | Source | Implementation Rule |
|---|---|---|
| `[BOUNDARY]` | `[NODE_ID_OR_URL]` | `[RULE]` |

## Asset Verification

- [ ] All required assets exist in the repo.
- [ ] Production build resolves asset paths.
- [ ] Android package/resource lookup resolves the intended density or
      vector resource when applicable.
- [ ] Rendered sizes match Figma context.
- [ ] No placeholder geometry remains for design-owned assets.
