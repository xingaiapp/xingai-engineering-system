---
name: xingai-docs-pack
description: >-
  Creates any missing XingAI ADRs, tech blog posts, enterprise design articles,
  and AI-Learning Wiki pages for the current product/change, then commits and
  pushes to git. Use when the user asks for missing docs, a docs pack, ADR +
  blog + design + wiki sync, documentation catch-up, or /xingai-docs-pack.
---

# XingAI Docs Pack — Missing ADR / Blog / Design / Wiki + Push

**Quick invoke:** `/xingai-docs-pack` or “create missing ADRs, tech blogs, enterprise design docs, wiki docs, and push.”

Fill documentation gaps for a XingAI product or architecture change across four surfaces, then **commit and push** each touched repo.

## Goal

For the **current subject** (cwd product, named repo, or latest meaningful change):

1. Detect what docs already exist
2. Create only **missing, warranted** docs (do not spam empty stubs)
3. Keep **EN + 中文** where the target repo requires it
4. Cross-link the pack
5. **Commit + push** every repo that changed

## Repo map (workspace)

Default root: `/path/to/ai-projects-work-space`

| Surface | Repo | Path pattern |
|--------|------|----------------|
| **ADR** | Product / engine repo (cwd) | `docs/adr/NNN-slug.md` + `NNN-slug.zh.md` |
| **Tech blog** | `xingai-tech-blog` | `posts/YYYY-MM-DD-slug.md` + `.zh.md`; update `README.md` Posts table |
| **Enterprise design** | `xingai-enterprise-ai-design` | `articles/YYYY-MM-DD-slug.md` + `.zh.md` |
| **Wiki** | `xingai-ai-learning-wiki` | `raw/` snapshot (if needed) + `wiki/**/*.md` + `*.zh.md` |

Also keep a workspace copy at `.cursor/skills/xingai-docs-pack/` for the monorepo.

## When to apply

- User asks for missing ADRs / blogs / design docs / wiki pages
- After a meaningful architecture or product ship (ledger, curriculum, MCP gate, cache boundary…)
- `/xingai-docs-pack`

**Not for:** tiny copy tweaks, private secrets, dumping private-repo internals into the **public** wiki.

## Hard rules

1. **Evidence first** — docs must match real code, ADRs, or public sources. No invented architecture.
2. **Anti-AI writing** — follow workspace `anti-ai-writing-style` (no leverage/delve/seamless/robust…).
3. **Bilingual** — ADR (product convention), tech blog, enterprise articles, and wiki pages ship **EN + 中文** in the same pass when the repo convention requires it.
4. **Wiki public-only** — read `xingai-ai-learning-wiki/AGENTS.md`. No private ADR/PRD dumps into the public wiki. Prefer absolute `https://github.com/xingaiapp/...` links. Use epistemic blocks: Known / Missing / Rethink / Debate / Needs evidence.
5. **Legal** — public posts/articles: no credentials; include or link disclaimer where appropriate; enterprise design is educational, not legal advice.
6. **POC ↔ design** — if a POC exists, ensure Related Design Docs links EN + 中文 (or `TODO: add Chinese design doc`).
7. **README/version before push** — product repos: bump/note if user-visible or architectural; tech-blog/design/wiki: update indexes (Posts table / article index / wiki index) as required.
8. **Push is part of this skill** — after creating docs, commit and push each changed repo unless the user says “don’t push.” Never force-push; never commit secrets.

## Workflow

Copy and track:

```text
Docs pack:
- [ ] 0. Subject + gap scan
- [ ] 1. ADR(s) in product repo
- [ ] 2. Tech blog EN+ZH + README row
- [ ] 3. Enterprise design EN+ZH (if pattern is reusable / teaching-worthy)
- [ ] 4. Wiki EN+ZH (if public-learning value; else skip with reason)
- [ ] 5. Cross-links
- [ ] 6. Commit + push each repo
- [ ] 7. Report URLs / paths
```

### 0 — Subject + gap scan

