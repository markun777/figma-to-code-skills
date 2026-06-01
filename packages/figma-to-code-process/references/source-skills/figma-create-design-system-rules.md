# figma-create-design-system-rules

## Goal

Generate or extend an implementation-oriented rule set when a project does
not already have a complete usable spec. The output is an editable draft
for human review — not a final spec to implement against directly.

## When to use

- A project has no formal design-system rules and implementation is about
  to start.
- A spec exists but does not cover enough detail to implement safely
  (missing token values, undefined component states, etc.).
- A draft rule set needs to be extracted from Figma for human review
  before implementation begins.

## When not to use

- A strong existing spec already covers the implementation target — use it
  directly and skip this skill.
- The task is only to capture undocumented rules that already exist in the
  team's heads — use `figma-capture-design-system` instead.

## Required context

- Tech-stack profile (`target`, `framework`, `token_format` — see
  `inventory/tech-stack-profile.md`).
- Existing spec status: what is already documented vs. what is missing.
- Target Figma design context (file key, relevant frames or components).

## Inputs

- Figma frames or components to extract rules from.
- Any existing design-system notes or partial spec.
- Tech-stack profile.
- Known project conventions (naming, token format, component API style).

## Outputs

- Editable rule draft covering: layout, spacing, typography, color,
  component structure, and implementation conventions.
- Inferred patterns extracted from the Figma design.
- Explicit list of unknowns or low-confidence inferences, marked clearly.
- Candidate mapping of confirmed rules into Figma foundations:
  which items should become `Variables`, which should become reusable
  `样式`, and which should stay provisional until reviewed.
- **Required component-scoped output:** when a component family boundary is
  clear enough to define before implementation, produce a `Component
  Family Definition` card as the first output. Use the template at
  `inventory/component-family-definition-template.md`. This is the formal
  output format for component cases in this repo. The card must be
  produced before implementation begins, not reconstructed after.

## Workflow

1. Confirm the tech-stack profile. If `target`, `framework`, or
   `token_format` are missing, ask before proceeding — rules are
   platform-specific.
2. Decide whether the task is component-scoped and whether the component
   family boundary is clear enough to define safely.
3. If the family boundary is clear, produce a `Component Family
   Definition` card first (template:
   `inventory/component-family-definition-template.md`). Fill
   `definition_status` and `verification_status` independently for every
   state row. For composite families, write the root card plus any
   independently reusable or independently verifiable sub-family cards.
   Hand the card to the user or team for review before proceeding.
4. If the family boundary is not clear enough yet, say why and continue
   with a broader editable rule draft instead of forcing the wrong card
   granularity.
5. Check whether an existing spec already covers the needed scope. If it
   does, identify only the gaps rather than regenerating the whole spec.
6. Call `figma` skill tools to read the target frames and components:
   - `get_design_context` for layout, component structure, and code hints.
   - `get_variable_defs` for token values (colors, spacing, typography).
   - `get_metadata` if the node tree structure is needed to understand
     component hierarchy.
7. Extract patterns from the design context. For each inferred rule,
   classify it as:
   - **Confirmed**: directly readable from the design (e.g. a token value,
     a consistent spacing unit).
   - **Inferred**: a repeated pattern that looks like a rule but has not
     been confirmed by the team.
   - **Unknown**: a gap where the design does not provide enough
     information.
8. Produce the rule draft from the context collected in step 6. Mark all
   inferred rules as provisional. List all unknowns explicitly at the end.
   If `create_design_system_rules` is available in the session, use it as
   a supplemental template or structural reference — it does not consume
   the node-specific context directly, so the primary draft must come from
   `get_design_context` and `get_variable_defs`.
9. Split the draft into three buckets before handing it off:
   - **Candidate variables**: stable token-like decisions such as color,
     spacing, radius, sizing, and semantic text/surface values.
   - **Candidate styles**: reusable text, effect, or stroke treatments
     that should be directly reusable in Figma.
   - **Remain provisional**: repeated patterns that still need human
     naming or semantic confirmation.
