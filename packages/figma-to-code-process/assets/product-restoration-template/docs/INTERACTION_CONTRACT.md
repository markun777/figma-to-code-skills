# Interaction Contract

## State Shape

```ts
type ProductState = {
  // Replace with product-specific state.
};
```

## Confirmed User Actions

| Action | Source Node / Approval | Expected Result |
|---|---|---|
| `[ACTION]` | `[NODE_ID_OR_APPROVAL]` | `[RESULT]` |

## Transition Table

| Current State | User Action | Expected Result | Source |
|---|---|---|---|
| `[STATE]` | `[ACTION]` | `[RESULT]` | `[NODE_ID_OR_APPROVAL]` |

## Forbidden Inventions

Do not implement these unless Figma source or the user/team confirms
them:

- unconfirmed modals or floating panels
- unconfirmed hover, pressed, loading, success, or error states
- recommendation cards not present in source
- hidden layers that are not confirmed product states
- extra close/minimize/pin controls not shown or approved

## Open Questions

| Question | Why It Matters | Decision |
|---|---|---|
| `[QUESTION]` | `[IMPACT]` | `[pending | accepted | deferred]` |
