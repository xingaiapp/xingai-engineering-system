---
name: xingai-web-design
language: zh-CN
description: >-
  供阅读的中文说明。Agent 仍可使用英文 SKILL.md；实现 XingAI 各 *.xingai.app
  产品 Web 界面时请遵循本文与英文版一致的要求。
---

# XingAI Web 设计（中文版）

面向 **XingAI 消费端 Web 应用** 与 **xingai.app** 的前端设计指引。在 [web-design-engineer](https://github.com/ConardLi/garden-skills) 的审美与工作流基础上，叠加 **XingAI 产品规则** —— 不是通用落地页生成器。

> 英文版（给 Agent）：[SKILL.md](SKILL.md)

## 何时使用

- 在 `xingai-*` 仓库中新增页面、组件、CSS 或主题
- 移动端顶栏、侧栏菜单、底部导航、浅色/深色主题
- Meal / Cook / Routine / Invest / 官网等前端
- 用户要求「对齐 V1」「XingAI 风格」「决策类 UI」

**不适用：** 后端 API、Worker、仅改 Vercel 配置、无可视界面的脚本。

## 不可违反的产品规则

工作区若有以下文件，应先阅读：

- `AGENTS.md` — 版本升级 + Invest 决策边界
- `xingai-product-upgrade-rules.md` — 版本继承

摘要：

1. **升级，而非重做** — 新版本继承上一版 UX；保持同一产品身份与主流程。
2. **界面不暴露内部版本号** — 用户看不到「V1/V2/V4」等标签。
3. **决策系统，而非聊天机器人** — 每屏一个主要结果；输出结构化（动作、风险、置信度、下一步）；聊天可有可无，不是产品本体。
4. **Invest AI** — 文案风险优先；免责声明；不承诺收益；决策看板仍是主界面。

## 工作流程（精简）

1. **读上下文** — 阅读本仓库已有的 `globals.css`、`layout.tsx`、相邻组件。**代码优先于截图**。
2. **声明设计系统**（大改前） — 用 Markdown 写清色板、字体、间距、圆角、动效；大改动需用户确认。
3. **实现** — 贴合仓库技术栈（v1 应用：Tailwind v4 + shadcn；轻量 demo：纯 CSS）。
4. **移动端** — 见 [references/mobile-chrome.zh-CN.md](references/mobile-chrome.zh-CN.md)。
5. **验收** — 浅色/深色、375px 宽度、安全区、顶栏控件不重叠。

幻灯片、一次性营销页或重度视觉探索时，可另读工作区内的 `web-design-engineer/SKILL.md`（本地副本，不提交 Git）。

## 设计 Token（健康/生活方式类默认）

除非仓库已有 token，默认使用 **色相约 145 的绿色**（以 meal V1 为准）。完整表见 [references/brand-tokens.zh-CN.md](references/brand-tokens.zh-CN.md)。

| 角色 | 浅色 oklch | 深色 oklch |
|------|------------|------------|
| 背景 | `0.985 0.004 145` | `0.14 0.01 145` |
| 前景字 | `0.22 0.02 150` | `0.98 0 0` |
| 主色 | `0.52 0.19 145` | `0.62 0.18 145` |
| 卡片 | `1 0 0` | `0.19 0.02 145` |
| 边框 | `0.9 0.02 145` | `0.3 0.03 145` |
| 次要文字 | `0.45 0.03 145` | `0.72 0.02 150` |

- 优先 **oklch**，避免随意 hex。
- **浅色主题** = 通透、扁平或轻微径向渐变 —— 浅色模式下不要用深色渐变背景。
- **圆角** — 基准 `1rem`（V1）；移动端顶栏不要用 110px 巨圆按钮。

## 反模式（禁止）

**典型 AI 审美套路**

- 默认 Inter + `#3b82f6`
- 紫粉渐变 Hero、处处毛玻璃
- 用 Emoji 当图标、假用户评价、千篇一律的「AI SaaS」卡片

**XingAI 特有**

- 用通用仪表盘替换 Decide/Today/Scan 主流程
- 在移动端隐藏语言/主题/个人资料，但侧栏里没有替代入口
- Vercel `cd 子目录` 与 Root Directory 配置打架（若动部署，写进 `VERCEL.md`）
- 顶栏控件过大（>48px）压住产品标题

## 仓库对照

| 产品 | 仓库（常见） | 应用路径 | 域名 |
|------|--------------|----------|------|
| 官网 | `xingai-dot-app` | 根目录 | xingai.app |
| 餐饮决策 | `xingai-meal-coach-ai` | `meal_v1` / `meal_v4` | meal.xingai.app |
| 烹饪 | `xingai-cook-ai` | `cook_v1` | cook.xingai.app |
| 作息 | `xingai-routine-ai` | `routine_v1` | routine.xingai.app |
| 投资 | `xingai-invest-ai` | `stock-ai-front-end` | invest.xingai.app |

详见 [references/product-repos.zh-CN.md](references/product-repos.zh-CN.md)。

## 交付前检查清单

```
- [ ] 与仓库现有 token / Tailwind 主题一致（未私自换一套色板）
- [ ] 浅色、深色均可读
- [ ] 移动端：菜单与主导航可达；控件 ≤44px；标题可截断
- [ ] 主用户路径相对上一版未被打断
- [ ] 界面无 V1/V2 等内部版本字样
- [ ] 决策结果无需滚过聊天区才能看到
- [ ] Invest 相关界面含必要的免责声明语气
```

## 延伸阅读（中文）

- [references/brand-tokens.zh-CN.md](references/brand-tokens.zh-CN.md) — oklch 浅色/深色片段
- [references/mobile-chrome.zh-CN.md](references/mobile-chrome.zh-CN.md) — 顶栏、抽屉、底栏
- [references/product-repos.zh-CN.md](references/product-repos.zh-CN.md) — 仓库与部署说明
