# Visual System

All diagrams share these tokens. Canvas: **1920 × 1080**, 16:9, white background.

Same visual language, different information architecture.

## Layout grid

| Token | Value |
|-------|-------|
| Outer margin | 80px left/right, 64px top, 56px bottom |
| Title baseline | y = 120 |
| Subtitle baseline | y = 168 |
| Content area | y 220 → 900 |
| Takeaway banner | y 940 → 1024 (optional) |
| Gap between cards | 32px (min 24) |
| Card padding | 28px |
| Card radius | 16px |
| Group container radius | 24px, padding 32px |

## Typography

Font stack: `Inter, "SF Pro Display", "PingFang SC", "Noto Sans CJK SC", "Apple SD Gothic Neo", "Helvetica Neue", Arial, sans-serif`

| Role | Size | Weight | Color |
|------|------|--------|-------|
| Title | 56px | 700 | ink |
| Subtitle | 28px | 400 | ink-2 |
| Group label (caps, letter-spacing 2px) | 20px | 700 | group accent |
| Card title | 28px | 600 | ink |
| Bullet | 20–22px | 400 | ink-2 |
| Note / L5 | 18px | 400 | gray |

Never go below 18px. If it does not fit, cut content.

## Colors (semantic)

Do not assign these at random.

| Semantic | Accent (stroke, icon, label) | Fill |
|----------|------------------------------|------|
| Blue — global / core / platform / primary | `#2563EB` | `#EFF6FF` |
| Green — regional / localization / extension / success | `#059669` | `#ECFDF5` |
| Purple — configuration / supporting / optional | `#7C3AED` | `#F5F3FF` |
| Yellow — key decision / goal / insight | `#D97706` | `#FFFBEB` |
| Red — risk / problem / anti-pattern | `#DC2626` | `#FEF2F2` |
| Gray — secondary | `#64748B` | `#F8FAFC` |

Neutrals: ink `#0F172A`, ink-2 `#334155`, border `#E2E8F0`, background `#FFFFFF`.

Cards: semantic fill, 2px stroke in the accent (or `#E2E8F0` for a neutral card). Optional shadow: `drop-shadow(0 2px 6px rgba(15,23,42,.06))`. No gradients. No heavy 3D.

## Card anatomy

```
┌───────────────────────────┐
│ [icon]  Card Title        │
│ • bullet                  │
│ • bullet                  │
└───────────────────────────┘
```

Title plus optional icon plus 2–5 concise bullets. No paragraphs.

## Connectors

| Meaning | Style |
|---------|-------|
| Dependency / flow (↓) | 3px solid `#94A3B8`, filled triangle head |
| Interaction (→) | 3px solid `#94A3B8` |
| Bidirectional (↔) | heads on both ends |
| Optional / indirect | 3px dashed `8 6` |
| Emphasized path | 4px, accent color of the source group |

Straight or right-angle routing. No crossings. A short edge label (≤ 3 words, 18px, white pill) only when the relation is not obvious.

## Icons

Simple 2px-stroke line icons. 36px in cards, 48px on group headers, colored with the group accent. One icon per card. Draw only icons that change the meaning: globe, pin, flag, database, gear, shield, document, card, exchange arrows, cube, spark/AI, user.

## Title and takeaway

- Title: short, bold, executive-friendly.
- Subtitle: optional, one line, states the message.
- Takeaway banner: full width, yellow fill `#FFFBEB`, left 6px bar `#D97706`. Label `KEY TAKEAWAY` or `KEY PRINCIPLE` (18px caps) plus one sentence (26px, ink). Generate the sentence from this topic. Do not reuse a sample sentence.
