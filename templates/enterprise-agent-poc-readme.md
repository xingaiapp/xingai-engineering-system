# POC: [Name] — XingAI Enterprise Agent Platform

## Phase 1 · MVP Validation Layer

This POC is **not an isolated demo**. It validates the architectural foundation of the **XingAI Enterprise Agent Platform**.

```text
Today:   Multi-Agent POC (Phase 1)
Tomorrow: XingAI Enterprise Agent Platform
```

> 今天的 POC 不是玩具项目，而是 XingAI Enterprise Agent Platform 的最小可运行验证。

See: [Enterprise Agent Platform Architecture](../../docs/ENTERPRISE-AGENT-PLATFORM.md) · [enterprise-mapping.md](enterprise-mapping.md)

---

## What This Proves

The POC demonstrates:

- [ ] Agent orchestration
- [ ] Specialized agent collaboration
- [ ] Tool execution
- [ ] Trace logging
- [ ] Governance (POC-level audit trail)
- [ ] Observability (timeline + metrics)

## Current Agents

| Agent | Status | Role |
|---|---|---|
| Orchestrator Agent | Active | Plan, route, aggregate |
| Research Agent | Active | Insight and evidence |
| Product Agent | Active | Product concept and MVP |
| Tech Agent | Active | Architecture |
| Critic Agent | Active | Risks and mitigation |
| [Future Agent] | Planned Phase 2+ | |

---

## Enterprise Pattern

- Multi-agent orchestration
- Specialist handoffs
- Tool / MCP pattern (simulated in V1)
- Audit-friendly trace timeline

## Not Production Yet

This POC does **not** include:

- Authentication / tenant isolation
- Production MCP gateway
- Event bus / async workers
- Enterprise memory (vector DB)
- Long-term audit retention / compliance certification

---

## Architecture

```text
User → Orchestrator → [Specialist Agents] → Tools → Final Answer + Trace
```

See [`architecture.md`](architecture.md) and [`flow.mmd`](flow.mmd).

## Quick Start

```bash
cd pocs/[name]/backend
python3 -m venv .venv && source .venv/bin/activate
pip install -r requirements.txt
cp .env.example .env
uvicorn main:app --reload --port 8010
```

Open **http://localhost:8010**

## API

| Endpoint | Description |
|---|---|
| `GET /` | Demo workspace |
| `POST /demo/run` | Run pipeline |
| `GET /demo/trace/{request_id}` | Trace timeline |
| `GET /demo/metrics` | Observability |
| `GET /demo/agents` | Agent registry |

## Team Demo Script (5 min)

1. Frame as Phase 1 of Enterprise Agent Platform.
2. Run sample goal.
3. Walk Execution Timeline.
4. Show trace detail (input, output, tool, duration).
5. Close: extend agents and MCP — same architecture.

## Lessons Learned

To be filled after implementation.

## Related Design Docs

- EN: [Design doc title](https://github.com/xingaiapp/xingai-enterprise-ai-design/blob/main/articles/example.md)
- 中文: [中文标题](https://github.com/xingaiapp/xingai-enterprise-ai-design/blob/main/articles/example.zh.md)
