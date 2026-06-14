# Cache-First Before LLM

Use this pattern when user inputs or AI analyses are **expensive, slow, or repeated** — multimodal inputs, OCR, full analysis pipelines, daily briefs, or similar decision generation.

Validated in: `xingai-learn` (InputCache + AnalysisCache), `xingai-founder` (signal/brief cache), `xingai-enterprise-ai-pocs/pocs/multi-agent-lab/` (research tool cache).

Complements: `patterns/worker-cache-boundary.md` (async worker vs API read path).

## Core Rule

**Always check cache before calling the LLM.** Write cache on miss. Surface cache hits in UI when helpful.

```text
Input
   ↓
Normalize + hash
   ↓
Input cache hit?  → use cached extraction (OCR, parsed text)
   ↓ miss
Extract / preprocess → write input cache
   ↓
Analysis cache hit? → return cached analysis
   ↓ miss
LLM / agent pipeline → write analysis cache
   ↓
Response (+ from_cache flags)
```

## Two-Layer Cache (recommended for multimodal + analysis)

| Layer | Key | Stores | Example |
|---|---|---|---|
| Input cache | hash(bytes or normalized text) | OCR text, extracted fields | Image upload |
| Analysis cache | hash(normalized input) | Full analysis JSON + question_id | Same question twice |

## Hash Rules

- Text: SHA-256 of normalized UTF-8 string
- Images: SHA-256 of raw bytes; combine with text for mixed input hash
- Include namespace prefix in DB keys: `research:`, `analysis:`, etc.

## TTL

Default 168 hours (7 days) for POC/product MVP. Expire on read or lazy delete.

## API / Pipeline Owns

- Cache lookup before LLM
- Cache write after successful generation
- `from_cache`, `ocr_from_cache`, or equivalent flags in response
- Fallback path when OpenAI key missing (do not block demo)

## UI Owns

- Optional badges: "Analysis cache hit", "OCR cache hit"
- Never hide that cached result is being shown when it affects trust

## Why It Works

- Faster repeat demos and repeat user queries
- Lower API cost
- Proves system behavior (not black-box regeneration)
- Required foundation before enterprise memory layers (Phase 2–3)

## Common Mistakes

- Cache only similar questions but not full analysis
- Hash includes unstable metadata (timestamps, request_id)
- Cache miss still calls LLM for OCR when image unchanged
- No TTL → unbounded SQLite growth
