# Output templates — XingAI Daily Stock Intelligence

Use these scaffolds when emitting the report. Replace bracketed placeholders. Keep evidence labels (`Fact` / `Interpretation` / `AI inference` / `Uncertainty`).

## Subject line

```text
XingAI Daily Stock Market Intelligence | YYYY-MM-DD | [Main Market Theme]
```

## Markdown body

```markdown
# XingAI Daily Stock Market Intelligence
**Date:** YYYY-MM-DD  
**Session:** [regular / holiday / early close]  
**Regime:** [Risk-On | Neutral | Risk-Off]  
**Data as of:** [timestamps; mark delayed if needed]  
**Disclaimer:** Informational only. Not investment advice. Not a buy/sell signal.

## 1. Executive Summary
- [3–6 bullets: regime, what moved, portfolio impact theme, top research name, key risk]

## 2. Market Dashboard
| Asset | Level / Price | Change | As of | Source |
|------|---------------|--------|-------|--------|
| S&P 500 | | | | |
| Nasdaq | | | | |
| Dow | | | | |
| VIX | | | | |
| 10Y Treasury | | | | |
| DXY | | | | |
| WTI | | | | |
| Gold | | | | |
| Bitcoin | | | | |

## 3. What Moved the Market
### Driver 1 — [title]
- **Fact:** … ([Source](url), timestamp, confidence)
- **Interpretation:** …
- **Uncertainty:** …

## 4. My Portfolio Intelligence
| Ticker | Day move | Event type | Scope (mkt/sector/co) | Fundamentals changed? | Risk | Next verify | Action |
|--------|----------|------------|------------------------|------------------------|------|-------------|--------|
| NVDA | | | | | | | Watch |

### Theme notes
- Semis / memory / AI infra: …
- TSLA complex (incl. leveraged): …
- Other: …

## 5. Top Stocks to Watch
| Ticker | Attention Score | Label | Why (evidence) | Action |
|--------|-----------------|-------|----------------|--------|
| | /100 | Research Now / Watch Closely / Monitor | | Research |

Score breakdown (for each top name): Fundamental / Catalyst / Earnings rev / Px-Vol / Valuation / Theme / Confidence.

## 6. AI and Semiconductor Radar
- …

## 7. Earnings Intelligence
- …

## 8. Unusual Movers
- …

## 9. Avoid Chasing
- …

## 10. Tomorrow's Catalysts
- …

## 11. One-Week Outlook
- **Base:** …
- **Bull:** …
- **Bear:** …
- **What would change the view:** …

## 12. Official Sources
1. [Name](url) — accessed/published [timestamp]
2. …
```

## Plain-text fallback

Flatten the Markdown: same section order, no tables (use `Ticker | move | action` lines), keep URLs in full, keep disclaimer.

## Responsive HTML (minimal)

```html
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>XingAI Daily Stock Market Intelligence | YYYY-MM-DD</title>
  <style>
    body { margin: 0; font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", sans-serif;
           background: #0b1220; color: #e8eef7; line-height: 1.45; }
    .wrap { max-width: 720px; margin: 0 auto; padding: 24px 16px 48px; }
    h1 { font-size: 1.35rem; margin: 0 0 8px; }
    h2 { font-size: 1.05rem; margin: 28px 0 10px; color: #9fd4ff; }
    .meta { color: #9aa7b8; font-size: 0.9rem; }
    .card { background: #121a2b; border: 1px solid #243149; border-radius: 10px;
            padding: 12px 14px; margin: 10px 0; }
    table { width: 100%; border-collapse: collapse; font-size: 0.9rem; }
    th, td { text-align: left; padding: 8px 6px; border-bottom: 1px solid #243149; vertical-align: top; }
    a { color: #7eb6ff; }
    .disclaimer { font-size: 0.85rem; color: #9aa7b8; margin-top: 28px; }
    .tag { display: inline-block; padding: 2px 8px; border-radius: 999px;
           background: #1d3a2a; color: #b6f0c8; font-size: 0.8rem; }
  </style>
</head>
<body>
  <div class="wrap">
    <h1>XingAI Daily Stock Market Intelligence</h1>
    <p class="meta">YYYY-MM-DD · Regime: <span class="tag">[Risk-On|Neutral|Risk-Off]</span></p>
    <!-- sections 1–12 as h2 + cards/tables -->
    <p class="disclaimer">Informational only. Not investment advice. Not a buy/sell signal. Sources linked above.</p>
  </div>
</body>
</html>
```

## Attention Score quick card

```text
Ticker: XXXX
Fundamental Change: /25
Catalyst Strength: /20
Earnings Revision: /15
Price and Volume Confirmation: /15
Valuation Opportunity: /10
Theme Strength: /10
Data Confidence: /5
Total: /100 → [Research Now | Watch Closely | Monitor | Low Priority]
Action: [Research | Watch | Wait | Avoid Chasing | Verify | Monitor Risk]
```
