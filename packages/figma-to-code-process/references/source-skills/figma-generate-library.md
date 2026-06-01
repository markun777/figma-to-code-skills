# figma-generate-library

## Goal

Turn confirmed design-system rules into explicit Figma foundations:
variables, reusable styles, and library-ready component structure.

Use this skill after rule capture or rule drafting has already identified
what is stable enough to formalize.

## When to use

- A project has confirmed token decisions that should be stored in Figma
  as `Variables`.
- Reusable text, effect, or stroke treatments should be promoted into
  shared `样式`.
- A component board is mature enough that its variants, naming, and
  state model should be normalized into a library shape.

## When not to use

- The project is still in the rough rule-drafting phase and naming is not
  yet confirmed.
- The task is only to analyze or implement a single screen.
- The candidate token or style values are still guesses from a messy
  draft.

## Required context

- Tech-stack profile (`target`, `framework`, `token_format`).
- Confirmed naming decisions for tokens or styles, or a clear list of
  provisional items that must not be promoted yet.
- Relevant Figma page, component board, or node references.

## Inputs

- Reviewed output from `figma-create-design-system-rules` or
  `figma-capture-design-system`.
- Existing library structure in Figma, if any.
- Target variables/style naming scheme.
- Components that should bind to the new foundations.

## Outputs

- Figma `Variables` collections for stable tokens.
- Figma `样式` for stable reusable presentation rules.
- Updated or new library-ready component structure and bindings.
- Clear separation between confirmed foundations and provisional
  candidates.

## Workflow

1. Confirm the tech-stack profile and the naming scheme for tokens and
   styles.
2. Inspect the current file before creating anything:
   - existing variable collections
   - existing styles
   - existing component sets and naming
3. Take the reviewed rule draft and split it into:
   - **Promote now**: confirmed foundations ready for `Variables` or
     `样式`
   - **Hold provisional**: items that still need naming or semantic
     confirmation
4. Create or update `Variables` for token-like foundations first:
   color, spacing, radius, sizing, semantic text/surface tokens, and
   other reusable primitive decisions.
5. Create or update reusable `样式` for presentation-level rules next:
   text styles, effect styles, and stroke styles that should be applied
   consistently in the file.
6. Inspect representative components for existing variable bindings or
   external aliases before rebinding anything broadly.
7. Decide the binding policy explicitly:
   - **Preserve** external aliases when they are authoritative and
     already aligned with the project system.
   - **Remap** to local foundations when the new local variables are the
     intended source of truth.
   - **Bridge** temporarily when the file is mid-migration and both
     systems must coexist for a while.
8. Only after steps 4 through 7 are stable, bind or rebuild components
   against those foundations.
9. Start with the cleanest first-wave targets:
   - components whose fills, strokes, spacing, or radius already map
     cleanly to the new local variables
   - avoid brand-heavy or semantically unresolved components in the
     first pass
10. If component-state supplementation is needed during library work,
   place it in a clearly labeled `provisional` validation board rather
   than mutating the canonical component board by default.
11. Verify the resulting library structure, then hand it back for review
   or downstream implementation.

## Clarification policy

Ask before proceeding when:
- A token naming decision changes semantics across platforms.
- Two repeated styles look similar but may represent different semantic
  roles.
- A component appears library-ready visually, but its variant naming or
  state model is still unclear.
- A component already references external variable aliases and rebinding
  it would change the file's source of truth.

Do not ask when:
- A reviewed rule draft already marks an item as confirmed and names it
  explicitly.
- The task is a low-risk additive promotion into a provisional validation
  area.

## Gotchas

- Do not promote guessed values from a messy draft directly into
  canonical `Variables` or `样式`.
- Promote primitives before component bindings. Otherwise components may
  hardcode values that should have become tokens.
- Do not blindly replace external aliases with local variables. Decide
  whether those aliases should be preserved, remapped, or bridged first.
- A visually tidy component board is not enough to prove full library
  readiness. Check variables, naming, and state coverage too.
- When a supplemental test area grows beyond its parent board, move it to
  a standalone validation board on the same page instead of stretching or
  overlapping the formal artboards.
- Large components often need multi-row validation layouts. Reflow the
  board before shrinking component content.
- Favor a low-risk first binding wave. Components like large input
  surfaces are often better early targets than accent-heavy or
  brand-driven icons.

## Verification

- Stable foundations are stored as `Variables` or reusable `样式`.
- Provisional items are still clearly separated from confirmed library
  assets.
- The binding policy for local variables vs external aliases is explicit.
- Components bind to the new foundations instead of hardcoded values
  where appropriate.
- Supplemental validation boards fit within their own frames and do not
  overlap formal artboards.
