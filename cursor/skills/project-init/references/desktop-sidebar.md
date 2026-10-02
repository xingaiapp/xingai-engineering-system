# Desktop left menu (open / close)

Required for every XingAI product UI with a desktop side menu. Reference: Invest AI `sidebar-nav.tsx` edge toggle.

## Required behavior

1. **Open / close control (required)**  
   Desktop must expose a clear control to expand and collapse the left menu. Do not bury the only toggle at the bottom of a long sidebar.

2. **Button in the middle of the menu edge**  
   Put the primary toggle on the **vertical center** of the left menu’s right edge (halfway down the viewport), overlapping the boundary between menu and content. Pattern: `absolute top-1/2 -translate-y-1/2 -right-*` on a `fixed` / `sticky` aside. Icon: panel / chevron that rotates when closed. Accessible `aria-label` + `aria-expanded`.

3. **Left menu is fixed position**  
   On `lg+` (or the repo’s desktop breakpoint), the left menu is **`position: fixed`** (or equivalent that stays pinned while the page scrolls): `top: 0`, `left: 0`, full viewport height, own width. It must not scroll away with the page.

4. **Right content moves — whole menu stays visible**  
   Opening / closing the menu must **shift the main content** (padding/margin/width on the content column), not overlay and hide nav items.  
   - Open: content starts after the full menu width; the entire menu (brand, nav, footer links) remains visible.  
   - Closed (rail): content starts after the icon-rail width; menu shows icon-only destinations with tooltips / `sr-only` labels — still fully usable.  
   Do **not** cover the menu with a drawer that clips items, and do not leave content under a fixed menu without offset.

## Layout sketch

```txt
┌──────────┬────────────────────────────┐
│  MENU    │  MAIN CONTENT              │
│ (fixed)  │  (margin/padding-left      │
│          │   = menu width)            │
│     [≡]──┤  ← toggle mid-edge         │
│          │                            │
└──────────┴────────────────────────────┘
```

When the menu collapses to a rail, reduce the content offset to the rail width so nothing sits under the menu.

## Optional extras

- Persist open/closed in `localStorage` (or cookie).
- Duplicate toggle in a desktop top bar if useful; the **mid-edge** control remains required.
- Transition width / content offset (~200–300ms); respect `prefers-reduced-motion`.

## Fail conditions

- No desktop open/close control.
- Toggle only in the sidebar footer or only in a hard-to-find corner.
- Fixed menu overlays content with no content offset (menu or content clipped / unreadable).
- Closing the menu hides destinations with no icon rail / no way to reopen.
