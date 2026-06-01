# Example: Asset Inventory For A Small Control

Use this pattern when implementing a compact control such as a search input,
toolbar chip, bookmark item, pill, or icon button row.

## Workflow shape

1. Name the component boundary and the exact Figma node or board.
2. Classify each visual element before coding:
   - text and layout primitives;
   - design-owned icons/images that must be exported;
   - code-drawn primitives explicitly allowed by the source;
   - state-only elements such as clear buttons or active fills.
3. Export or locate real assets before writing substitute icon geometry.
4. Pin the root size when Figma gives an exact control frame.
5. Use non-layout-affecting strokes for exact-size state changes: `outline` or
   inset shadow instead of a border that changes inner geometry.
6. Verify the rendered control in both empty/default and populated/stateful
   conditions when the design has state-dependent affordances.

## Reusable lesson

A small component is often where process drift begins. The control may look
simple, but icons, 0.5px strokes, clear buttons, and hidden state affordances
still need the same preflight as a larger component.

## Closeout evidence

Record root size, icon slot size, icon-to-text gaps, state-specific elements,
asset paths, build command, and rendered verification surface.

