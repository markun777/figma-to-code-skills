# Figma Board / State Map

Source section/page: `[SOURCE_SECTION_OR_PAGE]`

## Canonical Board Map

| Order | Canonical Name | Figma Node | Raw Name | Role | Status |
|---:|---|---|---|---|---|
| 1 | `[01-default]` | `[NODE_ID]` | `[RAW_NAME]` | default state | `[mapped | cleaned | implemented | verified]` |
| 2 | `[02-panel-open]` | `[NODE_ID]` | `[RAW_NAME]` | panel open | `[mapped | cleaned | implemented | verified]` |
| 3 | `[03-hover-process]` | `[NODE_ID]` | `[RAW_NAME]` | hover/process state | `[mapped | cleaned | implemented | verified]` |

## State Source Rules

- Every implemented state must point to a Figma node or an approved
  provisional card.
- Hidden layers can be valid state sources only when confirmed as product
  states.
- Raw board names are not implementation names. Use canonical names for
  code and docs.
- If two Figma contexts disagree, record a source audit instead of
  mixing them in code.

## Deferred / Ambiguous Sources

| Candidate | Node | Question | Decision |
|---|---|---|---|
| `[STATE]` | `[NODE_ID]` | `[QUESTION]` | `[pending | accepted | deferred]` |
