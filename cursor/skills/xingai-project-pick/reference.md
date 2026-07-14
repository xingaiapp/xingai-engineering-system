# Project Pick — reference

## Repo paths

| Asset | Path |
|-------|------|
| CLI | `xingai-opportunity-radar/agents/project_pick.py` |
| Portfolio | `xingai-opportunity-radar/config/portfolio.yaml` |
| Agent README | `xingai-opportunity-radar/agents/README.md` |
| ADR-005 | `xingai-opportunity-radar/docs/adr/005-project-pick-agent.md` |
| Newsletter parser (shared) | `xingai-opportunity-radar/workers/newsletter_worker.py` |
| Issues | `xingai-opportunity-radar/issues/*.md` + `*.zh.md` |
| Sample cards | `xingai-opportunity-radar/agents/out/latest.en.md` · `latest.zh.md` |

Editorial vs product handoff: ADR-001 in the same `docs/adr/` folder. Runnable Radar product lives in `xingai-founder`, not the editorial repo.

## Portfolio snapshot (keep YAML authoritative)

**Live / demo consumer products:** Meal Coach, Cook, Wear, Travel, Invest, SAT/Learn, Research, Growth Monitor, Lab, T Today, Founder Radar product. Parent in development; Routine planned.

**Infra (not consumer apps):** Opportunity Radar editorial, Robinhood MCP, Agent Firewall, Engineering System.

**Prefer upgrade when:**

- Trust / audit / approval → Agent Firewall or Robinhood MCP
- Inference cost / markets → Invest AI surface
- Research → artifacts → Research AI or Founder

**Do not build:** chat shells; Invest decisions on FastAPI request path; payment/medical-first MVP without legal; SEO aggregator Radar; Founder product duplicated inside editorial repo.

## CLI notes

```bash
cd xingai-opportunity-radar
.venv/bin/pip install pyyaml httpx   # once
.venv/bin/python agents/project_pick.py --issue issues/YYYY-MM-DD-slug.md
# optional: OPENAI_API_KEY — else heuristic engine
# --force-llm  fails if no key / API error
# --dry-run    print only
```

Heuristic and LLM must still produce **one** PICK + rejected list.
