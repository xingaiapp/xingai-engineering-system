# Mobile chrome (XingAI pattern)

## Marketing (`xingai-dot-app`)

- Breakpoint: `max-width: 35.99rem` (~576px)
- **Header:** hamburger → `MobileNavDrawer` (primary links)
- **Bottom:** `MobileBottomNav` (4 tabs, fixed, safe-area padding)
- **Desktop:** top nav only; no drawer/bottom bar
- Reference: `app/components/Header.tsx`, `MobileNavDrawer.tsx`, `MobileBottomNav.tsx`

## Product apps (meal / cook / routine)

- **Header:** sticky bar ~56px; hamburger + brand + **language + theme + profile** visible on mobile (36–44px circles, no 110px controls)
- **Side menu:** full nav + language/theme when header is crowded
- **Bottom nav:** product-specific tabs where implemented
- Light header/footer: `var(--header-bg)` on `html[data-theme="light"]`

## Rules

1. Never hide language/theme/profile on mobile without equivalent in side menu.
2. Truncate long titles (`text-overflow: ellipsis`); optional hide logo on narrow widths.
3. `padding-bottom` on main content = bottom nav height + safe area.
4. Theme on `<html data-theme>` for plain CSS apps; `next-themes` + `.dark` class for Tailwind v1 apps.
