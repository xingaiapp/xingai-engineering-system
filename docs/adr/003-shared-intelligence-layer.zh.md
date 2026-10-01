# ADR-003：Shared Intelligence Layer — 全站共享 Evidence Runtime

**日期：** 2026-10-01  
**状态：** Accepted  
**作者：** Xing @ XingAI  
**取代：** —  
**被取代：** —  
**Also available:** [English](003-shared-intelligence-layer.md)

## 背景

XingAI 各产品反复自建同一条脊梁：

```text
Internet → Evidence → Verification → Decision → Execution → Outcome → Learning
```

现有能力分散在不同仓库（见英文版对照表）：Evidence Engine、Founder Source Registry / EvidenceClaim、Invest ADR-055、Decision Ledger、Agent Firewall、纸面交易与执行证据等。

若不立平台规则，下一个产品会再造一套 Evidence Store、Claim Graph、Verification、Agent Logs、Audit、Replay、Outcome Tracking——既浪费，也堵死跨站「决策历史 / 智能层」界面。

同时必须守住已有边界：Decision Ledger **禁止中央共享库**（Decision Engine ADR-016）；Learn AI ADR-001 明确共享的是**模式**，不是共享 Runtime 依赖。本 ADR 要命名共享层，但不能推翻这些边界。

## 决策

**Shared Intelligence Layer = 平台契约 + 选择性引擎；不是新巨型服务，也不是共享生产库。**

凡把互联网/输入变成推荐或带门禁动作的 XingAI 站点，必须把流水线映射到下列阶段词汇，并**复用**下表共享组件，而不是平行再造一套。

### 阶段模型（强制词汇）

```text
Internet
   ↓
Evidence          — 带 source 的可持久化事实/引用
   ↓
Verification      — 支持 / 反证 / 不可达 / 人工复核
   ↓
Decision          — 推荐或门禁 allow/deny（Ledger 形态）
   ↓
Execution         — 外部副作用仅在 fail-closed 门禁之后
   ↓
Outcome           — followed / ignored / modified / 可度量结果
   ↓
Learning          — 回写评分、提示、门禁或 research pack
```

产品可跳过不需要的阶段（例如 Meal 的 Evidence 可以很薄），但不得另起一条同职责的平行脊梁。

### 共享组件（禁止按产品重复建设）

| 组件 | 共享什么 | 产品本地保留什么 |
|------|----------|------------------|
| **Evidence Store** | 形态 + worker 写缓存；claim/引用校验优先用 `xingai-evidence-engine` | 引用 evidence id 的业务表 |
| **Source Registry** | id / URL / 信任档 / 抓取策略模式 | 各域真实源列表 |
| **Claim Graph** | Claim → evidence → verdict 边 | 域实体（标的、餐、城市） |
| **Verification** | 判定词表 + verify 由 worker 拥有 | 人工 overlay / 复核 UI |
| **Agent Logs** | run id、agent、model、时间、状态 | 域 payload |
| **Tool Calls** | 工具名、参数哈希、结果状态、门禁裁决 | 域适配器 |
| **Permissions** | 最小权限 + 写工具显式开启（ADR-002） | 角色矩阵 |
| **Audit Trail** | 只追加的 Decision / 门禁 / 复核行 | 保留策略 |
| **Replay** | 用已存 evidence + 输入重放（审计不依赖现场重抓） | 域模拟器 |
| **Outcome Tracking** | Ledger 的 `action_taken` / `outcome` | 产品指标 |

### 归属（扩展，不另起炉灶）

1. **契约与模式** → 本仓（`shared-intelligence-layer`、decision ledger、execution gate、worker-cache、human-overlay）。
2. **Claim / 引用 Evidence Runtime** → `xingai-evidence-engine`。新产品用短 ADR 采用/消费，不另建第三套 verify。
3. **跨产品决策与结果** → Decision Ledger；各产品本地写；统一 UI 读各产品 API（ADR-016）。
4. **执行权限 / 工具审计** → ADR-002 + Agent Firewall（或满足同一六条的域门禁）。
5. **研究扇出** → Opportunity Radar ADR-008 叠在 Verification/Decision **之上**，不替代 Evidence Runtime。

### 明确非目标（30–90 天）

- 不为了发版去建 `xingai-shared-intelligence` 生产服务。
- 不为所有 `*.xingai.app` 建单一共享库。
- 不强迫 Meal/Cook/Travel 走完整 Evidence Engine（风险面只需薄源 + Ledger 即可）。
- 不在 Invest / Research / Founder / Radar 内再复制一套 claim-verify 管线。

### 采用规则

产品第一次需要某共享组件时：

1. 引用本 ADR + 归属 pattern/引擎。
2. 写短产品 ADR：覆盖哪些阶段、复用哪套引擎/schema、何为产品本地。
3. 优先升级归属引擎/schema，而不是新仓库。

## 后果

正面：评审可直接拒「我们自己造了 evidence store / audit / claim graph」。跨站历史与学习靠共享形态可行，部署仍解耦。Evidence Engine、Decision Ledger、Agent Firewall 成为同一脊梁的分层，而不是三个无关项目。

代价：产品需标明阶段覆盖；薄产品也要写清跳过了哪些阶段。契约纪律慢于复制 schema——这是故意的。Replay + Learning 在 Outcome 填满之前会不齐。

## 相关

- [patterns/shared-intelligence-layer.md](../../patterns/shared-intelligence-layer.md)
- [ADR-002](./002-agent-execution-safety.md)
- Evidence Engine ADR-001；Invest ADR-055 / 037；Founder ADR-012；Decision Engine ADR-016；Radar ADR-008
