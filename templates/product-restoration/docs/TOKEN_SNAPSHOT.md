# Token Snapshot

## Default Design-System Contract

- Default design system / variable library: `[FIGMA_SPEC_OR_TOKEN_SOURCE]`
- Source page / node: `[SOURCE_PAGE_OR_NODE]`
- Collections and modes: `[COLLECTIONS_AND_MODES]`
- Applied form factors: `[phone | pad | phone-and-pad | other]`
- Binding rule: `[SEMANTIC_TOKENS_BY_DEFAULT; EXCEPTIONS_RECORDED_BELOW]`

When a confirmed default variable library is named above, bind product
surfaces to its semantic variables before introducing raw values or new
local tokens. Record every approved exception in `Conflicts / Open
Questions`.

## Source Priority

1. Confirmed product design-system baseline, whether Figma variables or
   matching code tokens.
2. Existing product code rules that implement that baseline.
3. Human-confirmed extracted draft rules.
4. Raw Figma values for one-off state restoration.

## Colors

| Token | Value | Source | Usage |
|---|---|---|---|
| `[TOKEN]` | `[VALUE]` | `[CODE_OR_NODE]` | `[USAGE]` |

## Typography

| Role | Font | Size / Line | Weight | Source |
|---|---|---|---|---|
| `[ROLE]` | `[FONT]` | `[SIZE/LINE]` | `[WEIGHT]` | `[SOURCE]` |

## Radius / Shadow / Effects

| Role | Value | Source | Notes |
|---|---|---|---|
| `[ROLE]` | `[VALUE]` | `[SOURCE]` | `[NOTES]` |

## Conflicts / Open Questions

| Topic | Options | Decision Needed |
|---|---|---|
| `[TOPIC]` | `[OPTIONS]` | `[QUESTION]` |
