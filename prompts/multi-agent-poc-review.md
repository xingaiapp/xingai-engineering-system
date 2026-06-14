# Multi-Agent POC Review Prompt

Use this prompt after building or before demoing a XingAI multi-agent POC.

```text
Review this multi-agent POC as an XingAI Enterprise architecture reviewer.

Context: The POC should validate the XingAI Enterprise Agent Platform (Phase 1 · MVP Validation Layer), not merely showcase a chatbot.

Evaluate:

1. Orchestration
   - Is there a real Orchestrator that plans handoffs and aggregates output?
   - Are specialist agents distinct (role, goal, output schema)?

2. Collaboration flow
   - Research → Product → Tech → Critic (or equivalent) — is the pipeline visible?
   - Does each agent receive prior agent output as input?

3. Tools
   - Do agents use tools (even simulated MCP) rather than only raw LLM?
   - Is tool attribution visible in trace?

4. Trace & governance
   - request_id, agent_name, input, output, tool_used, duration, timestamp?
   - Is trace persisted (SQLite or equivalent)?
   - Does UI show timeline without exposing hidden chain-of-thought?

5. Observability
   - Metrics or counters for demos?
   - Agent registry showing Phase 1 active vs Phase 2+ planned?

6. Enterprise positioning
   - README/docs state: POC = MVP Validation Layer for future platform?
   - Clear "Not Production Yet" boundary?

7. Reusable assets
   - What should move to xingai-engineering-system (skill, pattern, template)?
   - What should stay project-specific?

Return:

## Verdict
- Ready for team demo / Needs work / Over-scoped for V1

## Checklist
| Item | Pass / Fail | Notes |

## Gaps vs Enterprise Platform
| Phase 1 (POC) | Phase 2+ | Status |

## Demo script improvements
3–5 bullet points for a 5-minute leadership demo

## Reusable Asset Candidates
Use the standard Reusable Asset Candidate format if anything new should be promoted.
```
