# ADR-004: Team Visual Character System — Shared Brand Cast

**Date:** 2026-10-04
**Status:** Accepted
**Author:** Xing @ XingAI
**Supersedes:** —
**Superseded by:** —
**Also available:** [中文](004-team-visual-character-system.zh.md)

## Context

XingAI marketing and internal decks need a stable cast (星哥 + department leaders). Without a platform rule, each poster, About page, or slide invents new faces, costumes, and hierarchy — the brand drifts.

The reusable skill lives in this repo (`skills/xingai-team-visual/`). Public Team UI lives on `xingai.app` (`xingai-dot-app`). Org-chart assets exist for later; the shipped marketing Team page currently centers Character Bible + banter, not the org chart.

## Decision

**One shared Character Bible owns faces, costumes, colors, and hierarchy. Products and skills consume it; they do not fork a second cast.**

### Cast (required)

| Role | Character | Public nameplate (EN) |
|------|-----------|------------------------|
| Vision / founder | 星哥 | Xing Ge · Vision |
| Research | 牛夫人 | Mrs. Cow · Research |
| Challenge | 至尊宝 | Supreme Treasure · Challenge |
| Verify / QA gate | 小甜甜 | Sweetie · Verify |
| UX / publish | 二当家 | Second Boss · UX |
| Tech / tools | 华安（唐伯虎） | Hua An · Tech |

Hierarchy for visuals: **星哥 → each leader**. Do not invent peer “CEO boards” that flatten 星哥 into one of six equals unless a brief explicitly asks for org-chart mode.

### Ownership

1. **Character Bible + generation skill** → `xingai-engineering-system` / `skills/xingai-team-visual/` (+ personal Cursor skill mirror when installed).
2. **Public Team page** → `xingai-dot-app` (`/team`, Character Bible copy en/zh/ko, banter room, assets under `public/brand/team/`).
3. **Org-chart images** (zh / en / ko) stay in the skill asset set for later use; shipping them on the marketing Team page is optional and currently deferred.

### Rules for new visuals

- Prefer **reference-continuation** from bible / core-five assets over a blank “new character” prompt.
- Keep **至尊宝 deep blue** vs **华安 sky blue** distinct.
- Do not expose internal roadmap labels (V1/V2) on character nameplates.
- Cross-repo links to this ADR use GitHub URLs, not local paths across repos.

## Consequences

- Team posters, About graphics, and marketing Team UI stay visually consistent.
- Adding a seventh public leader requires updating this ADR + the skill bible in the same change.
- `xingai-dot-app` may document product-local Team UX without inventing a second cast.

## Known limitations

- Org chart is asset-ready but not the default public Team composition.
- Banter lines and room animation are product UI concerns in `xingai-dot-app`, not defined here.

## Related

- Skill: [`skills/xingai-team-visual/SKILL.md`](../../skills/xingai-team-visual/SKILL.md)
- Marketing Team: [`xingai-dot-app` `app/[locale]/team/page.tsx`](https://github.com/xingaiapp/xingai-dot-app/blob/main/app/%5Blocale%5D/team/page.tsx)
- ADR-002 Agent Execution Safety (agents as roles; this ADR is brand cast, not execution gates)
