# Product PRD: Name

**Status:** Draft | Review | Approved | Shipped

**Date:** YYYY-MM-DD

**Owner:** Name / Role

---

## Summary

What is the product? Who is it for? What decision does it help with?

## User Problem

Describe the user pain in plain language. What happens today without this product?

## Primary User Flow

1. User enters or selects input
2. System builds decision context
3. System returns a structured recommendation
4. User saves, compares, or acts

## Decision Output

Define the result shape:

- verdict
- confidence or score
- reasons
- risks
- next step
- sources or evidence

## Success Metrics

How do we know this shipped successfully?

| Metric | Target | Measurement method |
|---|---|---|
| Example: 7-day retention | ≥ 30% | Analytics |
| Example: Decision accuracy | User ratings ≥ 4/5 | Feedback widget |

## Supported Languages

- `en`
- `zh`
- `ko`

## Phases

### Phase 1 — MVP

- Feature A
- Feature B
- Out of scope for MVP: ...

### Phase 2 — Growth

- Feature C
- Feature D

## Timeline

| Milestone | Target date |
|---|---|
| Phase 1 complete | YYYY-MM-DD |
| Public launch | YYYY-MM-DD |

## Required Product Baseline

- [ ] Mobile-first UI (320–430px)
- [ ] Light/dark theme
- [ ] EN / zh / ko i18n complete
- [ ] Legal pages (Privacy, Terms, Disclaimer)
- [ ] SEO metadata, sitemap.xml, robots.txt, llms.txt
- [ ] README version notes
- [ ] Product registry entry

## Out Of Scope

What are we intentionally not building yet? Why?

## Risks

| Risk | Likelihood | Impact | Mitigation |
|---|---|---|---|
| Product risk | Medium | High | ... |
| Technical risk | Low | Medium | ... |
| Legal/compliance risk | Low | High | ... |
| Cost risk (LLM) | Medium | Medium | Cache-first pattern |

## Launch Checklist

- [ ] Build and lint pass
- [ ] Mobile layout verified at ~375px
- [ ] EN / zh / ko copy reviewed
- [ ] Light and dark themes readable
- [ ] Legal, SEO, AEO complete
- [ ] Deploy docs and README version notes updated
- [ ] Product registered in xingai-dot-app
