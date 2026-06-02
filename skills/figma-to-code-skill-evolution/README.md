# figma-to-code-skill-evolution

## Goal

Turn real Figma-to-code usage lessons into reviewable, reusable skill
improvements without letting an agent silently mutate installed skills or
promote project-specific evidence into the default package.

## When to use

- A completed implementation, verification, asset-export, design-system,
  or product-restoration run exposed a recurring failure mode.
- A closeout says the current workflow did not prevent a mistake or made
  the agent rediscover a rule manually.
- The user asks how the Figma-to-code skill should evolve from real use.
- A contributor wants to convert a project lesson into a candidate rule,
  gotcha, quality gate, distilled example, or template update.

## When not to use

- The lesson only documents a one-off product decision with no reusable
  workflow value.
- The request is to implement or verify UI; use the normal delivery
  skills first, then run this only during closeout.
- The user wants installed local skills modified immediately without
  source-repo review.
- The evidence contains private product details that cannot be
  generalized or anonymized.

## Required context

- The completed run's closeout, PR, issue comment, or evidence docs.
- The source repo coordination rules, especially `AGENTS.md`,
  `CONTRIBUTING.md`, and issue `#13`.
- The candidate promotion target:
  - a skill README
  - `inventory/workflow-outline.md`
  - `inventory/quality-gates.md`
  - `templates/product-restoration/`
  - `packages/figma-to-code-process/references/examples/`
  - another explicitly named artifact
- Existing open PRs so another contributor's skill ownership is not
  overwritten.

## Inputs

- Failure or lesson summary.
- Evidence: command output, screenshot, rendered comparison, PR, issue
  comment, or product docs.
- Scope signal: generic, platform-specific, project-specific, or
  uncertain.
- Optional: user-approved direction for where the lesson should be
  promoted.

## Outputs

- A contribution proposal in `contributions/inbox/` using
  `contributions/TEMPLATE.md`.
- If the lesson is accepted in the same run, the smallest matching update
  to a skill, workflow doc, template, quality gate, or distilled example.
- A PR description that names the evidence, scope classification, and why
  the target artifact needed to change.
- A #13 coordination comment summarizing the proposal and any promoted
  rule.

## Workflow

1. Confirm this is an evolution task, not active UI delivery.
2. Check `git status`, open PRs, `coordination/INDEX.md`,
   `coordination/WORKING-MEMORY.md`, and issue `#13` before editing. If
   another open PR owns the same skill or target artifact, stop and
   coordinate in GitHub.
3. Classify the lesson:
   - `generic`: applies across platforms and projects.
   - `platform-specific`: applies to a target such as web, iOS, Android,
     or a framework family.
   - `project-specific`: belongs in a product repo or case note, not the
     default package.
   - `uncertain`: needs more evidence before promotion.
4. Create a proposal in `contributions/inbox/` before changing long-lived
   rules. Use a dated, descriptive filename such as
   `2026-06-02-rendered-verification-drift.md`.
5. Fill every template section. The proposal must include the failure,
   evidence, proposed generic rule, scope classification, "not applicable
   when" boundary, and intended promotion target.
6. Decide the smallest safe promotion:
   - use a skill gotcha when it prevents a known agent mistake;
   - use a skill workflow step when the order of operations must change;
   - use `inventory/workflow-outline.md` only for cross-skill process
     rules;
   - use `inventory/quality-gates.md` only when the check can be made
     executable or reviewable;
   - use a distilled package example only when the pattern teaches a
     reusable shape better than prose;
   - keep project-specific material in the product repo, `cases/`, or
     `experiments/`.
7. When promoting a rule, edit the source artifact first. If the
   installable package mirrors that artifact, rebuild or refresh the
   package so installed references do not drift.
8. Keep package examples distilled and anonymized. Do not copy raw
   product case cards, private paths, Figma node lists, or PR logs into
   the default package.
9. Verify the change:
   - check the edited skill still has the required template sections;
   - run relevant shell syntax checks for changed scripts;
   - rebuild the package when package inputs changed;
   - run available package validation or install dry-run checks.
10. Open a PR and post a concise update to issue `#13`. State whether the
    proposal remains in `inbox/`, moved to `accepted/`, or was rejected.

## Clarification policy

Ask before proceeding when:

- The evidence is not accessible or cannot be summarized safely.
- It is unclear whether the lesson is generic, platform-specific, or
  project-specific.
- The proposed change would edit a strategy document without a clear
  issue/coordination basis.
- Another open PR owns the same skill or workflow area.
- The improvement would require changing installed local skills directly
  instead of updating the source repo.
- The proposal includes product-specific names, paths, Figma nodes, or
  customer details that need anonymization before packaging.

## Gotchas

- Do not confuse recurrence with importance. A severe one-off product
  decision may still be project-specific.
- Do not put long historical case cards into the installable package.
  Distill the lesson into a small pattern or keep the evidence in the
  source repo.
- Do not update only the packaged copy of a source skill. Source skill
  READMEs are authoritative; the package must be refreshed from source.
- Do not silently rewrite local installed skills. Evolution happens by
  proposal, source edit, validation, PR, and reinstall.
- Do not remove another contributor's proposal just because it is rough;
  move it through review with a reason.

## Verification

- The proposal file exists in `contributions/inbox/`, `accepted/`, or
  `rejected/` and fills the required sections.
- Any promoted rule names the evidence and has a clear boundary.
- The changed skill README still contains: Goal, When to use, When not to
  use, Required context, Inputs, Outputs, Workflow, Clarification policy,
  Gotchas, and Verification.
- The installable package is refreshed when mirrored source content
  changes.
- The PR description explains why the change is reusable and why it is
  not merely project-specific.