```bash
git -C <product-repo> rev-parse --show-toplevel
git -C <product-repo> remote get-url origin
ls <product-repo>/docs/adr 2>/dev/null
rg -n "<product-slug|decision|topic>" xingai-tech-blog/posts xingai-enterprise-ai-design/articles xingai-ai-learning-wiki/wiki --glob '*.md' | head -40
```

Decide **create / skip** per surface:

| Surface | Create when | Skip when |
|---------|-------------|-----------|
| ADR | New boundary, schema, auth, cache, ledger, curriculum contract | Pure UI copy; already has matching ADR |
| Tech blog | Ship teaches a reusable XingAI pattern | Duplicate of existing post; no real change |
| Enterprise design | Pattern belongs in courses/articles for outsiders | Product-only internals with no teaching angle |
| Wiki | Public synthesis value; public sources available | Would require private dumps; thin paraphrase only |

Emit a short gap table before writing.

### 1 — ADR (product repo)

- Next number: max existing `NNN` + 1 (zero-pad 3).
- Files: `docs/adr/NNN-slug.md` + `docs/adr/NNN-slug.zh.md`
- Link both from product `README.md` when architectural.
- Template: [references/templates.md](references/templates.md#adr)

### 2 — Tech blog

- Filename: `posts/YYYY-MM-DD-slug.md` + `.zh.md` (today’s date unless user specifies).
- Human voice; concrete code/paths; link the ADR and GitHub repo.
- Add top row to `xingai-tech-blog/README.md` Posts table.
- Read `docs/PUBLIC-SECURITY.md` / bilingual convention if present.
- Template: [references/templates.md](references/templates.md#tech-blog)

### 3 — Enterprise design article

- Filename: `articles/YYYY-MM-DD-slug.md` + `.zh.md`
- YAML frontmatter: `title`, `author`, `date`, `tags`, `description`
- Teaching angle: why the pattern matters for enterprise AI, not a changelog.
- Link runnable POC / product repo when public.
- Template: [references/templates.md](references/templates.md#enterprise-design)

### 4 — Wiki

- Read `xingai-ai-learning-wiki/AGENTS.md` first.
- Prefer `wiki/syntheses/` or `wiki/concepts/` for cross-cutting patterns.
- Always EN + `*.zh.md` with Known / Missing / Rethink / Debate / Needs evidence.
- If ingesting a new public source, snapshot under `raw/` first (or invoke `xingai-wiki-ingest` / `xingai-ai-learning-wiki` for bulk sync).
- Update `wiki/index.md` / `wiki/index.zh.md` when adding a page.
- Template: [references/templates.md](references/templates.md#wiki)

### 5 — Cross-links

Minimum:

- ADR ↔ blog ↔ design article (absolute GitHub URLs when crossing repos)
- Product README → new ADR
- Design article → public product/POC if any
- Wiki → public ADR/blog/design URLs only

### 6 — Commit + push

For **each** changed repo, separately:

```bash
git status -sb
git diff --stat
git log -3 --oneline
# stage only doc files (and README indexes)
git add …
git commit -m "$(cat <<'EOF'
docs: <what and why>

EOF
)"
git push origin HEAD
git status -sb
```

Commit style:

- ADR-only: `docs: add ADR-NNN <slug>`
- Blog: `docs: add post <slug>`
- Design: `docs: add article <slug>`
- Wiki: `docs: add wiki page <slug>`
- Multi-file same repo: one commit summarizing the pack for that repo

Do **not** amend unless user rules for amend are fully met.

### 7 — Final report

Return:

- Gap table (created / skipped + why)
- Paths + commit SHAs + remote URLs
- Anything still missing on purpose

## Companion skills

| Need | Skill |
|------|--------|
| Wiki bulk public-repo sync | `xingai-ai-learning-wiki` |
| Ad-hoc URL/image ingest | `xingai-wiki-ingest` |
| New product baseline | `project-init` |
| Deploy after docs | `project-ship` |

## Common mistakes

- Writing a blog that only restates the README
- EN-only ship when the repo is bilingual
- Putting private product ADRs into the public wiki
- Creating an enterprise article for a one-off UI tweak
- Forgetting the tech-blog README Posts row
- Committing `.env` or secrets
- Pushing only one repo when four changed
