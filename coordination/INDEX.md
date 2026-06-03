# Coordination Index

Single entry point for all three contributors (user, Claude, Codex).
Update this file when phase, repos, or active work changes.

## Stable Memory

- Working summary for new threads:
  `coordination/WORKING-MEMORY.md`

## Current Phase

Phase 3 closed (2026-04-13) — Tab, InputBox, Toolbar all verified and committed.
Phase 4 closed (2026-04-20) — `figma-execution-shell` merged; Dialog, AIToolsRow, and Sidebar (default-only) are all closed.
Phase 5 closed (2026-04-20) — BrowserResultPage + AssistantSidebarPanel composite family case merged and formally closed.
Phase 6 closed (2026-04-22) — WorkspacePage + TaskChatPanel Repeatability case complete. All 8 component cases closed.
Phase A closed (2026-04-23) — PR #6 (agentic-browser-ui WorkspacePage) and PR #17 (figma-use gotchas) both merged. No open PRs.
Phase B closed (2026-04-24) — Existing-rule capture validation complete. B.1: inventory enriched with code evidence (PR #31). B.2: Tab CloseIcon inline SVG → exported assets, rule-driven (agentic-browser-ui PR #7). B.3: figma-capture-design-system code-backed mode + execution-shell routing reference + inventory resolved-gap cleanup (PR #32).
Phase C closed (2026-05-01) — TaskResultPage running+completed validation chain + FileListCard + provisional cleanup. agentic-browser-ui PRs #10–#13 merged. figma-to-code-skills PRs #37–#38 merged. All provisional markers cleared.
Phase D closed (2026-05-07) — Official skills alignment (PR #39) + ui-motion-patterns skill (PR #40) merged. AssistantSidebarPanel composer/prompt area verified, no drift. All stale remote branches cleaned from both repos.
Phase E closed (2026-05-09) — NavigationMenu (pill-style nav, Figma 2080:42251 + full variant board 2080:42252) implemented and verified. agentic-browser-ui PRs #14–#15 + figma-to-code-skills PRs #43–#44 merged. Preflight hard-gate rules added (PRs #42 and #45).
Phase F closed (2026-05-09) — Sidebar icon-only/collapsed-like source confirmation. Figma `1708:30181` confirmed as the source frame and matched to the existing `Sidebar collapsed` implementation. figma-to-code-skills PR #46 merged.
Phase G closed (2026-05-09) — SearchBar component (Figma `2080:8086`, 240×32). agentic-browser-ui PR #16 + figma-to-code-skills PR #48 merged.
Phase H closed (2026-05-11) — ModelCard first slice from Card board `2080:40041`: 模型广场 Normal/Hover/loading/Selected (`2080:40042`, `2080:40051`, `2080:40064`, `2080:40079`). agentic-browser-ui PR #17 + figma-to-code-skills PR #50 merged.
Phase I closed (2026-05-12) — TopTabBar operation + tab-strip first slice (Figma `2080:8062`, 1166×52). agentic-browser-ui PR #20 merged; figma-to-code-skills PR #54 merged. Global actions deferred.
Phase J closed (2026-05-12) — TopTabBar global actions (功能组 + window controls). agentic-browser-ui PR #21 merged; figma-to-code-skills PR #56 merged. TopTabBar fully closed.
Phase K closed (2026-05-13) — UpgradeDialog downloading state (Figma `2080:7977`, 310×216). agentic-browser-ui PR #22 merged; figma-to-code-skills PR #57 merged.

## Active Repos

| Repo | Purpose |
|---|---|
| `figma-to-code-skills` | skill rules, gotchas, workflow inventory |
| `agentic-browser-ui` | implementation target (React + Tailwind) |

Local paths:
- `~/Documents/Codex/Mars/figma-to-code-skills`
- `~/Documents/Codex/Mars/agentic-browser-ui`

## Active Issues

- [#13 — Coordination Log (permanent)](https://github.com/TAI-IPX/figma-to-code-skills/issues/13) — never close, rolling action log

Closed:
- [#12 — InputBox implement→verify](https://github.com/TAI-IPX/figma-to-code-skills/issues/12) — closed, all 4 states verified
- [#4 — Phase 1 skill rewrite](https://github.com/TAI-IPX/figma-to-code-skills/issues/4) — all skills rewritten, Tab case closed

## Active Figma File

- File key: `iIbL9V4UrFeORPaM7KVji7`
- URL: `https://www.figma.com/design/iIbL9V4UrFeORPaM7KVji7`

Key node IDs:
| Component | Node ID |
|---|---|
| AIToolsRow | `1708:30180` |
| BrowserResultPage (assistant sidebar expanded) | `1708:30204` |
| InputBox | `1708:30342` |
| 页签 (8 variants) | `1714:977`, `1714:983`, `1714:990`, `1714:1001`, `1720:89968`, `1720:89980`, `1720:89992`, `1720:90000` |
| 关闭 Hover=off | `1714:1013` |
| 关闭 Hover=on | `1714:1017` |
| 侧边栏展开 board | `1708:30337` |
| Sidebar icon-only source | `1708:30181` |
| Dialog section | `1922:32133` |
| Dialog core block | `1922:31967` |
| TaskResultPage | `1708:30544` |
| FileListCard (列表卡片/展开) | `1708:30738` |
| AssistantSidebar collapsed launcher | `1708:30243` |
| AssistantSidebarPanel 输入框 | `1708:30323` |
| AssistantSidebarPanel 预设问题 | `1708:30311` |
| NavigationMenu (pill-style nav) | `2080:42251`, `2080:42252` |
| ModelCard / Card board | `2080:40041`; 模型广场 slice `2080:40042`, `2080:40051`, `2080:40064`, `2080:40079` |

## Current State

### Tab — closed
All 8 variants verified. close-off/close-on SVGs from source export wired. No gaps.

### InputBox — closed
All 4 states (default/focus/disabled/error) implemented and verified.
Geometry stable via inset box-shadow. Icons use inline SVG + currentColor.
Commits: `d6afa94`, `ef0099c` in agentic-browser-ui.
focus-shadow mismatch noted by Codex — accepted as-is, not a blocker.

### Toolbar — closed
All 5 states verified and pushed.
Commits: `eb13c90`, `dbd1136` in agentic-browser-ui.
Deferred non-blocker: `border border-[0.5px]` redundancy in `urlFocused`.

### Dialog — closed (2026-04-16)
All axes implemented. Deferred non-blocker: HYQiHei font loading.

### AIToolsRow — closed (2026-04-17)
All axes implemented. Deferred: active state remains proposal-level.

### Sidebar — verified (expanded + icon-only source)
Expanded/default pass closed (2026-04-17). Icon-only/collapsed-like rail source confirmed (2026-05-09): Figma `1708:30181` is a 240×816 rail with 16px padding, two 24×24 buttons, 12px gap, and 16px icons. Browser DOM measurement of the existing implementation matches those dimensions. This is a source-confirmed frame, not a Figma component-set variant; hover/active row states and animation remain deferred.

### BrowserResultPage / AssistantSidebarPanel — closed (2026-05-07)
Composite family case. Source node: `1708:30204`.
Implementation merged via PR #5 (agentic-browser-ui) and PR #27 (figma-to-code-skills).
Collapsed launcher (`1708:30243`) closed (2026-05-01): geometry fixed to 56×24 via agentic-browser-ui PR #13 (border → outline).
Panel-specific chip/composer states verified (2026-05-07): no drift found. Fully closed.

### WorkspacePage / TaskChatPanel — closed (2026-04-22)
Phase 6 Repeatability case. Composite family.

### TaskResultPage — closed (2026-05-01)
Running state: agentic-browser-ui PR #10 merged.
Completed state: agentic-browser-ui PR #11 merged.
Source nodes: `1708:30544` (main frame), `1708:30803–30806` (completed hidden layers).
Durable lessons: hidden layers as alternate-state source; 【H2】 annotation prefix handling.

### FileListCard (列表卡片/展开) — closed (2026-05-01)
Source node: `1708:30738` (TaskResultPage hidden layer, confirmed product state).
agentic-browser-ui PR #12 merged.
Durable lesson: static component strokes must be non-layout-affecting (outline/inset-shadow).

### NavigationMenu — closed (2026-05-08)
Source nodes: `2080:42251` (initial pill-style nav) and `2080:42252` (full variant board with 3–10 items, optional more, optional 管理 control).
agentic-browser-ui PR #14 merged the initial component; PR #15 merged full variant/manage-control coverage.
figma-to-code-skills PR #43 added the case card; PR #44 synced full variant evidence.
DOM evidence: 1162px full-width surface, 32px pills, 12px tab gap, 管理 button 16px left/right padding.
Durable lesson: preflight (scope note + asset inventory + state-geometry scan) must happen before code, not after. PR #42 made this a hard gate in figma-execution-shell.

### SearchBar — closed (2026-05-09)
Source node: `2080:8086` (instance in NavigationMenu spec board, 240×32).
agentic-browser-ui PR #16 merged: SearchBar component + showSearch slot in NavigationMenu.
Micro-drift follow-up: agentic-browser-ui PR #18 fixes icon-to-text gap to 6px and input text to black while preserving caret `#1f2329`.
DOM evidence: `h-[32px] w-[240px] rounded-[12px] border-[1.5px]`, search icon 18×18, icon-to-text gap 6px, input-to-clear gap 8px, clear button visible when value non-empty, focused with-value border `rgba(51,51,51,0.9)`.

### ModelCard — closed (2026-05-11)
Source board: `2080:40041`.
First slice: 模型广场 Normal/Hover/loading/Selected (`2080:40042`, `2080:40051`, `2080:40064`, `2080:40079`).
Implementation merged via agentic-browser-ui PR #17.
Case card and coordination merged via figma-to-code-skills PR #50.
Icon-size follow-up: user visual review found the DeepSeek glyph too small; render it in a `20 × 20` slot with visible glyph `18 × 13.25`.
DOM evidence: all four cards `284 × 132`; DeepSeek icon slot `20 × 20`; visible glyph `18 × 13.25`; Normal/Hover/loading outline `0.5px`; Selected outline `1px #000`; Hover button `88 × 32`; loading track `244 × 6`; loading fill `73 × 6`.
Scope intentionally excludes 写作助手, AI 搜索, AI Space, and optional local tag until the first slice is verified.

### TopTabBar — closed (2026-05-12)
Source node: `2080:8062` (Tab bar, 1166×52).
Phase I (PR #20/#54): operation + tab-strip, home-selected state.
Phase J (PR #21/PR #56): global actions — 功能组 (新版本 pill, 签到 pill, user chip) + window controls (pin/min/max/close 32×32).
12 assets total, all recorded in slices-name-map.json.
DOM evidence: bar 1166×52; global group 388×32 pl-64 gap-4; feature group 180×28 gap-8; pills h-28; window buttons 32×32; all icon sizes match source.
Durable lessons: frame-preserving normalization, currentColor needs explicit color class, shared arrow rotation, multi-layer gradient icon composition.

### UpgradeDialog — closed (2026-05-20)

**Phase K** (2026-05-13): instance-derived from `2080:7977` (310×216, rounded-16, outline). Downloading state only. agentic-browser-ui PR #22, figma-to-code-skills PR #57.

**Phase L** (2026-05-20): corrected to formal component set `2080:40359` (联想规范 page). All 4 variants: 升级前 (320×356), 升级中 (320×222), 升级成功 (320×222, inferred), 升级失败 (320×222). 6 assets; `upgrade-fail-circle` is a legacy unused export because Figma ellipse `2080:40429` has fill `visible=false`. agentic-browser-ui PR #23, figma-to-code-skills PR #60.

Durable lessons: instance-context vs canonical source; hidden variant handling; check layer/fill visibility before repairing empty SVG exports; outline not border for exact-size surfaces; pin root height; shrink-0 on progress bar.

### BookmarkItem — closed (2026-05-20)
Source nodes: `1708:30231~30233` (书签, Agentic Browser page).
Bookmark bar chip: 24px height, content-driven width, gap-4, px-4, 16×16 icon, 12px text #666.
Two icon variants: generic star icon (default) and app favicon (appIconSrc + appIconBg + appIconRadius props).
Extracted from inline Toolbar implementation; removed unused bookmarked prop.
agentic-browser-ui PR #24, figma-to-code-skills PR #61.
Durable lessons: inline extraction clarifies component boundary; content-driven width (no fixed width); two icon slot types in one component via optional props.

## Active Work

`skill/android-implement-lessons` — Claude Code: cross-platform gotcha harvest from `mobile-home-android` project (Phone + Ask AI XML delivery). 4 skills receiving platform-agnostic gotchas (2026-06-01).

## Open PRs

No prior open PRs. One pending for `skill/android-implement-lessons`.

## Next Recommended Action

Merge Claude Code Android gotcha PR (#pending). Then:
- browser-ai-tools-product board-by-board UI restoration (9 boards, currently only assets exported)
- Quality gates: smallest executable check scripts

## Source-of-Truth Notes

- Skill rules live in `skills/*/README.md` — authoritative for agent behavior
- Workflow rules live in `inventory/workflow-outline.md`
- Product restoration bootstrap/preflight lives in
  `inventory/product-restoration-preflight.md` and
  `templates/product-restoration/`
- New product implementation repos should copy/adapt the product
  restoration templates and keep product-specific state outside
  `figma-to-code-skills`
- CSS tokens live in `agentic-browser-ui/src/index.css`
- Exported assets live in `agentic-browser-ui/src/assets/figma/`
- FIGMA_TOKEN is available in env (set in `~/.zshrc`) — export workflow is unblocked
