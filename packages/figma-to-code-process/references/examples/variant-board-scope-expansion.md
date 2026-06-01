# Example: Variant Board And Scope Expansion

Use this pattern when a component starts from one formal slice and later expands
to optional controls, item counts, more menus, manage actions, or other axes.

## Workflow shape

1. Start with a scope note that names the initial source node, component
   boundary, intended states, assets, verification surface, and exclusions.
2. Before adding an optional axis, rerun preflight for that expansion:
   - source Figma node or board;
   - new asset inventory;
   - state-geometry scan;
   - implementation prop or branch;
   - verification case.
3. Keep optional controls as explicit slots or props. Do not smuggle a new
   control into the closed component without documenting the new axis.
4. Verify both the original slice and the expanded variant board after the
   change.

## Reusable lesson

A follow-up axis is a new small case, not a free patch. Treat optional controls
and expanded variant boards as their own preflight so the implementation does
not outgrow the source evidence.

## Closeout evidence

Record which axes are formal, which are deferred, and which implementation
branches or props cover each verified variant.

