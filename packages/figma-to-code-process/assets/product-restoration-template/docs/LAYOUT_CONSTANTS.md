# Layout Constants

## Stable Frames

| Region | Size / Position | Source Node | Notes |
|---|---|---|---|
| `[REGION]` | `[WIDTH x HEIGHT]` | `[NODE_ID]` | `[NOTES]` |

## Reusable Geometry

| Token / Constant | Value | Source | Usage |
|---|---:|---|---|
| `[CONSTANT_NAME]` | `[VALUE]` | `[NODE_ID]` | `[USAGE]` |

## Responsive / Scaling Rules

- `[RULE]`

## Form Factor Composition

Complete this when the product supports more than one screen class.

| Form Factor | Source Frame(s) | Composition / Adaptation Rule | Verification Profile |
|---|---|---|---|
| `phone` | `[NODE_ID / DIMENSIONS]` | `[RULE]` | `[DEVICE_PROFILE]` |
| `pad` | `[NODE_ID / DIMENSIONS]` | `[RULE]` | `[DEVICE_PROFILE]` |

## Mobile System UI / Insets

Complete this section for Android or iOS targets. Remove it only when it
does not apply.

| Item | Source / Decision | Implementation Rule |
|---|---|---|
| Source device/frame and unit mapping | `[FRAME / PX_TO_DP_OR_PT_RULE]` | `[RULE]` |
| Status bar | `[NODE_ID_OR_SYSTEM_OWNED]` | `[INSET_OR_EDGE_TO_EDGE_RULE]` |
| Bottom system/navigation area | `[NODE_ID_OR_SYSTEM_OWNED]` | `[INSET_OR_EDGE_TO_EDGE_RULE]` |
| Verification device | `[EMULATOR_OR_SIMULATOR_PROFILE]` | `[CAPTURE_RULE]` |

## Geometry-Sensitive Strokes

| Component / Region | Stroke | Layout Risk | Implementation Rule |
|---|---|---|---|
| `[NAME]` | `[STROKE]` | `[RISK]` | `[outline | inset shadow | reserved border space | pinned size]` |

## One-Off Measurements

| Measurement | Value | Source Node | Why Not A Constant |
|---|---:|---|---|
| `[MEASUREMENT]` | `[VALUE]` | `[NODE_ID]` | `[REASON]` |
