# Code Change Prompt

Use this prompt when asking Cursor / Claude to **implement any code change** in a XingAI repo (feature, fix, refactor, docs-tied code, paper strategy, API route, UI copy).

Paste the filled template into chat. Pair with `code-review.md` after the change and `pr-description.md` before opening a PR.

```text
Implement this code change in the target XingAI repo. Do not edit any plan file I attach unless I say so.

## Repo
[path or name, e.g. invest-performance-sim]

## Goal
[one sentence: what should work when done]

## In scope
- [bullet: files / modules / behaviors to touch]
- [bullet]

## Out of scope (do not do)
- [bullet: e.g. live broker orders, minute ORB engine, unrelated refactors]

## Constraints (XingAI)
- Read AGENTS.md / repo ADRs / .cursor/rules first when they apply.
- Match existing patterns: naming, folders, i18n layer, theme tokens, paper vs live boundaries.
- Mobile-first if UI; en / zh / ko for new user-facing strings; light + dark.
- No secrets in git. No fake “production-ready” claims on POCs.
- Invest AI / InvestSim: FastAPI/read path must not grow decision logic; workers own decisions; paper engines stay paper-only and say so in copy.
- Anti-AI writing for user-facing and README notes (no leverage/seamless/robust…).

## Acceptance checks
- [ ] Behavior matches Goal
- [ ] Typecheck / lint / existing tests that cover the path
- [ ] i18n: new copy in en + zh + ko (or document if locale not wired yet)
- [ ] Docs: ADR / STRATEGY-TODO / README version notes if user-visible, operational, or architectural (mini / minor / big)
- [ ] Legal/disclaimer: paper-only / not advice where relevant
- [ ] No drive-by refactors outside In scope

## How to work
1. Follow skill `enterprise-coding-behavior` (Think / Simplicity / Surgical / Goal-driven / Architecture Consistency / Production Mindset).
2. Mark existing todos in_progress → completed; do not recreate todos.
3. Inspect neighboring code before writing; reuse helpers.
4. Prefer smallest diff that ships the Goal.
5. Verify with the repo’s usual command (e.g. `npm run lint`, targeted smoke).
6. When done, summarize: what changed, how to verify, README/version status.

## Change detail
[paste plan excerpt, bug report, or acceptance table here]
```

## Short variant

When the change is tiny (copy, config, one-line fix):

```text
In [repo], make this change only: [one sentence].

Do not refactor nearby code. Update en/zh/ko if UI copy. Skip README unless user-visible. Run lint. Summarize in 3 bullets.
```

## After the change

1. Run `prompts/code-review.md` on the diff.
2. Run `prompts/pr-description.md` if opening a PR.
3. Before push: confirm README/version notes per workspace push checklist.
