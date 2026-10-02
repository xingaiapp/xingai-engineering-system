---
name: xingai-video
description: >-
  XingAI alias for ConardLi web-video-presentation: turn an article or 口播稿 into
  a clickable 16:9 Vite/React stage for screen-recording (Bilibili / YouTube /
  视频号). Use when Xing asks for a web video, 录屏教程, cinematic product demo,
  dynamic PPT that is not a slide deck, or /xingai-video. Applies XingAI defaults
  (anti-AI-slop, honest claims, preferred themes, axing-daily visual reference)
  then runs the full garden skill.
---

# XingAI Video (`/xingai-video`)

**Quick invoke:** `/xingai-video` or “用 xingai-video 做一支录屏视频”.

Thin alias. **Do not re-implement the pipeline here.** Immediately read and follow:

`~/.cursor/skills/web-video-presentation/SKILL.md`

(upstream: [ConardLi/garden-skills …/web-video-presentation](https://github.com/ConardLi/garden-skills/tree/main/skills/web-video-presentation))

If that folder is missing, clone/copy from the GitHub path above into `~/.cursor/skills/web-video-presentation/` before continuing.

## XingAI defaults (apply on top of the garden skill)

1. **Anti-AI-slop** — Follow workspace anti-AI writing + design rules. Do not ship Inter + purple glow defaults; redesign tokens/motion for the topic even when scaffolding a theme.
2. **Preferred themes (starting point, not mandatory):**
   - **美股日记 / Daily Investment Report / 星播报 / 日更实盘** → **`axing-daily`** (required default unless user overrides) — match colors / font / board styles in `references/axing-daily/STYLE.md` (PPTX + sample media stay local / private).
   - Architecture / CQRS / worker boundaries → `blueprint`
   - Dev / terminal / Invest-ops deep-dive → `midnight-press` or `terminal-green`
   - Product pitch / launch → `bold-signal` or `electric-studio`
   - Lifestyle / Meal / Cook → ask before `paper-press` / `forest-ink` (avoid cream+terracotta cliché unless intentional)
3. **Honest product claims** — No income guarantees; keep `未核实` / disclaimer beats when the topic is Passive Income / Invest. Don’t invent metrics.
4. **Language** — Default 口播 to the language of the source article. For XingAI public products, offer EN + 中文 script variants only if the user asks (don’t silently bilingual every frame).
5. **Working dir** — Prefer a dedicated folder under the workspace, e.g. `ai-projects-work-space/xingai-web-video-<slug>/`, or reuse `xingai-web-video-test` for smoke demos. Don’t dump `presentation/` into a product app repo root unless asked.
6. **Checkpoints stay hard** — Still stop for garden Phase 1 Plan (script / outline / theme / assets / mode) and chapter-1 acceptance. XingAI alias does not skip gates.

### Visual reference: 阿星美股日记 (`axing-daily`)

Published in this public skill:

- Token + type scale + layout habits: `references/axing-daily/STYLE.md`
- Garden theme: `web-video-presentation/themes/axing-daily/` (`theme.json` + `tokens.css`)

Not published (keep on the operator’s machine if needed for pixel QA): original PPTX / sample media.

When scaffolding or restyling a daily-report video:

```bash
bash ~/.cursor/skills/web-video-presentation/scripts/scaffold.sh ./presentation --theme=axing-daily
```

Match **same color, font, size hierarchy, and diary-board styles** as the PPTX. If an existing `presentation/` uses another theme, swap `src/styles/tokens.css` from `axing-daily` and load Lato + Raleway + Noto Sans SC before polishing chapters.

## First actions when invoked

```text
/xingai-video:
- [ ] 1. Read ~/.cursor/skills/web-video-presentation/SKILL.md
- [ ] 2. Confirm topic + source (paste / URL / file) + target folder
- [ ] 3. Propose theme from XingAI defaults above
      - If Daily Report / 美股日记 → propose axing-daily + skim STYLE.md
- [ ] 4. Run Phase 1 → Checkpoint Plan (5 items) before any chapter code
```

## Not for

- XingAI product app UI work → use `xingai-web-design`
- Wiki / ADR docs → `xingai-wiki-ingest` / `xingai-docs-sync`
- Camera-shot or After Effects heavy edits (this skill is web-stage + screen record)
