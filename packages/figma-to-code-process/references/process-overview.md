# Figma To Code Process Overview

This package is a single installable workflow for agents. It wraps the local
phase skills and shared rules into one entry point so Codex, Claude Code, and
other coding agents can follow the same checkpoints.

## Operating Model

1. Confirm repo instructions, branch, ownership, and coordination state.
2. Resolve the source of truth before implementation.
3. Capture or draft missing design-system rules only when needed.
4. Export real Figma-owned assets before writing component geometry.
5. Implement against the confirmed tech-stack profile.
6. Verify the rendered result against the Figma source.
7. Feed recurring mistakes back into gotchas, templates, or gates.
8. Route reusable lessons through source-repo proposals and PRs; never
   silently mutate installed local skills.

## Source Priority

1. Confirmed product specification or existing design-system rule.
2. Formal Figma component/library board.
3. Approved provisional validation state.
4. Existing implementation code, when the project treats it as canonical.
5. Raw design inference, only after documenting the uncertainty.

## Product Restoration Rule

Product work belongs in a separate product repository. Copy the product
restoration template into that repo, complete preflight docs there, then
implement and verify board by board. Do not nest active product code inside the
workflow package repository.

## Installed References

- `source-skills/`: phase-specific executable prompts from the source repo.
- `workflow-outline.md`: long-form workflow rules.
- `tech-stack-profile.md`: platform/profile fields to record.
- `product-restoration-preflight.md`: product repo bootstrap gates.
- `quality-gates.md`: executable gate descriptions from validated cases.
- `official-skills-alignment.md`: boundary map against official Figma skills.
- `evolution/`: contribution intake guidance and proposal template for
  reviewable skill evolution.
- `examples/`: distilled reusable patterns derived from completed cases.
- `assets/product-restoration-template/`: copyable product preflight package.
