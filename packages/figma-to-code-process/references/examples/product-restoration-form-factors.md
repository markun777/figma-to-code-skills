# Example: Product Restoration Across Form Factors

Use this pattern when restoring a product from Figma boards that include phone,
tablet, desktop, compact, expanded, light/dark, or other form-factor variants.

## Workflow shape

1. Create the product repo separately from the workflow repo.
2. Copy the product-restoration template into the product repo.
3. Complete the board/state map, layout constants, token snapshot, asset
   manifest, and interaction contract before UI code.
4. Record the shared token library and version as the default styling contract.
5. Treat each form factor as its own board when the composition differs. Do not
   stretch one layout to approximate another.
6. Treat OS/system UI drawn in the design as safe-area or inset annotation unless
   the product explicitly owns that chrome.
7. Verify on the target surface for that platform. Build success alone does not
   prove visual correctness.

## Reusable lesson

Shared tokens do not imply shared layout. A phone and a tablet screen can share
the same semantic colors and spacing system while requiring separate
implementation and verification passes.

## Closeout evidence

Record form-factor-specific source nodes, runtime profiles, density or scaling
assumptions, exported assets, token source annotations, build command, and
rendered comparison evidence.

