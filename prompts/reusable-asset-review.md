# Reusable Asset Review Prompt

Use this prompt when you solve a problem and suspect it may become a reusable XingAI asset.

```text
Review the solution we just discussed. Decide whether it should become a reusable XingAI engineering asset.

Evaluate:

1. Frequency
   - Will this likely happen again?
   - Will it be used at least 3 times in the next 90 days?

2. Reuse scope
   - Can SAT AI, Meal AI, Invest AI, Research AI, Enterprise AI Design, POCs, or future XingAI apps use it?

3. Value
   - Does it save time?
   - Does it reduce bugs?
   - Does it improve quality or consistency?

4. Maintenance cost
   - Will this create extra overhead?
   - Is it too project-specific?

Return:

### Reusable Asset Candidate

**Why it should exist**

**Expected reuse frequency**
- High / Medium / Low

**Potential beneficiaries**

**Recommended format**
- Cursor Rule
- Cursor Skill
- Claude Prompt
- MCP Pattern
- Architecture Pattern
- Project Template

**Recommendation**
- Create Now
- Wait Until Pattern Repeats
- Do Not Create

If recommendation is Create Now, provide:
- complete implementation example
- beginner steps
- why it works
- tradeoffs
- common mistakes
```
