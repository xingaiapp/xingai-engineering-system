---
name: research-ai-loading-ux
description: >-
  Designs and implements trustworthy loading UX for XingAI AI/search flows.
  Use when a feature waits on AI, search, API polling, background jobs,
  indexing, scraping, report/email/PDF generation, RAG, or long-running agents.
---

# Research AI Loading UX

Use this skill when building or reviewing any XingAI feature where the user waits longer than 2 seconds for AI, search, polling, indexing, scraping, background jobs, or report generation.

Waiting is acceptable when users understand what is happening. Never leave users with only a blank screen, spinner, or static skeleton for long AI/search work.

## Required Pattern

For flows longer than 2 seconds, add a visible status box that appears immediately.

It must include:

- Feedback within 100ms of starting
- Neutral gray container
- Animated dots or subtle activity indicator
- Typing-style human-readable status message
- Step counter
- Progress bar
- Elapsed-time counter
- Completion state
- Smooth result reveal

## Default Steps

Use real backend stages when available. If no real stages exist, use this staged fallback without pretending exact backend progress:

```ts
const statusMessages = [
  "Searching database...",
  "Calling AI engine...",
  "Analyzing results...",
  "Preparing output...",
];
```

Chinese:

```ts
const statusMessages = [
  "正在搜索数据库...",
  "调用 AI 引擎...",
  "分析结果中...",
  "准备输出...",
];
```

## Behavior Rules

When work starts:

- Disable the input and submit button.
- Clear stale results if they could be mistaken for the new result.
- Show the status box immediately.
- Start an elapsed-time timer.
- Start status animation.

During loading:

- Advance by real backend state if available.
- Otherwise advance by calm time-based stages.
- Show progress movement, but avoid fake precision such as `87%` unless the backend reports real progress.
- Do not expose noisy backend internals.

When complete:

- Show a green completion state briefly.
- Hide the loading box or collapse it.
- Reveal result cards with a smooth fade/stagger.
- Re-enable input and button.

When an error happens:

- Stop the timer.
- Show a clear error message.
- Re-enable input and button.
- Provide a retry action.

## Visual Rules

Default style:

- Background: light/neutral gray surface
- Border: subtle gray
- Radius: 12px or 16px
- Text: high contrast
- Progress color: blue
- Completion color: green
- Motion: calm, not flashy
- Must work in dark mode
- Must work on mobile and desktop

Avoid:

- Aggressive flashing
- Spinner-only waits
- Static skeleton for 10-30 seconds
- Overpromising exact completion time
- Too many technical backend details

## React Component Shape

Prefer a reusable component:

```tsx
<TypingStatus
  lang={lang}
  currentStep={currentStep}
  elapsedSeconds={elapsedSeconds}
  progress={progress}
  isComplete={isComplete}
/>
```

Implementation guidance:

- Derive `progress` from the current step when no real progress exists.
- Keep elapsed time honest.
- Localize status messages.
- Respect `prefers-reduced-motion`.
- Keep touch targets at least 44px when retry or cancel controls appear.

## Apply To

- Research AI search
- Invest AI report generation
- Meal AI image analysis
- SAT AI answer review
- RAG workflows
- Long-running AI agents
- Polling-based backend jobs
- Report, email, or PDF generation

## Acceptance Checklist

```markdown
- [ ] Feedback appears within 100ms
- [ ] User can see the current stage
- [ ] Elapsed time is visible
- [ ] Progress moves without fake precision
- [ ] Completion is visible
- [ ] Results reveal smoothly
- [ ] Input/button disabled during active work
- [ ] Error state is clear and includes retry
- [ ] Mobile and desktop work
- [ ] Light and dark mode are readable
```

## Core Insight

The goal is not only to make the system faster. It is to make the wait feel understandable, trustworthy, and controlled.
