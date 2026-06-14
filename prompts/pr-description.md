# PR Description Prompt

Use this prompt to write a consistent, informative PR description for any XingAI repo.

```text
Write a clear PR description for this change.

Context: XingAI repos follow conventional commits and the XingAI engineering system standards. PRs are reviewed by engineers who did not write the code.

The change: [paste diff summary or describe the change]

Write:

## What Changed
2–4 bullet points. What the code actually does, not why.

## Why
One sentence. The business or product reason. Not "per ticket" — the actual reason.

## How to Test
Step-by-step. Start from: `npm run dev` or the equivalent. Include the exact user action and expected result.

## Checklist
- [ ] Mobile layout verified at ~375px
- [ ] EN / zh / ko strings updated if new UI copy added
- [ ] Light and dark themes verified
- [ ] No internal version labels in UI
- [ ] README version notes updated (if user-visible or operational)
- [ ] No secrets committed

## Type
Pick one: feat / fix / refactor / chore / docs / perf / test

## Breaking Changes
None — or describe what breaks and migration path.

Rules for the output:
- No AI clichés ("seamless", "robust", "leverage")
- No passive voice
- Keep sentences short
- If the change is tiny (copy/config), a short description is fine — do not pad it
```
