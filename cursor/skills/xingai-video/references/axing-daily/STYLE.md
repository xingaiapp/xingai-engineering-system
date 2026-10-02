# Axing Daily visual reference

**Source:** private local deck (not published in this public repo). Keep a PPTX on your machine if you need pixel-match QA; this file captures the reusable palette / type / board rules only.

**Scaffold theme id:** `axing-daily`  
(`~/.cursor/skills/web-video-presentation/themes/axing-daily/` or this repo's `web-video-presentation` skill)

Use for **美股日记 / Daily Investment Report / 星播报** web-video — match color, font, size hierarchy, and board layout. Do **not** substitute `midnight-press` / purple glow / Inter defaults unless the user overrides theme.

## Stage geometry

| PPTX | Value |
|------|--------|
| Slide size | 9144000 × 5143500 EMU → **10" × 5.625"** (16:9) |
| Web stage | Map to **1920×1080**; keep same proportions |

**pt → CSS px @ 1920 wide:** `px ≈ pt × (1920 / 720) = pt × 2.667`

## Colors (from live slides — prefer these over unused theme leftovers)

| Role | Hex | Notes |
|------|-----|--------|
| Shell / chrome | `#0A0A0A` | YouTube / recording black around stage |
| Surface (paper) | `#EEF3F7` | Default slide background |
| Panel / card | `#F3F3F3` | Inset blocks |
| Soft rail | `#D0E0E3` | Table borders / rules |
| Chip / header fill | `#C9DAF8` / `#A4C2F4` | Soft blue cells |
| Ink | `#000000` | Primary type |
| Secondary ink | `#434343` | Supporting lines |
| Mute / table 2nd | `#9E9E9E` | Most common fill in tables |
| Accent blue | `#4A86E8` | Section titles, emphasis |
| Up / positive | `#38761D` / `#274E13` | Gains, “买” positive |
| Brand orange | `#F46524` | Channel Swiss theme dk1 / coin family |
| Brand navy | `#000B26` | Logo outline / 阿星 wordmark |
| Highlight | `#FFFF00` | Rare; cold-open only |

Theme2 scheme also has teal/cyan accents (`#27C7BD`, `#0099E8`) — optional for secondary charts; **do not** invent purple.

## Fonts

| Role | Family (as in PPTX) | Web fallback |
|------|---------------------|--------------|
| Body / numbers | **Lato** (dominant) | Lato → Arial |
| Display accents | **Raleway** | Raleway → Lato |
| UI leftovers | Calibri / Arial | Arial |
| 中文 | (PPT falls through; keep sans) | **Noto Sans SC** / PingFang SC |

Load Google Fonts: `Lato:400,700,900` + `Raleway:600,700` + `Noto Sans SC:400,700`.

**Never** default Inter / Instrument Serif for this theme.

## Type scale (PPT pt → ~1080p)

| Role | PPT pt | ≈ CSS px @1920 | Weight |
|------|--------|----------------|--------|
| Cold-open hero | 68 | ~181 | Bold |
| Big ticker / price | 32–38 | ~85–101 | Bold |
| Section title (often blue) | 27 | ~72 | Bold |
| Card title / index name | 20–25 | ~53–67 | Bold |
| Body / update line | 18–21 | ~48–56 | Bold/Regular |
| Label / table head | 16–17 | ~43–45 | Regular |
| Meta / YouTube URL | 10–13 | ~27–35 | Bold |
| Disclaimer | 7–12 | ~19–32 | Bold |

Hierarchy rule: **one hero number or ticker per beat**; body stays Lato; blue `#4A86E8` only on section titles / key labels — not every line.

## Layout habits (from the deck)

1. **Light paper board** on black shell — not full-bleed cream, not dark terminal.
2. **Disclaimer** almost every content slide: 个人实盘 / 非投资建议 (XingAI: keep 免责 / 未核实 beats).
3. **Update cards:** “更新：” + action (买入/卖出) + **share count** as hero + ticker + `$price / 股`.
4. **Index table:** 指数 | 收盘点位 | 涨跌幅 — gray secondary cells, black numbers.
5. **Watch / DCA grids:** soft blue chips, ticker codes in sans caps.
6. **Logo lockup** (optional): `media/logo-axing.png` — do not stretch; keep circular avatar crisp.

## Anti-patterns for this theme

- Purple gradients, glow blobs, glassmorphism stacks
- Warm cream + terracotta (paper-press / forest-ink cliché)
- Serif editorial (`newsroom`) unless user asks
- Tiny dense dashboards — diary beats stay **large type, few numbers**
- Inventing metrics not in the source PDF/article

## Checkpoint Plan default

When topic is XingAI Daily Report / 美股日记 / 星播报:

> Theme: **`axing-daily`** (match 阿星美股日记 PPTX)

Alts only if user refuses light board: `electric-studio` (corporate blue) or `midnight-press` (ops deep-dive).
