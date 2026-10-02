# Examples — XingAI UX PNG

## Example A: Guardrails poster — evaluate, fix, then draw

**User:** Attaches Alok Sharan 10-step guardrails poster + “draw UX png”.

**Evaluate (excerpt):**

| Right | Wrong | Missing |
|---|---|---|
| Input/output checks exist | Tool logos = architecture | MCP two-wall, durable runtime |
| Human approval before send | Security only at “Deploy” (step 10) | Untrusted RAG/tool returns |
| Monitor + eval matter | One-shot RAG as enough | Evidence stop / Decision Ledger |

**Fix (before draw):**

- Error: deploy-last = secure → Correction: auth/audit from use-case risk (Decide)  
- Error: tools row = LangGraph/CrewAI → Correction: MCP Resource Server + scope + policy wall  
- Error: guard user prompt only → Correction: all observations untrusted  

**Add:** Decide / Gate / Run; walls bar; determinism footer; Course 02–06/10  

**Draw:** GenerateImage from post-fix map only (no `reference_image_paths`).

**Don’t:** Green-paint the same 10 cards in the same order.

## Example B: Draw only

**User:** “PNG of MCP two-wall from Course 04.”

**Do:** Evaluate concept against Course 04 / claims-mcp-oauth-poc → fix any fuzzy “auth = API key” framing → draw.  
**Don’t:** Copy a LinkedIn OAuth poster.

## Example C: Product chrome

**Do:** Real public-repo screenshot.  
**Don’t:** GenerateImage a marketing clone.
