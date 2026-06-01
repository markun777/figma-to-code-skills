# Tech Stack Profile

## Purpose

Before running a Figma-to-code workflow, define the target delivery
profile explicitly instead of letting the model guess the platform.

This profile should be available to all major skills, especially:

- `figma-capture-design-system`
- `figma-create-design-system-rules`
- `figma-implement-design`
- `figma-export-slices`
- `figma-verify-implementation`

## Required fields

- `target`
`web` | `ios` | `android`
- `framework`
Examples:
`react`
`vue`
`swiftui`
`uikit`
`compose`
`android-views`
- `token_format`
Examples:
`css-vars`
`tailwind-theme`
`swift-tokens`
`compose-tokens`
`android-xml-tokens`

## Recommended fields

- `design_system`
Example: `custom-ds`, `material-3`, `apple-hig-aligned`
- `component_source`
Example: `code-components`, `figma-library`, `mixed`
- `asset_profile`
Example export target or density rules per platform.
- `verification_surface`
Example:
`browser`
`storybook`
`ios-simulator`
`android-emulator`

## Why this matters

The same Figma design can translate very differently across platforms.

Examples:

- Web may map layout to flexbox, grid, CSS variables, and JSX.
- iOS may map layout to SwiftUI stacks, modifiers, and Apple platform
conventions.
- Android may map layout to Compose structures, modifiers, and Material
conventions.

Without an explicit profile, the model is forced to guess.

## Baseline export defaults

These are starting defaults, not hard rules for every project.

### Web

- preferred vectors: `svg`
- raster: `webp` or `avif`
- fallback raster: `png`

### iOS

- raster scales: `@1x`, `@2x`, `@3x`
- preferred vector where applicable: `pdf` or platform-appropriate vector
asset workflow
- fallback raster: `png`

### Android

- density buckets: `mdpi`, `hdpi`, `xhdpi`, `xxhdpi`, `xxxhdpi`
- preferred raster: `webp` when supported by the project
- fallback raster: `png`

## Workflow rule

If the tech-stack profile is missing and the target platform changes code
shape, asset output, or verification method, the workflow should ask for
the missing profile instead of inventing one.