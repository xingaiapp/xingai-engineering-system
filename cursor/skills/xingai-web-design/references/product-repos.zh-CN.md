# XingAI Web 产品仓库

工作区根目录（常见）：`ai-projects-work-space/`

| 域名 | 仓库 | 前端根路径 | 说明 |
|------|------|------------|------|
| xingai.app | xingai-dot-app | `/app` | Next.js 官网 |
| meal.xingai.app | xingai-meal-coach-ai | meal_v1（完整）、meal_v4（演示） | Vercel Root Directory 指向子目录 |
| cook.xingai.app | xingai-cook-ai | cook_v1 | |
| routine.xingai.app | xingai-routine-ai | routine_v1 | |
| invest.xingai.app | xingai-invest-ai | stock-ai-front-end | 决策看板，中英双语 |
| sat.xingai.app | xingai-sat-ai | `/app` | SAT 错题分析；青绿 oklch（hue ~165），`html[data-theme]` |
| travel / outfit / parent 等 | xingai-travel-ai 等 | 各仓库内 | 同样遵循升级规则 |

## 部署

- Monorepo 布局时，各应用子目录可有 `vercel.json` + `VERCEL.md`。
- Vercel **Root Directory** 只能选一种模式：留空 **或** 填子目录 —— 不能两套混用。

## 仅本地（工作区根目录 gitignore）

- `web-design-engineer/` — 上游 skill 克隆；日常请用 `~/.cursor/skills/xingai-web-design/` 的 XingAI 规则。
