# Example: Canonical Source And Hidden Variants

Use this pattern when a screen instance differs from a formal component set, or
when a variant exists in Figma but is hidden.

## Workflow shape

1. Inspect the screen instance and the formal component set before coding.
2. Prefer the canonical component set when it exists and is current.
3. If only an instance is available, document the implementation as
   instance-derived and flag it for later correction.
4. For hidden variants, inspect metadata and sibling variants. Mark inferred
   structure explicitly instead of claiming visual verification.
5. If an exported asset is empty, check source visibility/fill before repairing
   it by hand. An empty export may be correct when the source fill is hidden.
6. Use rendered verification for visible variants and keep hidden/inferred
   variants in a separate risk bucket.

## Reusable lesson

The source hierarchy matters. A scaled screen instance can have different
geometry, radius, border, or effects from the canonical component. Hidden layers
can be valid state evidence, but they are not visual proof.

## Closeout evidence

Record the canonical source, any instance-derived fallback, hidden variant
status, asset visibility decisions, and which states were visually verified.

