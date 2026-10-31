# Agent Delivery Pipeline

[中文](agent-delivery-pipeline.zh-CN.md)

A reusable pattern for running a small team of specialist agents from idea to production, with one orchestrator and two human gates. Built for Claude Code subagents (`.claude/agents/*.md`) and a slash command; the shape also works with Cursor Task agents.

## Shape

```text
You ──► /ship "<goal>" ──► orchestrator (main session)
                              │ dispatches specialists in parallel per stage
                              ▼
 0 Brief → 1 Research → 2 Evaluate → ★3 Confirm → 4 Build
        → 5 Test → 6 Fix loop → 7 Pre-release review → ★8 Approve release
        → 9 Deploy + verify → 10 Retro
```

Subagents cannot spawn other subagents, so the orchestrator must run as the main session (`claude --agent <orchestrator>` or a slash command that adopts its role).

## Roles

| Role | Does | Edits code |
|---|---|---|
| Orchestrator | splits work, dispatches, merges findings into a P0/P1/P2 list | no |
| Researcher | market / competitor / feasibility; facts vs inference | no |
| UX expert | first-screen, flows, mobile, states, cross-site consistency | no |
| SEO / AEO / GEO | metadata, structured data, sitemap, `llms.txt`, AI-crawler policy | no |
| Security + privacy | headers, secrets, policy-vs-behavior consistency, pre-publish scan | no |
| i18n + a11y | translation completeness, contrast, keyboard, screen readers | no |
| Growth analytics | funnels, channels, experiments | no |
| Domain compliance | e.g. "research context, not advice" checks for finance content | no |
| Feature dev | implements the confirmed spec only | yes |
| Bug lead | reproduce → root cause → minimal fix + regression test | yes |
| Perf lead | measure → fix one bottleneck → re-measure | yes |
| QA lead | runs tests/build, verifies acceptance criteria and regressions | no |
| DevOps | commits and pushes (via a CLI agent), then hands off to verification | git only |
| Ops monitor | live availability, "is production = HEAD", cache freshness | no |

## Stage contracts

Each stage writes one file in a run folder (`pipeline/runs/<date>-<slug>/NN-name.md`); the next stage reads only that file.

| # | Stage | Pass condition |
|---|---|---|
| 0 | Brief | goal, scope, non-goals, success metric on one page |
| 1 | Research | every conclusion has a source; facts and inference separated |
| 2 | Evaluate | value / cost / risk; recommended option and rejected options |
| ★3 | Confirm | spec frozen: scope, acceptance criteria, files, rollback |
| 4 | Build | only spec-scoped files change; changed-file list |
| 5 | Test | tests, types, build pass; each acceptance criterion checked with evidence |
| 6 | Fix loop | failures fixed and retested; **max 3 rounds**, then stop and report |
| 7 | Review | no secrets, no domain-compliance violations, no perf regression |
| ★8 | Approve | release approved |
| 9 | Deploy + verify | pushed; production matches HEAD; key pages healthy; rollback known |
| 10 | Retro | metrics compared with the brief after a week |

## Autonomy model

Routine, well-scoped, reversible changes may pass gates 3 and 8 without a per-change prompt, as long as the report states what was done. These always require an explicit human decision:

- force push or history rewrites
- deleting files, branches, or data
- pushing to a public repository
- secrets, environment variables, deployment or CI configuration
- databases and production data
- decision-engine fields or worker / API boundaries
- other people's uncommitted changes
- spending money or sending content externally

## Guardrails that paid off

- **Read-only audit agents.** Auditors report; only the dev leads edit. Keeps findings honest and diffs small.
- **Verified vs inferred.** Every finding is labelled; unchecked items are listed under "not covered".
- **Stage only your own files.** Never `git add -A` in a shared workspace; abort the chain if an assertion fails.
- **Public-repo gate.** Audit results contain unfixed weaknesses; keep them in a private location and publish only the method.
- **CLI agent trust.** A CLI coding agent needs login and a workspace-trust confirmation done by a human; do not script around either.
- **Timeouts.** Headless CLI agents can stall on broad prompts; scope to one repo and a small task, and set a generous timeout.

## Minimal setup

```text
.claude/
  agents/<orchestrator>.md    # tools: Agent, Read, Grep, Glob, Bash, WebFetch, WebSearch
  agents/<specialist>.md      # one file each; read-only tools for auditors
  commands/ship.md            # adopts the orchestrator role and runs the stages
  PIPELINE.md                 # stage table + autonomy model above
```

Keep site/repo mappings and private repository names in your private workspace copy, not in the shared template.
