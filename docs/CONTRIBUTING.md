# Contributing

This repo stores reusable XingAI engineering assets: rules, skills, prompts, templates, and patterns.

## Before Adding Anything

Ask:

1. Will this likely be reused at least 3 times in the next 90 days?
2. Can more than one XingAI project benefit?
3. Does it reduce future mistakes or decision fatigue?
4. Is it safe to share publicly?
5. Is the maintenance cost lower than the reuse value?

If the answer is no, keep the solution in the product repo or the current chat.

## Accepted

- Cursor Rules used across repos
- Cursor Skills for repeatable workflows
- Prompts for repeated analysis or writing tasks
- Templates for README, ADR, PRD, POC, and launch docs
- Architecture patterns used across XingAI products
- Beginner-friendly installation and usage docs

## Not Accepted

- Secrets, tokens, API keys, credentials
- Private local paths
- Customer data
- One-off fixes
- Product code
- Production deploy scripts with sensitive details

## Version Rule

Every meaningful change must update:

- `VERSION`
- `README.md` version line
- `README.md` version notes

Use:

- `mini` for docs/copy/template edits
- `minor` for new reusable assets
- `big` for major structure or operating-model changes

## Review Checklist

- [ ] No secrets or private information
- [ ] README version notes updated
- [ ] Beginner instructions included where needed
- [ ] "When to use" and "When not to use" are clear
- [ ] Tradeoffs or common mistakes are documented
