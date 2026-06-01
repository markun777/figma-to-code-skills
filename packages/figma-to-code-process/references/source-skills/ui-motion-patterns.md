# ui-motion-patterns

## Goal

Add lightweight, reusable web UI motion rules and templates that support
product feedback without changing the resting design. Use this skill to
translate common interaction motion into project-native CSS/JavaScript or
framework-local state, while preserving the Figma-to-code source of truth.

## When to use

- A web implementation needs interaction motion for tabs, dropdowns,
  modals, panels, card resize, card hover, badges, icon swaps, text
  swaps, number changes, or page transitions.
- A Figma-to-code case needs motion guidance after the static design,
  asset, and geometry gates are already satisfied.
- A project needs copy-adaptable CSS/JS motion templates that can be
  rewritten into its own tokens, classes, and component APIs.
- A team wants a reusable motion standard rather than one-off animation
  snippets scattered through components.

## When not to use

- The target platform is not web, unless a separate platform-specific
  motion profile is provided.
- The design source has not defined or confirmed the interaction state
  that would trigger the motion. Use the normal provisional-state
  approval flow first.
- The interaction requires advanced sequencing, scroll-linked animation,
  physics, gestures, or timeline orchestration that justifies a dedicated
  animation library such as GSAP, Framer Motion, or Motion One.
- The task is only static Figma-to-code implementation. Match the resting
  screenshot first, then add motion if the product behavior calls for it.

## Required context

- Tech-stack profile:
  - `target`: `web`
  - `framework`: `react`, `vue`, `static-html`, or the actual framework
  - `token_format`: `css-vars`, `tailwind-theme`, or project equivalent
- Interaction scope: trigger, open state, close state, and any intermediate
  `closing` or `entering` state.
- Source of truth for the state: formal Figma component variant, confirmed
  product behavior, or approved provisional validation state.
- Existing code conventions for class names, component state, timers,
  accessibility, and reduced-motion handling.

## Inputs

- Target component or screen implementation files.
- Figma node or confirmed state definition for the resting and animated
  states.
- Existing design tokens for duration, easing, radius, color, spacing, and
  elevation when available.
- Optional: one selected recipe from
  `skills/ui-motion-patterns/references/patterns.md`.

## Outputs

- Project-native CSS, Tailwind classes, or component-local state handling
  for the selected interaction.
- Motion tokens or local CSS custom properties when the values should be
  reused.
- A reduced-motion fallback using
  `@media (prefers-reduced-motion: reduce)`.
- Verification notes covering open, close, repeated click, keyboard, and
  layout-shift behavior when relevant.

## Workflow

1. Confirm the task is web motion and the tech-stack profile is known. If
   platform or framework affects the implementation shape, ask before
   coding.
2. Confirm the motion trigger and state source. If the state only exists
   as an inferred product-common behavior, route it through the
   provisional-state approval policy before implementing it.
3. Inspect existing component code, CSS, token names, and accessibility
   behavior before adding new motion.
4. Identify the smallest matching interaction type:
   `tab-indicator`, `dropdown`, `modal`, `panel`, `card-resize`,
   `card-hover`, `badge-pop`, `icon-swap`, `text-swap`, `number-swap`,
   or `page-side-by-side`.
5. Read only the relevant recipe from
   `references/patterns.md`. Treat it as a template, not as code to paste
   unchanged.
6. Rewrite selectors, variable names, timing, easing, and state names to
   match the target project. Prefer existing tokens over new values.
7. Keep motion scoped to the component. Use `transform`, `opacity`, and
   small `filter` changes where possible. Do not make motion change the
   resting layout, measured geometry, or asset sizing.
8. Implement close/reverse behavior explicitly. Use a `closing` state and
   timer cleanup when the element must animate out before unmounting or
   becoming hidden.
9. Add `prefers-reduced-motion` handling that removes transitions,
   animations, transform travel, and blur where appropriate.
10. Verify the resting UI before motion, the open transition, the close
    transition, repeated trigger clicks, keyboard/escape behavior for
    overlays, and absence of layout shift.
11. If the motion reveals a recurring product rule, add it to the relevant
    rule document or skill gotcha instead of burying it in one component.

## Clarification policy

Ask before proceeding when:
- The target platform is not clearly web or the framework/token profile is
  missing.
- The interaction state is not present in the formal design and has not
  been approved as product behavior.
- Motion would change component dimensions, flow layout, scroll position,
  focus order, or hit targets.
- A dependency choice is needed, such as using GSAP, Framer Motion, Motion
  One, or a framework transition primitive.
- The desired timing or personality should become a reusable brand/system
  rule rather than a local implementation detail.

Do not ask when:
- The interaction state is confirmed and the recipe only needs local
  selector/token adaptation.
- A safe reduced-motion fallback is obvious.
- The implementation can stay component-local and is easy to reverse.

## Gotchas

- Do not paste unreviewed snippets verbatim. Recreate common patterns
  with project naming, project tokens, and verified behavior.
- Do not add animation before the static design matches Figma. Motion can
  hide geometry drift during review.
- Do not animate layout-affecting borders, widths, heights, top/left, or
  auto layout spacing unless the interaction explicitly requires layout
  motion and verification covers the resulting shift.
- Do not rely on `transition: all`; it often animates unintended layout,
  color, or shadow changes and makes regressions hard to inspect.
- Do not unmount overlays, dropdowns, or panels immediately if the close
  animation is required. Use an explicit closing state and clean up timers.
- Do not leave timers or animation-end handlers that can race under rapid
  repeated clicks.
- Do not treat hover-only motion as the only affordance. Keyboard and
  touch users must still get usable state changes.
- Do not use blur-heavy motion on dense operational UIs unless verified;
  it can reduce readability and feel slower than the actual duration.

## Verification

- Resting UI matches the Figma target before and after the animation.
- Open and close states both run correctly, or instant close is explicitly
  intentional.
- No layout shift occurs unless layout motion is the stated interaction.
- `prefers-reduced-motion: reduce` removes nonessential movement and blur.
- Keyboard and escape behavior work for dialogs, popovers, and menus.
- Repeated clicks do not leave the component stuck in `closing`,
  `entering`, hidden, or pointer-disabled states.
- Any new reusable duration, easing, or motion token is documented instead
  of remaining as an unexplained one-off.
