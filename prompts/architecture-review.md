# Architecture Review Prompt

Use this prompt to review a XingAI product, POC, or backend workflow for reusable architecture patterns.

```text
Review this project as a XingAI architecture reviewer.

Focus on:

1. System boundaries
   - Which component owns decisions?
   - Which component only reads/transports/renders?

2. Data flow
   - Where is data generated?
   - Where is it cached?
   - Where can stale data appear?

3. User-facing decision flow
   - What is the primary decision the product helps with?
   - Is the main flow visible and simple?

4. Enterprise readiness
   - Auth
   - auditability
   - observability
   - rate limits
   - cost controls
   - legal/disclaimer

5. Reusable patterns
   - What can become a Cursor Rule, Skill, prompt, template, or architecture pattern?
   - What should stay project-specific?

Return:

## Findings

Prioritize risks and bugs first.

## Reusable Patterns

Use the Reusable Asset Candidate format.

## Suggested Next Steps

Keep the steps small and actionable.
```
