---
name: xingai-daily-stock-intelligence
description: >-
  Generate a personalized, source-grounded daily U.S. stock-market intelligence
  report for XingAI (market regime, holdings impact, research priority scores,
  email Markdown/HTML/text). Use when the user asks for a daily stock report,
  market intelligence brief, portfolio radar, /xingai-daily-stock-intelligence,
  or XingAI Daily Stock Market Intelligence.
version: 1.0.0
---

# XingAI Daily Stock Market Intelligence Skill

**Quick invoke:** `/xingai-daily-stock-intelligence` or “generate today’s XingAI daily stock intelligence report.”

Also keep a workspace copy at `.cursor/skills/xingai-daily-stock-intelligence/` for the monorepo.

## Purpose

Generate a concise daily stock-market intelligence report that explains:

- what moved the market
- why it moved
- how the user's held securities were affected
- which stocks deserve deeper research
- which catalysts and risks matter next

This is not a buy/sell signal generator.

**Disclaimer:** Educational / informational only. Not investment, tax, or legal advice. No return promises. Human decides all trades.

## When to apply

- User asks for today’s / this week’s stock market intelligence
- Portfolio impact brief for the watchlist below
- Email-ready daily market report (Markdown + HTML + plain text)
- `/xingai-daily-stock-intelligence`

**Not for:** placing orders, auto-rebalancing, fabricating prices/sources, or inventing cost basis / weights.

## Workflow

Copy and track:

```text
Daily stock intelligence:
- [ ] 0. Report date + market holiday check
- [ ] 1. Gather prices / indexes / macro (MCP + public sources)
- [ ] 2. Gather news / SEC / earnings / calendar with URLs + timestamps
- [ ] 3. Classify market regime
- [ ] 4. Portfolio intelligence (no inferred weights)
- [ ] 5. Attention Scores + Top Stocks to Watch
- [ ] 6. Fill all 12 required sections
- [ ] 7. Email pack (subject + MD + HTML + plain text)
- [ ] 8. Quality checklist
```

### 0 — Date and holiday

- Use the user’s local calendar date unless they specify another session date.
- If U.S. markets are closed, say so up front and mark prices as last session / delayed.

### 1 — Market data

Prefer live tools when available:

| Need | Prefer |
|------|--------|
| Equity quotes | Robinhood MCP `get_equity_quotes` / `get_equity_historicals` |
| Indexes | `get_indexes` / `get_index_quotes` |
| Account positions (optional) | `get_equity_positions` / `get_portfolio` — only if user asks to use brokerage data |
| Macro / yields / oil / gold / DXY / BTC | Licensed or reputable public sources; cite URL + timestamp |

If brokerage MCP is unavailable, use public quotes and **label delayed** prices.

### 2 — News and filings

Pull company news, SEC filings, earnings/guidance, and macro calendar for:

- major indexes movers
- holdings list symbols
- AI / semiconductor theme names

Every material claim needs source name, URL, timestamp, confidence.

### 3–8 — Write the report

Follow the rules below. Output templates: [references/output-template.md](references/output-template.md).

## User holdings

Replace this list with the operator's watchlist (or load from a private config file that is **not** committed to this public skill):

```text
EXAMPLE_A, EXAMPLE_B, EXAMPLE_C
```

Do not publish real personal holdings in a public skill fork.

Do not infer:

- exact weights
- allocation
- cost basis
- gains or losses
- rebalancing amounts

unless verified brokerage data is available.

## Required inputs

- Current market prices
- Major index data
- Treasury yields
- Oil, gold, dollar and Bitcoin
- Company news
- SEC filings
- Earnings and guidance
- Macro calendar
- Portfolio-symbol events
- Source URLs
- Data timestamps

## Source priority

1. SEC and government sources
2. Company investor relations
3. Official earnings releases
4. Licensed market-data providers
5. Reuters and other reputable media
6. Yahoo Finance metadata and links
7. Secondary commentary

Never fabricate a source or link.

## Required output sections

1. Executive Summary
2. Market Dashboard
3. What Moved the Market
4. My Portfolio Intelligence
5. Top Stocks to Watch
6. AI and Semiconductor Radar
7. Earnings Intelligence
8. Unusual Movers
9. Avoid Chasing
10. Tomorrow's Catalysts
11. One-Week Outlook
12. Official Sources

## Market regime

Classify the day as:

- Risk-On
- Neutral
- Risk-Off

Explain the classification using:

- index performance
- market breadth
- VIX
- Treasury yields
- dollar
- oil
- sector leadership
- credit or liquidity stress when available

## Portfolio analysis rules

For each relevant holding, provide:

- daily move
- reason
- event type
- whether the move is market-wide, sector-wide or company-specific
- whether fundamentals changed
- risk
- next item to verify

Pay special attention to thematic overlap:

- EXAMPLE semi / AI-infra names (configure privately)
- EXAMPLE leveraged / related tickers (configure privately)
- momentum exposure
- leveraged exposure
- AI infrastructure
- semiconductors
- memory
- quantum
- fintech
- space

Do not calculate weights.

## Attention Score

Score stocks from 0 to 100 using:

- Fundamental Change: 25
- Catalyst Strength: 20
- Earnings Revision: 15
- Price and Volume Confirmation: 15
- Valuation Opportunity: 10
- Theme Strength: 10
- Data Confidence: 5

The score measures research priority, not expected return.

Labels:

- 85–100: Research Now
- 70–84: Watch Closely
- 50–69: Monitor
- Below 50: Low Priority

## Allowed suggested actions

Use only:

- Research
- Watch
- Wait
- Avoid Chasing
- Verify
- Monitor Risk

Do not output direct personalized trade orders.

## Leveraged-product rule

For leveraged or concentrated ETFs:

- clearly label leverage risk
- mention path dependency and volatility decay where relevant
- do not evaluate them like ordinary long-term equities
- warn when the underlying moved sharply
- never recommend averaging down automatically

Known leverage / concentrated names on the monitor list (flag explicitly when discussed): TSLL, PLTU, HODU, and any other 2x/3x or single-stock leveraged product that appears in news.

## Evidence rules

Every material factual statement must include:

- source name
- URL
- publication or data timestamp
- confidence

Clearly distinguish:

- Fact
- Interpretation
- AI inference
- Uncertainty

## Email output

Generate:

- Markdown
- Responsive HTML
- Plain-text fallback
- Subject line

Subject pattern:

XingAI Daily Stock Market Intelligence | YYYY-MM-DD | [Main Market Theme]

See [references/output-template.md](references/output-template.md) for section and HTML scaffolding.

## Quality checklist

Before completing:

- Verify all timestamps
- Check ticker symbols
- Check market holiday status
- Confirm sources support claims
- Remove duplicated news
- Mark delayed prices
- Check that no exact allocation was inferred
- Check that no email-send success is claimed without provider confirmation

## Common mistakes

- Inventing a URL or “SEC filing” that was not fetched
- Treating Attention Score as a buy score
- Inferring portfolio weights from the ticker list
- Evaluating TSLL / PLTU / other leveraged products like plain equities
- Claiming an email was sent when only the draft was generated
- Mixing Fact and AI inference without labels