10. Hand the draft to the user or team for review before passing it to
   `figma-implement-design` or `figma-verify-implementation`.
11. If the workflow adds new provisional validation states in Figma to fill
   a missing-state gap, get explicit user or team confirmation on those
   provisional cards before treating them as implementation-ready rules.
   Until confirmed, keep them in the provisional bucket.
12. If the team confirms that a provisional state is meant to become the
   canonical component state, mark it for promotion back into the formal
   component area. Do not plan to keep the provisional card and the
   formal component as long-lived parallel sources of truth.

## Clarification policy

Ask before proceeding when:
- The tech-stack profile is missing and it changes implementation
  conventions (e.g. CSS vars vs Tailwind theme vs Swift tokens).
- The component family boundary is ambiguous enough that a `Component
  Family Definition` card would likely be drawn at the wrong granularity.
- An inferred rule may conflict with a known project standard — ask which
  takes precedence.
- A repeated visual pattern might be a one-off exception rather than a
  true rule — ask before promoting it to a standard.
- The design suggests that the product needs extra interaction states, but
  the formal component board does not show them completely — ask which
  states are required before turning them into candidate rules.
- New provisional validation cards were added in Figma to fill a missing
  state gap — ask whether those cards are approved before passing them to
  implementation.
- A provisional state has already been approved and implementation is
  about to depend on it, but it is still unclear whether the team wants
  it promoted back into the formal component area after validation.

Do not ask when:
- A rule is directly readable from a token value or a consistent pattern
  across multiple components.
- The gap is acknowledged and will be listed as unknown — record it and
  move on.

## Gotchas

- Do not replace a valid existing spec with a guessed one. Preserve
  confirmed rules and only fill the gaps.
- Do not silently promote accidental visual repetition into a standard.
  Two components that look similar may have different intended rules.
- Keep inferred rules explicitly provisional in the output. The draft is
  for human review — it is not ready to implement against directly.
- Token values extracted from `get_variable_defs` are authoritative.
  Values inferred from screenshots or pixel inspection are not — mark them
  as low-confidence.
- Platform-specific rules must stay separated. Do not merge web and iOS
  conventions into a single rule.
- Do not write guessed tokens or guessed style names directly into the
  canonical library. This skill should identify candidate foundations,
  not silently finalize them.
- Do not silently promote a product-layer interaction need into the
  canonical component rules. If the product needs states beyond the formal
  component board, capture them as provisional candidates until the team
  confirms them.
- Common product patterns may be used to suggest candidate interaction
  states when the board is incomplete, but those suggestions must remain
  provisional until confirmed.
- Do not let approved provisional states linger indefinitely as a second
  component source of truth. Once the team confirms that a provisional
  state is the intended canonical state, plan its promotion back into the
  formal component area and retire or archive the provisional copy.
- Do not keep calling new live component-family cards `trial-run` or
  `controlled trial-run`. Those labels only apply to historical
  validation samples under `experiments/`.
- In a `Component Family Definition` card, never use a single combined
  status column. `definition_status` and `verification_status` are
  independent dimensions — a state can be `provisional-proposal` and
  `visual-verification-complete` at the same time. Conflating them causes
  downstream skills to misread "verified" as "formally approved".

## Verification

- The rule set is profile-aware and references the correct platform
  conventions.
- Existing confirmed rules are preserved, not overwritten.
- Inferred rules are specific enough to guide implementation.
- All inferred rules are marked as provisional.
- Unknowns and low-confidence inferences are listed explicitly.
- The draft clearly distinguishes candidate `Variables`, candidate
  `样式`, and unresolved items.
- For component-scoped work with a clear family boundary, a `Component
  Family Definition` card is present as the first output, or the reason
  for skipping it is stated explicitly.
- Any approved provisional state that is meant to become canonical is
  explicitly marked for formal-component promotion rather than left as a
  permanent parallel version.
