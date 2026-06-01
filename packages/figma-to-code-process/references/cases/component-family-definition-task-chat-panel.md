# Component Family Definition — TaskChatPanel

> simple family (child of WorkspacePage composite)  
> definition produced: 2026-04-21  
> last updated: 2026-04-21 (verification complete)

---

## Family Boundary

**Family name:** `TaskChatPanel`  
**Family type:** simple (child)  
**Parent composite:** `WorkspacePage`  
**Figma source:** `2025:12085` (`对话区`)  
**Sub-components (internal, no separate cards):**
- `TaskChatPanel/Header` — title + expand icon
- `MessageRow/UserBubble` — right-aligned user message
- `MessageRow/AIResponse` — AI response with text + analysis blocks
- `AnalysisStatusRow` — Component 31, single-line analysis status
- `AnalysisChip` — 分析类目 instance, inline chip tag
- `TaskChatPanel/InputArea` — binds existing `InputBox` family

**Out of scope:**
- empty / loading / error states
- message hover / selection interaction
- scroll behavior
- history drawer

---

## Naming Normalization

| Raw Figma node | Node ID | Canonical name | Role |
|---|---|---|---|
| `对话区` | `2025:12085` | `TaskChatPanel` | panel root |
| `工具栏` (inside 对话区) | `2025:12086` | `TaskChatPanel/Header` | title bar, 400×56 |
| `功能` | `2025:12087` | `TaskChatPanel/Header/TitleGroup` | title text + expand icon |
| `Sidebar/Header/TitleText` | `2025:12089` | `TaskChatPanel/Header/TitleText` | naming drift from Sidebar |
| `内容` | `2025:12098` | `TaskChatPanel/Content` | scrollable message area |
| `Frame 2147238867` | `2025:12099` | `TaskChatPanel/MessageList` | message list container |
| `Frame 2090053042` | `2025:12100` | `MessageRow/UserBubble` | user message row |
| `对话气泡` (instance) | `2025:12104` | reuse existing bubble component | — |
| `Frame 2147238866` | `2025:12110` | `MessageRow/AIResponse` | AI response block |
| `Component 31` | `2025:12111` | `AnalysisStatusRow` | single-line status row |
| `Frame 2147238872` | `2025:12263` | `MessageRow/AIResponse/TextWithChip` | AI text + chip row |
| `分析类目` (instance) | `2025:12265` | `AnalysisChip` | inline analysis category chip |
| `任务发起` | `2025:12359` | `TaskChatPanel/InputArea` | input binding slot |
| `InputBox` (instance) | `2025:12360` | reuse existing `InputBox` component | — |

---

## Semantic Slots

| Slot | Description |
|---|---|
| `header` | panel title + expand icon, 400×56 |
| `messageList` | scrollable list of message rows, 368px inner width |
| `userBubble` | right-aligned user message bubble |
| `aiResponse` | AI response block: status row + text + chips |
| `analysisStatusRow` | single-line analysis progress indicator |
| `analysisChip` | inline chip tag for analysis category |
| `inputArea` | bottom input slot, reuses `InputBox` (368×112) |

---

## Axes

### Formal axes

| Axis | Values | definition_status |
|---|---|---|
| `contentState` | `analysis-in-progress` | formal |

### Provisional axes

| Axis | Values | definition_status |
|---|---|---|
| `contentState` | `empty`, `completed`, `error` | provisional-proposal |

---

## Required States

| Component | State / Value | definition_status | verification_status |
|---|---|---|---|
| `TaskChatPanel` | `contentState=analysis-in-progress` | formal | coverage-complete |
| `TaskChatPanel/Header` | `default` | formal | coverage-complete |
| `MessageRow/UserBubble` | `default` | formal | coverage-complete |
| `MessageRow/AIResponse` | `default` | formal | coverage-complete |
| `AnalysisStatusRow` | `default` | formal | coverage-complete |
| `AnalysisChip` | `default` | formal | coverage-complete |
| `TaskChatPanel/InputArea` | `InputBox=default` | formal | coverage-complete |

---

## Visual Tokens

### Panel shell

| Property | Value |
|---|---|
| size | `400 × 852` |
| background | `--color-surface-base` (`#ffffff`) |
| header height | `56px` |
| content padding | `16px` horizontal |
| message list inner width | `368px` |
| input area height | `112px` |

### Header

| Property | Value |
|---|---|
| title font | `HYQiHei:60S`, 14px / 20px |
| expand icon | `20 × 20`, inner frame `12 × 12` |
| title x offset | `16px` |
| title y offset | `18px` |

### AnalysisChip

| Property | Value |
|---|---|
| height | `32px` |
| padding | `pl-[8px] pr-[12px]` |
| radius | `69px` |
| background | `rgba(0,0,0,0.02)` |
| border | `0.5px solid rgba(0,0,0,0.08)` |
| spinner icon | `14 × 14` |
| font | `PICO_Sans_VFE_SC:Regular`, 12px, `#999999` |

### MessageRow

| Property | Value |
|---|---|
| user bubble alignment | right |
| AI response alignment | left |
| row gap | `16px` top padding in MessageList |

---

## Asset Slots

| Asset | Naming convention | Notes |
|---|---|---|
| Header expand icon | `taskchatpanel-expand@1x.svg` | `2025:12090` inner frame |
| AnalysisStatusRow loading dots | `analysisstatusrow-loading@1x.svg` | `1708:29717` — 30×6, three dots, CSS var fill, `?react` import |
| AnalysisChip spinner icon | `analysischip-check@1x.svg` | `I2025:12265;994:48282` — 14×14, circular arc, CSS var fill, `?react` import |

---

## Promotion Rule

- `AnalysisStatusRow` and `AnalysisChip` are internal sub-components of
  `TaskChatPanel`. Do not promote to standalone family cards unless reuse
  outside `TaskChatPanel` becomes explicit.
- Do not promote `contentState=empty/completed/error` until a dedicated
  board or explicit user confirmation exists.

---

## Code Prop API

```ts
interface TaskChatPanelProps {
  title?: string
  messages?: MessageItem[]
  inputBoxProps?: InputBoxProps
}

interface MessageItem {
  type: 'user' | 'ai'
  content: ReactNode
}
```

---

## Verify Matrix

| Case | Component | Axis combo | definition_status | verification_status |
|---|---|---|---|---|
| V1 | `TaskChatPanel` | `contentState=analysis-in-progress` | formal | coverage-complete |
| V2 | `TaskChatPanel/Header` | `default` | formal | coverage-complete |
| V3 | `MessageRow/UserBubble` | `default` | formal | coverage-complete |
| V4 | `MessageRow/AIResponse` | `default` | formal | coverage-complete |
| V5 | `AnalysisStatusRow` | `default` | formal | coverage-complete |
| V6 | `AnalysisChip` | `default` | formal | coverage-complete |
