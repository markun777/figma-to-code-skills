# Working Memory

Compact project memory for starting a new thread quickly.
**New to this project? Read [coordination/ONBOARDING.md](ONBOARDING.md) first.**

## Repos

- `figma-to-code-skills` — `/Users/markun/Documents/Codex/Mars/figma-to-code-skills` — workflow rules, gotchas, skill definitions
- `agentic-browser-ui` — `/Users/markun/Documents/Codex/Mars/agentic-browser-ui` — implementation testbed for Figma-to-code cases

## Shared Coordination

- stable entry: `coordination/INDEX.md`
- current active issue: [#13](https://github.com/ken417mar-sudo/figma-to-code-skills/issues/13) — permanent coordination log, never close

## Active Figma File

- file key: `iIbL9V4UrFeORPaM7KVji7`
- main board: `1708:29412`

Key node IDs:
| Component | Node ID |
|---|---|
| Tab component set | `1714:976` |
| Close off/on | `1714:1013` / `1714:1017` |
| InputBox | `1708:30342` |
| AIToolsRow | `1708:30180` |
| Dialog section | `1922:32133` |
| Sidebar | `1708:30337` |
| Sidebar icon-only source | `1708:30181` |
| BrowserResultPage with assistant sidebar expanded | `1708:30204` |
| AssistantSidebar collapsed launcher | `1708:30243` |
| AssistantSidebarPanel compact input | `1708:30323` |
| AssistantSidebarPanel prompt list | `1708:30311` |
| TaskResultPage | `1708:30544` |
| FileListCard (列表卡片/展开) | `1708:30738` |
| NavigationMenu (pill-style nav) | `2080:42251`, `2080:42252` |
| ModelCard / Card board | `2080:40041`; 模型广场 slice `2080:40042`, `2080:40051`, `2080:40064`, `2080:40079` |
| TopTabBar | `2080:8062` (1166×52); first slice: operation + tab-strip |

## Core Workflow

1. Confirm tech-stack profile and existing source of truth.
2. Read design context from Figma.
3. Clean messy drafts only if needed.
4. Extract rough rules and let a human confirm them.
5. Map confirmed rules into Figma foundations.
6. Export real implementation assets from source Figma.
7. Implement code from revised rules plus design context.
8. Verify against Figma and record gotchas.

## Key Rules Already Settled

- Existing spec/design-system rules outrank inferred design rules.
- Missing interaction states must be confirmed first; then they can be added as `provisional` validation states.
- Common interaction patterns can justify proposing provisional states, but cannot silently redefine canonical component rules.
- All icon resources default to the export workflow, preferably `svg`. Inline as SVG component with `currentColor` for theme-reactive icons; only use `<img>` for intentionally fixed colors.
- **Pre-implementation asset check (hard gate):** For every design-owned icon or image, complete the export check before implementation. If the asset already exists in `src/assets/figma/`, import it. If it does not exist yet, export it first. Do not ship component code with inline SVG, placeholder geometry, or handwritten replacement icons while that export check is still incomplete.
- Provisional boards must be standalone (not inside a formal artboard) and have clear canvas separation from neighboring boards.
- Provisional state cards must apply state to the root control container, not by appending extra layers.
- Do not promote a component set to canonical while any family boundary or state axis is still provisional — even if the user explicitly requests it.
- Stateful borders/strokes must not change geometry between states. This applies equally to static components: use `outline` or `inset box-shadow` instead of `border` when Figma specifies exact section heights. Apply `outline` to the element itself (not a parent) to avoid clipping by `overflow: hidden`.
- `figma-execution-shell` is the protocol wrapper for all real component cases.
- Compact action-icon controls should separate interactive size from icon size.
  Default pattern: `24×24` button/hit area with a `16×16` icon frame unless the formal source says otherwise.
- Exported SVG canvas size is packaging data, not the rendered-size contract.
  If a small icon looks wrong in code, inspect the SVG viewBox / padding and normalize the asset before changing component layout.
- Section headers with optional actions should be modeled as separate slots (`label` + optional `action`) rather than as a single undifferentiated row.
- If Figma gives an explicit inner row width, preserve it instead of defaulting list items to `w-full`.
- For icon-size review comments, debug in this order: outer button box → rendered icon box → exported SVG canvas.
- Hidden Figma layers (`hidden="true"`) are a valid source for alternate states when confirmed to represent a distinct product state. Call `get_design_context` with the hidden layer's node ID directly.
- Figma layer name prefixes such as `【H2】`, `【H3】` are Chinese Figma workflow annotation labels, not visible copy. Strip them before rendering; align typography to the node spec.
- All skill README changes must go through a feature branch + PR. Never commit directly to main.
- Newly exported assets must be `git add`-ed before committing. A clean local build does not guarantee CI will pass on a fresh checkout.
- Official Figma MCP skills are the upstream boundary reference, but local
  stricter gates still apply when validated cases prove they are needed:
  asset export-first, provisional approval, hidden-layer product-state
  confirmation, Code Connect maturity checks, and rendered verification.
- `ui-motion-patterns` is a web-only motion rule/template layer. Use it
  after source-of-truth and state confirmation; it does not authorize
  inventing new states or masking static Figma geometry drift.
- New component slices must pass preflight before code is considered
  implementation-ready: component-family card or minimum scope note,
  asset inventory, state-geometry scan, and verification surface. Review
  should grep for unclassified inline SVGs and state-only 0.5px borders.
- Scope expansions of an existing component must also rerun preflight
  when they add a new axis, optional control, design-owned asset, or
  verification surface. Treat them as small follow-up cases, not free
  patches on a closed component.
- New standalone product restoration work should not live under
  `figma-to-code-skills`. Create a product repo, copy
  `templates/product-restoration/`, and complete Product Restoration
  Preflight before UI code: Figma board/state map, layout constants,
  token snapshot, asset manifest, and interaction contract.
- Product restoration must proceed board by board. Each implemented state
  needs a Figma node or approved provisional source; dev-server preview
  is not sufficient handoff evidence without build plus preview/package
  asset verification.
- Product restoration closeout must include a handoff cleanup pass:
  remove temporary demo/test/verification UI from the production-facing
  product, while preserving automated tests, build scripts, and evidence
  docs unless explicitly obsolete.
- **Frame-preserving icon export**: prefer the icon frame node when a
  padded frame exists. If exporting the inner vector directly, record
  why it is canonical and verify the visible glyph bounding box matches
  the Figma inset geometry. Normalize: SVG with frame canvas size, inner
  path translated to inset position.
- **currentColor requires explicit color**: SVG components using
  currentColor render black without an explicit CSS color (e.g. a
  `text-*` class in Tailwind, or an inline `color` style). Always set
  the source color explicitly on the icon component.
- **Outline not border for exact-size surfaces**: `border` shifts root
  height and inner content width under border-box sizing. Use `outline`
  or `inset box-shadow` for components with a fixed Figma frame size.
- **Progress bar in fixed-height flex column**: add `shrink-0` to the
  progress bar and `h-[N] shrink-0` to the label row to prevent flex
  compression from collapsing the bar.
- **Instance-context vs canonical component-set source**: a scaled instance in a board may differ from the formal component set in a spec page (different geometry, radius, border style). Always preflight the canonical component set before implementing. If only an instance is available, document it as instance-derived and flag for correction.
- **Hidden Figma variant handling**: hidden variants (`hidden="true"`) return blank renders from `get_design_context` and `get_screenshot`. Infer structure from sibling variants and metadata; document as inferred in the case card.
- **Hidden fill beats empty-export repair**: Figma ellipse nodes can export as empty SVG groups with no path/circle element, but inspect layer/fill visibility before hand-authoring geometry. If the source fill is `visible=false`, the correct implementation is to render nothing for that layer.
- **Quality gates before PR close**: run `npm run gate` in `agentic-browser-ui` before marking a component case closed. Three gates: `gate:empty-svgs` (catches empty SVG exports without slices-name-map exemption note), `gate:external-urls` (catches external image URLs in verify cards that can be blocked by ORB), `gate:banned-assets` (catches re-imports of legacy/must-not-render assets). See `inventory/quality-gates.md` for details.

## Component Status

| Component | Status | Deferred |
|---|---|---|
| Tab | closed | hover-close lives in provisional validation |
| InputBox | closed | focus-shadow token mismatch accepted as-is; compact sidebar bg remains a deferred non-blocker |
| Toolbar | closed | `border border-[0.5px]` redundancy in urlFocused |
| Dialog | closed (2026-04-16) | HYQiHei font — shared typography pass |
| AIToolsRow | closed (2026-04-17) | active state remains proposal-level |
| Sidebar | verified (expanded + icon-only source) | expanded/default pass closed; icon-only source `1708:30181` matches existing collapsed implementation; hover/active rows + animation deferred |
| BrowserResultPage / AssistantSidebarPanel | closed (2026-05-07) | collapsed launcher closed (PR #13, 56×24 geometry fixed); panel-specific chip/composer verified with no drift; fully closed |
| WorkspacePage / TaskChatPanel | closed (2026-04-22) | Phase 6 Repeatability complete |
| TaskResultPage | closed (2026-05-01) | running state (PR #10) + completed state (PR #11) both merged |
| FileListCard (列表卡片/展开) | closed (2026-05-01) | PR #12 merged; geometry fixed via outline/inset-shadow |
| NavigationMenu | closed (2026-05-09) | PR #14 initial pill nav + PR #15 full variant/manage control; case PRs #43–#44; 1162px surface, 32px pills, 12px tab gap, ManageButton 16px side padding |
| SearchBar | closed (2026-05-09) | agentic-browser-ui PR #16 merged; micro-drift follow-up in PR #18; source `2080:8086`; 240×32, rounded-12, 1.5px border, search+clear icons 18×18, icon-to-text gap 6px, input-to-clear gap 8px, text black |
| ModelCard | closed (2026-05-11) | PR #17 merged; icon-size follow-up renders DeepSeek in 20×20 slot with 18×13.25 visible glyph; DOM evidence all cards 284×132, loading track 244×6/fill 73×6; excludes 写作助手, AI 搜索, AI Space, local tag |
| TopTabBar | closed (2026-05-12) | Phase I (PR #20): operation + tab-strip; Phase J (PR #21): global actions fully closed; 12 assets; frame-preserving normalization + currentColor + multi-layer gradient lessons |
| UpgradeDialog | closed (2026-05-20) | PRs #22/#23 merged; Phase K: downloading state 310×216 (instance-derived); Phase L: corrected to formal component set 2080:40359, all 4 variants 320×222/356, rounded-12, border+shadow; 6 assets; source promotion + hidden variant + hidden-fill export lessons |
| BookmarkItem | closed (2026-05-20) | PR #24 merged; bookmark bar chip 1708:30231~30233; 24px height, content-driven width; generic star icon + app favicon variants; no new assets |
| BookmarkBar | pending (2026-05-21) | PR #30 open; full bar 1708:30228; divider + BookmarkItem(s) + More button; 3 assets exported |

## Phase Status

- Phase 6 Repeatability: **complete** (2026-04-22).
- Phase B — Existing-rule capture validation: **complete** (2026-04-24).
- Phase C — TaskResultPage chain + provisional cleanup: **complete** (2026-05-01).
  - agentic-browser-ui PRs #10–#13 merged
  - figma-to-code-skills PRs #37–#38 merged; 79e67f9 (doc sync)
  - All provisional markers cleared
- Phase D — official skills alignment + motion skill + AssistantSidebarPanel closeout: **complete** (2026-05-07).
  - figma-to-code-skills PR #39 merged: official Figma MCP skills alignment
  - figma-to-code-skills PR #40 merged: `ui-motion-patterns` skill and templates
  - AssistantSidebarPanel compact composer (`1708:30323`) and prompt list (`1708:30311`) verified with no drift
  - `coordination/INDEX.md` cleaned up and Phase D state written
  - Both repos have no open PRs or active track
- Phase E — NavigationMenu + new-slice preflight hard gate: **complete** (2026-05-09).
  - figma-to-code-skills PR #42 merged: new component slices require scope note/case card, asset inventory, and state-geometry scan before code.
  - figma-to-code-skills PR #45 merged: follow-up scope expansions of existing components must rerun preflight when adding a new axis, optional control, design-owned asset, or verification surface.
  - agentic-browser-ui PR #14 + figma-to-code-skills PR #43 merged: initial `2080:42251` NavigationMenu.
  - agentic-browser-ui PR #15 + figma-to-code-skills PR #44 merged: full `2080:42252` NavigationMenu variant board, including optional 管理 control.
  - DOM evidence: 1162px full-width surface, 32px NavOption/More/Manage buttons, 12px tab gap, ManageButton 16px left/right padding.
- Phase F — Sidebar icon-only source confirmation: **complete** (2026-05-09). figma-to-code-skills PR #46 merged.
  - Figma `1708:30181` confirmed as the source for the icon-only/collapsed-like Sidebar rail.
  - `1990:11765` resolves to a single Sidebar component (`1708:30408`) under a plain frame, not a component set, so icon-only is source-confirmed but not a formal Figma variant axis.
  - Existing browser implementation measured: collapsed aside 240×816, padding 16px, icon row 60×24, gap 12px, buttons 24×24, icons 16×16.
- Phase G — SearchBar: **complete** (2026-05-09). agentic-browser-ui PR #16 + figma-to-code-skills PR #48 merged; follow-up PR #18 cleans up 6px icon-to-text spacing, black input text, and focused with-value evidence.
- Phase H — ModelCard first slice: **closed** (2026-05-11).
- Phase I — TopTabBar operation + tab-strip: **closed** (2026-05-12).
- Phase J — TopTabBar global actions: **closed** (2026-05-12).
  - agentic-browser-ui PR #21 merged. TopTabBar fully closed.
  - New lesson: multi-layer gradient icon composition into single SVG canvas.
- Phase L — UpgradeDialog formal source correction: **closed** (2026-05-20).
  - agentic-browser-ui PR #23 merged. figma-to-code-skills PR #60 merged.
  - Corrected Phase K geometry (310×216 instance → 320×222/356 formal component set 2080:40359).
  - All 4 variants implemented: 升级前/升级中/升级成功(inferred)/升级失败.
  - 6 assets exported. `upgrade-fail-circle` is legacy/unused because source ellipse `2080:40429` has fill `visible=false`.
  - New lessons: instance-context vs canonical source; hidden variant handling; check layer/fill visibility before repairing empty SVG exports.
- Phase M — BookmarkItem: **closed** (2026-05-20).
  - agentic-browser-ui PR #24 merged. figma-to-code-skills PR #61 merged.
  - Extracted inline Toolbar bookmark chip to standalone BookmarkItem component.
  - Two icon variants: generic star + app favicon with bg/radius props.
  - Removed unused bookmarked prop from Toolbar and BrowserResultPage.
- Phase N — BookmarkBar: **pending merge** (2026-05-21).
  - agentic-browser-ui PR #30 open. figma-to-code-skills PR #67 open.
  - Full bookmark bar: divider + BookmarkItem(s) + More button (24×24, rounded-99px).
  - 3 assets exported: divider SVG, more-dot SVG, more-icon PNG.
  - Durable lesson: all icons must be exported, not hand-drawn — no exceptions.

## Next Candidates

No active track.

Next candidates:
- browser-ai-tools-product board-by-board UI restoration (independent product track)
- Quality gates: add gate row to existing case cards retroactively
- Quality gates: smallest executable check scripts
