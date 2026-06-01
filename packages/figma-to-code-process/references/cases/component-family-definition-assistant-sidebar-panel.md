# Component Family Definition — AssistantSidebarPanel

> simple family  
> definition produced: 2026-04-20  
> last updated: 2026-04-20

---

## Family Boundary

**Family name:** `AssistantSidebarPanel`  
**Family type:** simple  
**Figma source:** `1708:30267` (`侧边栏`)

**Out of scope:**
- collapsed sidebar container
- history drawer expanded state
- prompt-chip hover / pressed behavior
- text-entry interaction states beyond the reused `InputBox` family

---

## Naming Normalization

| Raw Figma node | Canonical name | Role |
|---|---|---|
| `侧边栏` | `AssistantSidebarPanel` | family root |
| `title bar` | `AssistantSidebarTitleBar` | top bar for panel-level actions and selected chip |
| `功能` | `AssistantSidebarActions` | leading action cluster |
| `助手` | `AssistantSidebarStatus` | selected assistant chip placement |
| `主内容` | `AssistantSidebarBody` | scrollable content region |
| `预设问题` | `AssistantPromptList` | list/wrap container for prompt chips |
| `输入框` | `AssistantComposerSlot` | slot that binds compact `InputBox` |

Naming rule for this family:
- use `AssistantSidebar*` for structural containers
- use `AssistantPrompt*` for suggestion affordances inside the panel
- treat the composer as a slot binding, not as a renamed fork of `InputBox`

---

## Semantic Slots

| Slot | Description |
|---|---|
| `titleBar` | fixed-height top row with leading actions and selected assistant chip |
| `leadingActions` | new-task and history affordances on the left |
| `statusChip` | selected `AssistantSidebarChip` on the right |
| `body` | flexible vertical body region above the composer |
| `promptList` | wrapped list of prompt chips aligned to the lower edge of body |
| `composer` | compact `InputBox` binding anchored to panel bottom |

---

## Axes

### Formal axes

| Axis | Values | definition_status |
|---|---|---|
| `panelState` | `expanded` | formal |
| `promptList` | `visible` | formal |
| `composerState` | `idle` | formal |

### Provisional axes

| Axis | Values | definition_status |
|---|---|---|
| `promptChipInteraction` | `hover` \| `pressed` | provisional-proposal |
| `historyMode` | `default` \| `expanded` | provisional-proposal |
| `composerState` | `focus` inside compact panel context | provisional-proposal |

---

## Required States

| Component | State / Value | definition_status | verification_status |
|---|---|---|---|
| `AssistantSidebarPanel` | `expanded/default` | formal | coverage-complete |
| `AssistantSidebarTitleBar` | `default` | formal | coverage-complete |
| `AssistantPromptList` | `visible/default` | formal | coverage-complete |
| `AssistantComposerSlot` | `compact idle binding` | formal | coverage-complete |
| `AssistantPromptChip` | `default` | formal | coverage-complete |

---

## Visual Tokens

### Panel shell

| Property | Value |
|---|---|
| size | `400 × 856` |
| background | `rgba(0,0,0,0.02)` |
| left border | `0.5px solid #d7d7d7` |

### Title bar

| Property | Value |
|---|---|
| height | `40px` |
| padding | `pl 16 / pr 8` |
| left actions gap | `8px` |
| action hit area | `24 × 24`, icon `16 × 16` |

### Prompt chip

| Property | Value |
|---|---|
| padding | `px 12 / py 10` |
| gap | `4px` |
| radius | `12px` |
| fill | `rgba(0,0,0,0.02)` |
| border | `0.5px solid rgba(0,0,0,0.12)` |
| text | `HYQiHei:60S`, `14 / 20`, `#333333` |
| arrow | `18 × 18` |

### Composer slot

| Property | Value |
|---|---|
| slot padding | `16px` |
| bound width | `368px` |
| bound family | existing `InputBox` family |

---

## Asset Slots

| Asset | File | Notes |
|---|---|---|
| new-task icon | `assistant-title-new-task@1x.svg` | local title-bar action asset |
| history icon | `assistant-title-history@1x.svg` | leading action in title bar |
| assistant chip logo | `assistant-sidebar-chip-logo@1x.svg` | selected chip at top-right |
| prompt arrow | `assistant-prompt-arrow@1x.svg` | reused by each prompt chip |
| compact composer icons | existing local InputBox assets | verify before reuse |

---

## Promotion Rule

- `expanded/default` is already the formal state for this family.
- Do not promote prompt-chip interaction or compact-composer focus rules
  until the team confirms that panel-specific interaction states are meant
  to diverge from the broader `InputBox` and chip families.

---

## Code Prop API

```ts
interface AssistantSidebarPanelProps {
  suggestions: string[]
  composerPlaceholder?: string
  modelLabel?: string
  onNewTask?: () => void
  onHistory?: () => void
  onSuggestionSelect?: (text: string) => void
  onSend?: (value: string) => void
}
```

---

## Verify Matrix

| Case | Component | Axis combo | definition_status | verification_status |
|---|---|---|---|---|
| V1 | `AssistantSidebarPanel` | `expanded/default` | formal | coverage-complete |
| V2 | `AssistantSidebarTitleBar` | `default` | formal | coverage-complete |
| V3 | `AssistantPromptList` | `visible/default` | formal | coverage-complete |
| V4 | `AssistantComposerSlot` | `compact idle binding` | formal | coverage-complete |
