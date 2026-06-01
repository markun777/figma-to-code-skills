# figma-capture-design-system

## Goal

Turn undocumented design-system knowledge into an explicit, reusable
implementation reference. Two capture modes are supported:

- **Interview mode** — extract rules by interviewing the user or team.
  Use when rules live in people's heads and no code base exists yet.
- **Code-backed mode** — extract rules by inspecting existing implementation
  code. Use when the project already has components and the rules are
  implicit in the code rather than written down.

Run this skill before broad implementation work starts on a partially
documented system.

## When to use

- A project already has design rules, but they are mostly implicit or
  spread across team members' heads. *(interview mode)*
- Implementation quality depends on team knowledge that is not written
  down anywhere. *(interview mode)*
- A new contributor (human or agent) is about to implement against a
  design system they have not seen before. *(either mode)*
- The project has existing implementation code that encodes design rules
  implicitly — no interview is needed, but the rules must be extracted
  from code before implementation can proceed safely. *(code-backed mode)*

## When not to use

- A complete, high-quality spec already exists — use it directly.
- The main problem is messy Figma structure rather than missing team
  knowledge — use `figma-use` to normalize the file first.

## Required context

- Tech-stack profile (`target`, `framework`, `token_format` — see
  `inventory/tech-stack-profile.md`).
- Project or product scope (which surfaces, which components).

## Inputs

- Tech-stack profile.
- **Interview mode:** team answers from interview or structured prompts;
  any existing docs, component notes, or code references the team can
  point to.
- **Code-backed mode:** existing codebase — component files, token
  definitions (e.g. `index.css`), asset directory, build output.

## Outputs

- Explicit rule summary covering tokens, components, layout conventions,
  and naming.
- Implementation conventions per platform where they differ.
- Clarified component expectations (states, variants, edge cases).
- List of unresolved questions or gaps — visible, not smoothed over.
- **Code-backed mode additionally:** evidence taxonomy per rule, using
  three evidence types validated on web/React projects (see note below):
  - `file:line` — direct code reference (specific file and line number)
  - `pattern-compliance` — rule inferred from consistent pattern across
    multiple files
  - `canvas-rule` — Figma canvas structure rule; no code file:line
    evidence exists by nature

> **Note:** the three-type evidence taxonomy above was validated on a
> web/React project (agentic-browser-ui, Vite + TypeScript + Tailwind v4).
> It is not automatically applicable to iOS, Android, or other targets —
> adapt evidence types to the platform's verification surface before
> applying to non-web projects.

## Workflow

### Interview mode

1. Confirm the tech-stack profile. If `target`, `framework`, or
   `token_format` are missing, ask for them before proceeding — the
   interview questions branch by platform.
2. Confirm the project scope: which surfaces and components are in scope
   for this capture session.
3. Run the interview. Cover these areas in order, branching by platform:
   - **Tokens**: colors, spacing, typography, radius, shadow — how are
     they defined and consumed? (CSS vars, Tailwind theme, Swift tokens,
     Compose tokens, etc.)
   - **Components**: which components exist, what variants and states do
     they have, what are the edge cases?
   - **Layout conventions**: grid, breakpoints, spacing rules, alignment
     patterns.
   - **Naming**: file naming, layer naming, class/token naming conventions.
   - **Platform-specific rules**: anything that only applies to one target
     (e.g. SF Symbols on iOS, Material alignment on Android, utility-class
     conventions on web).
4. For each answer, classify it as: confirmed standard, tentative
   preference, or unresolved gap. Do not collapse these into one category.
5. Produce the implementation reference. Separate platform-specific
   sections where the rules differ. List unresolved gaps at the end.
6. Hand the reference to `figma-create-design-system-rules`,
   `figma-implement-design`, or `figma-verify-implementation` as the next
   step.

### Code-backed mode

1. Confirm the tech-stack profile. If `target`, `framework`, or
   `token_format` are missing, read them from the codebase before
   proceeding.
2. Confirm the project scope: which components and token files are in
   scope for this capture session.
3. Inspect the codebase. Cover these areas in order:
   - **Token definitions**: read the token source file (e.g. `index.css`,
     `theme.ts`) — extract all defined tokens and note which are actually
     consumed by components.
   - **Component files**: read each component file — extract prop API
     conventions, state patterns, layout patterns, and asset import
     patterns.
   - **Asset directory**: list exported assets — infer naming convention
     and import pattern from the directory and import sites.
   - **Build output / config**: check `tailwind.config.*`, `vite.config.*`,
     or equivalent — confirm token format and utility-class conventions.
4. For each extracted rule, classify it as: confirmed standard, tentative
   preference, or unresolved gap. Assign an evidence type per rule:
   - `file:line` for rules with a direct code reference
   - `pattern-compliance` for rules inferred from consistent patterns
     across multiple files
   - `canvas-rule` for Figma canvas structure rules with no code evidence
5. Produce the implementation reference with evidence pointers. List
   unresolved gaps at the end.
6. Hand the reference to `figma-create-design-system-rules`,
   `figma-implement-design`, or `figma-verify-implementation` as the next
   step.

## Clarification policy

Ask follow-up questions when:
- A rule is described differently for different platforms — ask which
  platform the rule applies to and whether the others have a different
  rule.
- A team member describes a taste or preference ("we like it to feel
  light") rather than an enforceable standard — ask what the concrete
  implementation rule is.
- Component behavior is implied but not clearly defined (e.g. "the button
  has a hover state" without specifying the exact visual change) — ask for
  the specific value or behavior.
- The product appears to need interaction states that the current
  component board does not fully show (e.g. hover-close, focus, pressed,
  disabled, error, loading) — ask which states are truly required and
  whether they belong in a provisional validation layer.

Do not ask when:
- The rule is already specific and platform-unambiguous.
- The gap is acknowledged and will be listed as unresolved — record it
  and move on.

## Gotchas

- Do not collapse platform-specific rules into a fake universal rule.
  Web flex conventions are not the same as SwiftUI stack conventions even
  if they look similar at a glance.
- Do not treat a loose preference as a hard standard. Mark it as
  tentative and flag it for the team to confirm.
- Capture unresolved differences instead of smoothing them over. A hidden
  gap will surface as a bug during implementation.
- If the team has existing code, ask to see a representative component
  file — actual code reveals conventions that people forget to mention in
  interviews.
- Do not assume that common product affordances belong in the canonical
  component set just because they are common elsewhere. Confirm whether a
  missing interaction state is intentionally absent, or should be added as
  a provisional validation state first.
- Common interaction patterns can help you propose candidate missing
  states, but only as provisional interview material until the team
  confirms them.

## Verification

- The captured rules are specific enough to guide implementation without
  further guessing.
- Platform-specific conventions are separated where the platforms differ.
- Unresolved gaps are listed explicitly at the end of the reference.
- No tentative preference has been promoted to a hard standard without
  explicit team confirmation.

## Platform notes

The interview flow branches by `target` from the tech-stack profile.

- **web**: CSS token format, utility-class conventions (Tailwind, CSS
  modules, etc.), component API patterns, breakpoint rules.
- **ios**: Apple platform conventions, SF Symbols usage, SwiftUI vs UIKit
  token mapping, safe area and dynamic type handling.
- **android**: Material alignment, Compose vs XML token mapping, density
  bucket rules, adaptive layout conventions.
