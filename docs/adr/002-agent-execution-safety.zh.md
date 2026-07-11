# ADR-002：Agent 执行安全 —— XingAI 第六条全局原则

**日期：** 2026-07-05
**状态：** 已接受
**作者：** Xing @ XingAI
**取代：** —
**被取代：** —
**英文版：** [English](002-agent-execution-safety.md)

## 背景

XingAI 五条全局原则（worker 架构、i18n、主题、SEO、AEO）管的是产品*怎么建*。没有一条管*产品内的 Agent* 可以执行什么。三件事让这个空白不可再留：

1. Mozilla 0din 展示了干净外观的仓库可以 prompt 注入 Claude Code 执行恶意命令——注入通过 Agent 本该读取的内容进来，模型层护栏关不上。
2. Microsoft《To Copilot and Beyond》研究发现开发者要的是**有边界的委托**（bounded delegation）：Agent 在明确授权范围内做组装工作，而不是开放式自治。
3. XingAI 已经独立重复发明了三次执行门禁——Invest AI ADR-028（G1–G7 交易门禁）、Polymarket AI ADR-003（live CLOB 执行门禁）、Agent Firewall ADR-001..005（策略引擎、按轮次溯源、pin + YAML 建议）。三个领域，一套共享标准。

## 决策

**Agent 执行安全成为第六条全局原则。** 任何 Agent（或 MCP 工具）能产生外部效果的 XingAI 产品——执行命令、下单、沙箱外写入、发送消息、花钱——必须应用 [agent-execution-gate 模式](../../patterns/agent-execution-gate.md)：

1. **默认最小权限** —— 先上只读工具；写/执行工具必须显式开启且永不默认打开（`*_ENABLED=true` 永远是 opt-in）。
2. **确定性门禁，LLM 只做参谋** —— allow/deny 由攻击者可控内容改写不了的规则产生。LLM 可以*建议*（提高审查等级），永远不能*授权*。
3. **声明授权范围** —— 每个 Agent 界面写清：不经请示可做什么、需要审批做什么、永远不可做什么（bounded-delegation 契约）。
4. **全链路 fail-closed** —— 门禁不可达 → 阻断；人不可达 → 阻断（超时即拒绝）。
5. **每个裁决入台账** —— 每次受门禁动作写一行 Decision，共享 schema（`patterns/decision-ledger-schema.md`），包括人工推翻。
6. **诚实的威胁模型** —— 每份实现写清能挡什么、不能挡什么（例如防火墙挡的是被诱导的 Agent，不是恶意本机用户）。

参考实现：`xingai-agent-firewall`（通用工具调用）、Invest AI ADR-028（领域专用交易门禁）。新产品的采用方式是写一个简短 ADR，把六条要求映射到自己的执行面上——与 Decision Ledger 相同的采用机制。

## 后果

正面：
- 第四个需要门禁的产品抄标准而不是重新发明；评审可以引用本 ADR 直接拒绝未加门禁的写工具。
- Bounded-delegation 契约（第 3 条）变成可书写的文档——这正是企业买家索要的东西。

代价：
- 任何长出执行面的产品都要多写一个 ADR + 接门禁——刻意的摩擦，只施加在错误不可逆的地方。
- 六条要求是地板不是天花板；领域专用门禁（Invest 的 G1–G7）仍是产品自己的责任。

## 相关

- [patterns/agent-execution-gate.md](../../patterns/agent-execution-gate.md)
- [patterns/decision-ledger-schema.md](../../patterns/decision-ledger-schema.md)
- xingai-agent-firewall ADR-001..005（拦截、打分、审批、溯源、拒绝并加规则）；xingai-invest-ai ADR-028；xingai-polymarket-ai ADR-002/003
- 技术博客：[按轮次污染](https://github.com/xingaiapp/xingai-tech-blog/blob/main/posts/2026-07-11-agent-firewall-origin-provenance-adr-004.zh.md)、[拒绝并加规则](https://github.com/xingaiapp/xingai-tech-blog/blob/main/posts/2026-07-11-agent-firewall-deny-add-rule-adr-005.zh.md)
