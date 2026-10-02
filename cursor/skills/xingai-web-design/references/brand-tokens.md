# XingAI brand tokens (health / lifestyle apps)

Source of truth for new UI: `xingai-meal-coach-ai/meal_v1/app/globals.css`.

## Light (`:root`)

```css
--background: oklch(0.985 0.004 145);
--foreground: oklch(0.22 0.02 150);
--primary: oklch(0.52 0.19 145);
--primary-foreground: oklch(0.99 0 0);
--card: oklch(1 0 0);
--secondary: oklch(0.96 0.015 145);
--muted-foreground: oklch(0.45 0.03 145);
--border: oklch(0.9 0.02 145);
--input: oklch(0.925 0.015 145);
--ring: oklch(0.52 0.19 145);
--radius: 1rem;
```

## Dark (`.dark`)

```css
--background: oklch(0.14 0.01 145);
--foreground: oklch(0.98 0 0);
--primary: oklch(0.62 0.18 145);
--card: oklch(0.19 0.02 145);
--border: oklch(0.3 0.03 145);
--muted-foreground: oklch(0.72 0.02 150);
```

## Plain CSS apps (meal_v4 style)

Map semantic aliases: `--card`, `--muted`, `--label` (= muted-foreground), `--input-bg` (= input), `--header-bg`, `--chrome-bg`, `--panel-shadow`.

Set `html[data-theme="light"]` / `html[data-theme="dark"]` on document root when using `data-theme` toggles.

## xingai.app marketing site

Uses `--page-bg`, `--ink-strong`, `--blue` in `xingai-dot-app/app/globals.css` — read that file before changing marketing pages; do not paste meal app tokens blindly.

## SAT (`sat.xingai.app`)

- Repo: `xingai-sat-ai/app/globals.css` — **teal-green** brand at **oklch hue ~165** (trial; distinct from meal ~145). Success UI uses `--good` at hue ~142.
- Same chrome pattern as meal_v4: `html[data-theme]`, Plus Jakarta Sans, soft `--hero-glow` (no heavy full-page brand wash).
- Header: language + theme + profile on mobile; drawer duplicates language/theme.
