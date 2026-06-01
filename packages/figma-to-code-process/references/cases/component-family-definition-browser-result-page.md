# Component Family Definition — BrowserResultPage

> composite family  
> definition produced: 2026-04-20  
> last updated: 2026-04-20

---

## Family Boundary

**Family name:** `BrowserResultPage`  
**Family type:** composite  
**Figma source:** `1708:30204` (`网页结果页`)  
**Sub-families:**  
- `AssistantSidebarPanel` — right-side assistant surface in expanded state

**Root card scope:** page-level composition, hierarchy cleanup, and
canonical naming for the expanded assistant-sidebar case.

**Out of scope:**
- collapsed page board for the full close state
- sidebar open / close animation
- center feed implementation details beyond composition binding
- tab-strip variant logic
- assistant history drawer behavior

---

## Naming Normalization

| Raw Figma node | Canonical name | Role |
|---|---|---|
| `网页结果页` | `BrowserResultPage` | page root |
| `窗口区` | `BrowserWindow` | browser content shell below tab strip |
| `搜索框` | `BrowserToolbarShell` | top chrome row inside window |
| `内容` (`1708:30261`) | `BrowserContentViewport` | center reading surface |
| `侧边栏` | `AssistantSidebarPanel` | expanded assistant panel |
| `copilot/侧边栏` | `AssistantSidebarChip` | selected assistant entry chip |
| hidden `助手` (`1708:30243`) | `AssistantSidebarLauncherReference` | closed-state reference only, not yet promoted to standalone family |
| `输入框` (`1708:30323`) | `AssistantComposerSlot` | page binding that reuses `InputBox` family |

Naming rule for this case:
- use `Browser*` for page-shell containers
- use `AssistantSidebar*` for right-panel-specific UI
- keep reused families (`InputBox`, existing toolbar pieces) under their
  established names instead of renaming them per page

---

## Semantic Slots

| Slot | Description |
|---|---|
| `tabStrip` | top app tab strip outside the window area |
| `browserToolbar` | browser chrome row with nav, url, bookmark cluster, assistant entry |
| `contentViewport` | main reading/result area to the left of the sidebar |
| `assistantSidebar` | expanded right panel, width 400 |
| `assistantComposer` | compact binding of existing `InputBox` family inside the panel |

---

## Axes

### Formal axes

| Axis | Values | definition_status |
|---|---|---|
| `assistantSidebar` | `expanded` | formal |
| `contentLayout` | `viewport + right panel` | formal |
| `assistantChip` | `selected` | formal |

### Provisional axes

| Axis | Values | definition_status |
|---|---|---|
| `assistantSidebar` | `collapsed` | provisional-proposal |
| `assistantChip` | `launcher in toolbar` | provisional-proposal |
| `assistantTransition` | `closed -> expanded` | provisional-proposal |

---

## Required States

| Component | State / Value | definition_status | verification_status |
|---|---|---|---|
| `BrowserResultPage` | `assistantSidebar=expanded` | formal | coverage-complete |
| `BrowserToolbarShell` | `default without assistant chip` | formal | coverage-complete |
| `AssistantSidebarPanel` | `expanded/default` | formal | coverage-complete |
| `AssistantSidebarLauncherReference` | `collapsed launcher reference` | provisional-proposal | coverage-complete |
| `AssistantComposerSlot` | `compact InputBox binding` | formal | coverage-complete |

---

## Visual Tokens

### Root page shell

| Property | Value |
|---|---|
| page size | `1600 × 900` |
| app background | `#ebeef5` |
| window shell | `1592 × 856`, `bg #fafafa`, `radius 12`, `border 0.5px rgba(0,0,0,0.12)` |
| sidebar split | left content `1192px` + right panel `400px` |

### Assistant entry chip

| Property | Value |
|---|---|
| height | `24px` |
| padding | `pl 4 / pr 10` |
| gap | `2px` |
| radius | `99px` |
| fill | `rgba(0,0,0,0.04)` |
| border | `0.5px solid rgba(31,98,238,0.2)` |
| text color | `rgba(31,98,238,0.8)` |

---

## Asset Slots

| Asset | File | Notes |
|---|---|---|
| center content image | `browser-result-content@1x.png` | exported local page-scoped asset from `1708:30266` |
| assistant chip logo | `assistant-sidebar-chip-logo@1x.svg` | local asset for launcher and selected chip |
| toolbar nav / bookmark assets | existing local exports | prefer current `Toolbar` assets if geometry matches |
| compact composer assets | existing local exports | reuse `InputBox` assets where geometry matches |

---

## Promotion Rule

- `assistantSidebar=expanded` is already the formal page state for this
  case.
- Do not promote `collapsed` or `closed -> expanded` interaction into the
  formal root axes until there is either:
  - a dedicated collapsed page board, or
  - explicit user confirmation that the hidden toolbar reference
    (`1708:30243`) is the canonical close state.

---

## Code Prop API

```ts
interface BrowserResultPageProps {
  assistantSidebarState?: 'expanded' | 'collapsed'
  pageImageSrc?: string
  promptSuggestions?: string[]
  onAssistantToggle?: () => void
}
```

---

## Verify Matrix

| Case | Component | Axis combo | definition_status | verification_status |
|---|---|---|---|---|
| V1 | `BrowserResultPage` | `assistantSidebar=expanded` | formal | coverage-complete |
| V2 | `AssistantSidebarPanel` | `expanded/default` | formal | coverage-complete |
| V3 | `AssistantSidebarLauncherReference` | `collapsed launcher` | provisional-proposal | coverage-complete |
