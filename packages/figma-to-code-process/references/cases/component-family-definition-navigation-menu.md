# Component Family Definition — NavigationMenu

## Status

`verified` — implementation complete; build, visual review, and DOM geometry
checks passed

## Source

- Figma file: `iIbL9V4UrFeORPaM7KVji7`
- Initial source node: `2080:42251` (TabMenu 区域，联想规范页 `925:13013`)
- Full variant source node: `2080:42252`
- Component name in Figma: NavMenu / 导航菜单

## Scope

Pill-style horizontal navigation menu. Supports 3–10 items with a selected
state, optional overflow "more" button, and optional right-side control button
(管理). The first pass covered the core pill/menu shape; the follow-up pass
brings the full `2080:42252` variant board into scope.

## Implementation

- File: `agentic-browser-ui/src/components/NavigationMenu.tsx`
- Initial branch: `feature/navigation-menu`
- Follow-up branch: `feature/navigation-menu-variant-expansion`
- Exported asset: `src/assets/figma/nav-more-icon@1x.svg` (icon/更多, from design context)
- Exported asset: `src/assets/figma/nav-manage-icon@1x.svg` (icon/设置（大）, from design context)

## Component Axes

### NavOptionItem

| Axis | Values |
|---|---|
| state | Normal, Selected |

- Normal: `bg-white outline-[0.5px] outline-[rgba(0,0,0,0.1)] text-[#18181b]`
- Selected: `bg-[#18181b] text-white outline-transparent`
- Geometry rule: 0.5px visual stroke uses `outline`, not `border`, so selected and normal states keep identical 32px layout height
- Padding: `px-[16px] py-[5px]`, radius: `rounded-[12px]`, text: `14px / 22px HYQiHei:60S`

### MoreButton

- Shown when `showMore=true`
- Same pill geometry as Normal NavOptionItem
- Icon: `nav-more-icon@1x.svg` (15×3px three-dot, `currentColor`)
- Icon container: `size-[18px]` wrapper, icon `w-[15px] h-[3px]`
- Height: `32px`, matching NavOptionItem DOM measurement

### ManageButton

- Shown when `showManage=true`
- Same 32px pill height as NavOptionItem and MoreButton
- Icon: `nav-manage-icon@1x.svg` (`18 × 18`, `currentColor`)
- Label: `管理`, `14px / 22px HYQiHei:60S`
- Padding/gap: `px-[16px] py-[5px] gap-[4px]`
- DOM padding check: button `82 × 32`; icon frame starts 16px from the
  left edge; text ends 16px from the right edge. The gear path is inset
  inside its own 18px SVG frame, matching Figma's icon structure.

### NavigationMenu (container)

- `gap-[12px]` between items
- `flex items-center justify-between` outer layout
- Full-width management variant uses `1162px` verification surface, matching
  the full Figma variant board.

## NavigationMenu Axes

| Axis | Values |
|---|---|
| `itemCount` | `3` through `10` |
| `selectedIndex` | item index; Figma board shows first item selected |
| `showMore` | `false`, `true` |
| `showManage` | `false`, `true` |

## Verification Status

| Check | Status |
|---|---|
| Build passes (tsc + vite) | ✓ |
| Selected pill geometry stable (no layout shift) | ✓ outline stroke; no layout-affecting border |
| MoreButton uses exported asset | ✓ |
| ManageButton uses exported asset | ✓ |
| ManageButton left/right padding | ✓ 16px left and right, matching Figma `control_btn` |
| Visual match vs Figma screenshot | ✓ verified in browser review |
| DOM geometry measurement | ✓ NavOptionItem 32px; MoreButton 32px; ManageButton 32px; `2080:42252` surface 1162px; tab gap 12px; manage button right edge 1162px |

## Deferred

- Hover/pressed states (not shown in formal Figma spec node)
- Overflow scroll behavior for > 10 items
