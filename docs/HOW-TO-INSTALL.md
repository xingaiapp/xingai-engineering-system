# How To Install XingAI Engineering Assets

This guide explains how to copy reusable rules and skills into a new Cursor workspace.

## 1. Clone This Repository

```bash
git clone https://github.com/xingaiapp/xingai-engineering-system.git
cd xingai-engineering-system
```

## 2. Install Cursor Rules Into A Project

In the target project:

```bash
mkdir -p .cursor/rules
cp cursor/rules/*.mdc /path/to/target-project/.cursor/rules/
```

Why this works:

Cursor reads `.cursor/rules/*.mdc` as persistent project guidance. Rules are good for standards that should apply every time, such as i18n, README version notes, and legal/SEO requirements.

Common mistake:

Do not copy every rule blindly. Copy rules that fit the repo. For example, POC-specific rules belong in POC repos, not every product app.

## 3. Install Cursor Skills

Global user skills usually live in:

```text
~/.cursor/skills/
```

Project-specific skills can live in:

```text
.cursor/skills/
```

Copy a skill folder:

```bash
mkdir -p ~/.cursor/skills
cp -R cursor/skills/project-init ~/.cursor/skills/
cp -R cursor/skills/xingai-web-design ~/.cursor/skills/
```

Why this works:

Skills are better than rules for repeatable workflows with multiple steps. For example, `project-init` is a workflow for bootstrapping a new app. `xingai-web-design` is a workflow for UI work.

Common mistake:

Do not put secrets, private deployment commands, or machine-specific paths inside public skills.

## 4. Use Prompts

Prompts in `prompts/` are plain Markdown. Copy the prompt into Cursor, Claude, or another assistant when you need that task.

Example:

```text
prompts/reusable-asset-review.md
```

Use it when you want to decide whether a workflow should become a rule, skill, prompt, template, or pattern.

## 5. Use Templates

Templates in `templates/` are starting points for new docs.

Copy one into the target repo, rename it, then fill in the blanks.

## 6. Safety Checklist Before Sharing

Before copying anything into this public repo, check:

- No API keys or tokens
- No `.env` values
- No private local file paths
- No customer data
- No production-only secrets
- No one-off prompt that only helps a single issue

## Beginner Rule

Start with the smallest useful asset. A good system grows from repeated patterns, not from guessing every future need.
