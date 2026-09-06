# Hero visuals (light + dark)

Product apps and marketing demos need **theme-aware hero imagery**, not a single generic asset.

## In-app hero (product `*.xingai.app`)

Primary landing route (Overview, home, or main decision screen) must include:

1. **Copy block** — headline, subcopy, primary CTA (decision path first in DOM).
2. **Hero visual** — decorative product illustration or dashboard mock that explains the product.
3. **Light + dark pair** — swap by theme; do not reuse one PNG for both.

### File convention (default)

| Theme | Typical path |
|-------|----------------|
| Light | `public/brand/hero-bg-light-visual.png` |
| Dark | `public/brand/hero-bg-visual.png` |

Repos may use different names; document paths in README. Match existing product if the repo already has a pattern.

### Layout convention

- **Desktop (`lg+`):** two-column hero — copy left, visual right (see Research AI).
- **Mobile:** compact hero strip under copy (`h-36`–`h-40`) with same light/dark swap.
- Use `next/image` + `dark:hidden` / `dark:block` (or repo `ThemedImage` helper).

**Reference:** `xingai-research-ai/components/research-hero.tsx`

### What does NOT count as the in-app hero

- `public/og-image.png` — social / Open Graph only
- App icon / favicon only
- CSS gradient with no product-specific visual
- Screenshot used only on `xingai.app` marketing card

## Marketing registry (`xingai-dot-app`)

When registering a product in `app/data/apps.ts`, each screenshot entry should include:

```ts
{
  src: "/{product}-demo-light.jpg",
  srcDark: "/{product}-demo-dark.jpg",
  alt: "…",
  caption: "…",
}
```

`AppDemoScreenshot` + `ThemedImage` swap `src` / `srcDark` with site theme.

**Reference:** `xingai-dot-app/docs/marketing-site-standards.md`

## Agent verification

Before calling hero “done”:

- [ ] Light theme shows light hero asset on primary route
- [ ] Dark theme shows dark hero asset (not the same file stretched)
- [ ] Mobile has a visible hero strip or integrated visual (not desktop-only)
- [ ] dot-app card has `srcDark` if the product is registered
- [ ] OG image exists separately for metadata
- [ ] Icons + motion hard gate also pass — see [visual-motion.md](visual-motion.md)
