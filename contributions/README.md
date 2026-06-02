# Skill Evolution Contributions

This directory is the reviewable intake path for reusable workflow
improvements discovered while agents use the Figma-to-code process.

## Directories

- `inbox/`: proposed reusable lessons that still need review.
- `accepted/`: lessons that were accepted and promoted into skills,
  workflow docs, examples, templates, or quality gates.
- `rejected/`: lessons that were reviewed and kept out of the reusable
  skill system.

## Rules

- Do not silently mutate installed local skills.
- Do not promote a project-specific workaround into the default package.
- Every proposal needs evidence from real use, a generic rule candidate,
  and a clear "not applicable when" boundary.
- Accepted proposals must be implemented through a branch and PR.
- Installed packages should receive distilled rules and examples, not
  raw project transcripts or full historical case cards.

## Proposal Flow

1. Copy `TEMPLATE.md` into `inbox/` with a dated, descriptive file name.
2. Fill in the failure, evidence, proposed generic rule, scope, and
   boundary sections.
3. Review whether the lesson is generic, platform-specific, or project-
   specific.
4. If accepted, update the smallest relevant skill, workflow doc,
   template, example, or quality gate.
5. Move or copy the proposal to `accepted/` with a note naming the PR
   that promoted it. Move rejected proposals to `rejected/` with the
   reason.

