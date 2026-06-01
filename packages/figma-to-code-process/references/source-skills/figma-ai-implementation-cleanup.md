# figma-ai-implementation-cleanup

## Goal

Reduce noise in a messy Figma file so that later rule extraction and code
implementation are more stable. This skill cleans the canvas — it does not
redesign the product.

## When to use

- The design file has inconsistent layer naming, hidden legacy frames, or
confusing structure that makes implementation unreliable.
- Implementation quality is suffering because the Figma file is too noisy
to read programmatically.
- You are about to extract design-system rules from a draft that has no
clean structure yet.

## When not to use

- The file is already clean and implementation-ready — skip directly to
`figma-implement-design`.
- The user only needs direct implementation from a trusted spec with no
structural issues.

## Required context

- Figma file key or URL, and the target page or frame scope.
- Cleanup goal: what problem is the noise causing downstream?
- Optional: tech-stack profile if naming or structure should align with a
delivery platform's conventions.

## Inputs

- Active frames or target pages to clean.
- Known problem patterns (e.g. "there are 12 hidden legacy frames",
"layer names are all 'Frame 1'").
- Optional: examples of what should be treated as current vs. legacy
content.

## Outputs

- Cleaner layer structure with consistent naming and grouping.
- Hidden or legacy content separated or removed.
- Reduced ambiguity in the implementation surface.
- A summary of what was changed and what was left intentionally untouched.

## Workflow

1. Read the target scope. Call `get_metadata` on the target page or frame
  to get the current layer tree. Do not read the entire file — scope to
   the cleanup target.
2. Identify active design content vs. noise. Look for: hidden layers,
  frames with generic names ("Frame 1", "Copy of…"), duplicate or
   near-duplicate components, detached instances, and legacy pages.
3. Before making any destructive change (delete, rename, restructure),
  confirm the scope with the user if the content could still be
   meaningful. See Clarification policy.
4. Apply changes via `figma-use`. Work in small, targeted batches — one
  category of cleanup at a time (e.g. rename all generic frames, then
   hide legacy content, then remove confirmed dead layers).
5. After each batch, call `get_screenshot` or `get_metadata` on the
  affected area to verify the change landed correctly.
6. Produce a summary of what was changed, what was left, and any
  remaining ambiguity. Hand the cleaned file reference to
   `figma-create-design-system-rules` or `figma-implement-design`.

## Clarification policy

Ask before proceeding when:

- It is unclear which frames are active vs. historical — ask the user to
identify the current design target before touching anything.
- A layer or frame might still be meaningful even though it looks like
noise (e.g. a hidden frame that could be a WIP variant) — ask before
deleting or restructuring it.
- The cleanup scope is ambiguous ("clean up the file" without a specific
page or frame) — ask for a specific target.

Do not ask when:

- The layer is confirmed hidden and has a name that clearly marks it as
legacy (e.g. "OLD - do not use").
- The change is purely additive (e.g. renaming a generic layer to a more
descriptive name without removing anything).

## Gotchas

- Do not over-clean. Removing meaningful variants or one-off exceptions
during cleanup will cause implementation to miss real design states.
- Do not convert one-off exceptions into shared standards during cleanup.
Cleanup prepares the file for implementation — it does not redesign the
product.
- Renaming layers in a component affects all instances. Confirm scope
before renaming inside a master component.
- Hidden layers are not the same as deleted layers. If in doubt, hide
rather than delete — the user can confirm deletion later.
- `figma-use` executes JavaScript via the Plugin API. Verify each batch
of changes before moving to the next one.

## Verification

- The active implementation target is easier to identify after cleanup
than before.
- Legacy and hidden noise is reduced without removing meaningful content.
- Repeated patterns are easier to read without losing necessary detail.
- A summary of changes exists so the user can review what was touched.