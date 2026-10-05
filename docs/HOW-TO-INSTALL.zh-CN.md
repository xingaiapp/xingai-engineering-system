# 如何安装 XingAI 工程资产

[English](HOW-TO-INSTALL.md) · 中文

本指南介绍如何把可复用的规则和技能复制到一个新的 Cursor 工作区。

用 Claude Code？请看 [`INSTALL-CLAUDE-CODE.zh-CN.md`](INSTALL-CLAUDE-CODE.zh-CN.md)，在任意机器上把这些技能软链到 `~/.claude/skills/`。

## 1. clone 本仓库

```bash
git clone https://github.com/xingaiapp/xingai-engineering-system.git
cd xingai-engineering-system
```

## 2. 把 Cursor 规则装进项目

在目标项目里：

```bash
mkdir -p .cursor/rules
cp cursor/rules/*.mdc /path/to/target-project/.cursor/rules/
```

为什么这样有效：

Cursor 会把 `.cursor/rules/*.mdc` 当作持久的项目指引来读。规则适合放每次都要遵守的标准，比如 i18n、README 版本说明、法律和 SEO 要求。

常见错误：

不要不加分辨地把所有规则都复制过去，只复制适合这个仓库的。比如只针对 POC 的规则应该放在 POC 仓库里，不该放进每个产品应用。

## 3. 安装 Cursor 技能

全局的用户技能通常放在：

```text
~/.cursor/skills/
```

只给某个项目用的技能可以放在：

```text
.cursor/skills/
```

复制技能文件夹：

```bash
mkdir -p ~/.cursor/skills
cp -R cursor/skills/project-init ~/.cursor/skills/
cp -R cursor/skills/xingai-web-design ~/.cursor/skills/
cp -R cursor/skills/research-ai-loading-ux ~/.cursor/skills/
cp -R cursor/skills/growth-deploy ~/.cursor/skills/
cp -R cursor/skills/project-ship ~/.cursor/skills/
cp -R cursor/skills/enterprise-coding-behavior ~/.cursor/skills/
cp -R cursor/skills/enterprise-agent-team ~/.cursor/skills/
cp -R cursor/skills/xingai-mcp-builder ~/.cursor/skills/
cp -R cursor/skills/xingai-team-visual ~/.cursor/skills/
```

如果想让某个项目始终遵守编码行为准则，再把这条规则也复制过去：

```bash
cp cursor/rules/enterprise-coding-behavior.mdc /path/to/target-project/.cursor/rules/
```

为什么这样有效：

对于多步骤、可重复的工作流，技能比规则更合适。各技能的用途：

- `project-init`：新应用的初始化流程。
- `xingai-web-design`：前端 UI 工作流程。
- `growth-deploy` / `invest-deploy` / `project-ship`：产品部署。
- `xingai-docs-pack` 和 `xingai-docs-sync`：文档。
- Wiki 类技能（`xingai-ai-learning-wiki`、`xingai-wiki-ingest`、`xingai-ux-png`）：保证公开学习库内容准确。
- `xingai-video` + `web-video-presentation` + `universal-diagram`：演示类媒体。
- `xingai-team-visual`：让 XingAI 团队图和 About 页插图都按同一套六人角色设定（星哥 + 五位负责人）来画。
- `research-ai-loading-ux`：AI 和搜索的加载状态，需要显示进度、已用时间、完成状态和重试。
- `enterprise-coding-behavior`：XingAI 企业版的 Karpathy 式编码纪律。
- `enterprise-agent-team`：把同样的标准用到 Planner / Research / Coding / Reviewer / Architect 各个角色上。
- `xingai-mcp-builder`：XingAI 版的 MCP 构建技能，以 Python 网关和执行闸门为主，不默认从零写 TypeScript。

常见错误：

不要在公开技能里放密钥、私有部署命令或本机专用路径。

## 4. 使用提示词

`prompts/` 里的提示词都是普通 Markdown。需要做某项任务时，把对应提示词复制到 Cursor、Claude 或其他助手里。

例子：

```text
prompts/reusable-asset-review.md
```

当你想判断一个工作流该做成规则、技能、提示词、模板还是模式时，用这一个。

其他常用提示词：

- `prompts/code-change.md`：实现功能或修复问题，写清楚做什么、不做什么
- `prompts/code-review.md`：合并前审查 diff
- `prompts/pr-description.md`：写 PR 描述

## 5. 使用模板

`templates/` 里的模板是新文档的起点。

复制一份到目标仓库，改个名字，再把空白处填上。

## 6. 分享前的安全检查

往本公开仓库复制任何东西之前，先检查：

- 没有 API key 或 token
- 没有 `.env` 里的值
- 没有私有的本地文件路径
- 没有客户数据
- 没有只属于生产环境的密钥
- 没有只解决某一个问题的一次性提示词

## 新手原则

从最小的有用资产开始。好的体系是从反复出现的模式里长出来的，而不是靠猜测未来所有需求。
