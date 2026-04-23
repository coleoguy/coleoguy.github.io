# Agent Contract — Blackmon Lab Knowledge Wiki

**Version:** 1.0 (Phase 2 foundation)
**Applies to:** `/knowledge/` and adjacent machine-readable files in `coleoguy.github.io`

---

## 1. Purpose

This document is the single source of truth for how any agent — Tealc, a Claude Code session, an external automation, or a human editor — contributes to the `/knowledge/` directory and related wiki infrastructure. Before writing, editing, or proposing changes to any file in this repository's knowledge layer, read and follow every rule here. When rules conflict, later sections take precedence.

The knowledge layer is designed around one principle: every claim about a scientific paper must trace to a verbatim quote extracted by Tealc and locked in the paper page's `Finding N` block. This makes the wiki auditable, correctable, and safe to cite in manuscripts.

---

## 2. Region Grammar

Every knowledge page may contain three types of annotated regions. Markers must appear at the start of a line (possibly after leading whitespace). Mismatched or nested markers of the same name are a validation error caught by `wiki_tools/validate_surface.py`.

### 2a. Tealc-managed regions

Tealc owns these blocks. External agents may propose changes via pull request but must not edit in place.

```markdown
<!-- tealc:auto-start -->
Content automatically written or updated by Tealc.
Do not edit directly — submit a PR with an [agent] prefix instead.
<!-- tealc:auto-end -->
```

```markdown
<!-- tealc:related-start -->
Citation-neighborhood suggestions produced by Tealc.
<!-- tealc:related-end -->
```

Any `tealc:NAME` name is valid, for example `tealc:findings`, `tealc:summary`, etc.

### 2b. Human-owned regions

Tealc byte-preserves these blocks. It will not touch their contents during any automated rewrite.

```markdown
<!-- user-start -->
Notes, commentary, or annotations written directly by Heath or a student.
Tealc will not modify this block.
<!-- user-end -->
```

### 2c. Locked regions

Neither Tealc nor external agents edit these without an explicit `--unlock` flag passed to the pipeline command. Humans may edit with a `[human]` commit.

```markdown
<!-- locked -->
Content that is frozen against all automated modification.
<!-- /locked -->
```

---

## 3. Commit Prefix Convention

Every commit touching a file under `knowledge/` or `AGENT_CONTRACT.md` must start with one of these prefixes:

| Prefix | Who uses it | Effect |
|--------|-------------|--------|
| `[tealc]` | Tealc automated pipeline | Normal automated rebuild |
| `[agent]` | External agent (Claude Code, etc.) | Pauses automated rebuild on touched files until PI reviews |
| `[human]` | Direct human edit | Pauses automated rebuild on touched files until PI reviews |

Any commit that lacks a recognized prefix is treated as `[human]`. Non-`[tealc]` prefixes trigger a review flag in `tealc_activity.json` for the next morning briefing.

---

## 4. Allowlisted Paths

The pipeline may write only to these paths within the repository. Any file outside this list is rejected by `validate_surface.py` with an allowlist error.

```
knowledge/topics/
knowledge/papers/
knowledge/concepts/
knowledge/methods/
knowledge/courses/
knowledge/projects/
knowledge/questions/
knowledge/paths/
knowledge/contradictions/
AGENT_CONTRACT.md
```

Files outside these paths (site HTML, CSS, JavaScript, data files, `_config.yml`, etc.) may only be touched by `[human]` commits.

---

## 5. How to Validate Before Committing

Run the surface validator against the full corpus before every commit that touches a knowledge page:

```bash
cd /path/to/coleoguy.github.io
python -m wiki_tools.validate_surface --all
```

The command exits 0 if all files pass. Exit code 1 means at least one claim or region-grammar check failed. The output names each failing file, line number, and the specific token that caused the failure.

For a single file:

```bash
python -m wiki_tools.validate_surface knowledge/topics/sex_chromosome_evolution.md
```

For machine-readable output (CI pipelines):

```bash
python -m wiki_tools.validate_surface --all --json
```

All checks must pass (exit 0) before a `[tealc]` or `[agent]` commit lands on `master`.

---

## 6. How to Add a Paper

### Via Tealc (preferred)

Tealc exposes three entry points in the `wiki_pipeline` module:

```python
from wiki_pipeline import run_on_doi, run_on_local_pdf, run_on_drive_pdf

# Add by DOI (Tealc fetches the PDF automatically)
run_on_doi("10.1093/sysbio/syu131")

# Add from a local PDF
run_on_local_pdf("/path/to/paper.pdf")

# Add from a file in Google Drive
run_on_drive_pdf("My Drive/00-Lab-Agent/inbox/papers/rabosky2015.pdf")
```

Each command runs the full five-prompt pipeline: finding extraction, finding verification, topic-page update, citation proposal, and repo-note writing.

### Via the inbox (external agents without Tealc access)

Drop a PDF into `~/Drive/00-Lab-Agent/inbox/papers/` and the Sunday scheduled pipeline will pick it up automatically. Do not create a paper page by hand unless you are certain you can faithfully reproduce the finding-extraction and finding-verification steps.

---

## 7. The Accuracy Contract

Every extractive claim on a topic page that cites a finding must satisfy all three rules. `validate_surface.py` enforces rules (b) and (c) automatically; rule (a) is enforced during ingestion by Tealc's finding-verifier prompt.

**(a) Verbatim substring** — The text inside each `Finding N` blockquote on a paper page must be an exact verbatim substring of the paper's PDF text. Tealc's `finding_verifier.md` prompt checks this against the extracted PDF text during ingestion. No paraphrase, no rewording.

**(b) Digit-substring-ok** — Every numeric token in a claim must appear as an exact decimal substring of the finding's quote, OR if the claim contains `~`, `approximately`, or `about`, each numeric may fall within ±10% of a numeric in the quote. Claims that fail this check are blocked at commit time.

**(c) ROUGE-L ≥ 0.35 for synthesis claims** — Claims marked as synthesis (citing ≥ 2 findings and integrating them) must achieve a ROUGE-L F-score ≥ 0.35 against the concatenated quotes. This ensures synthesis claims stay grounded in the source language rather than drifting into unsupported generalization.

Any violation of rule (b) or (c) causes `validate_surface.py` to exit 1, blocking the commit.

---

## 8. Frontmatter Invariants

The following frontmatter fields are set once at ingestion and must never be modified by any agent or automated process afterward:

| Field | Set by | Meaning |
|-------|--------|---------|
| `fingerprint_sha256` | Tealc ingestion | SHA-256 of the PDF used for extraction |
| `doi` | Tealc ingestion | Canonical DOI of the paper |
| `topic_slug` | Tealc ingestion | Slug of the primary topic page |
| `concept_slug` | Tealc ingestion | Slug of the primary concept page |
| `method_slug` | Tealc ingestion | Slug of the primary method page |
| `permalink` | Tealc ingestion | Stable URL for the page |
| `papers_supporting` | Tealc ingestion | DOI list used to construct citations |

If a DOI needs to be corrected, open a `[human]` commit with a brief justification comment in the commit message. Automated correction is not permitted.

---

## 9. Editor-Frozen Pages

A page with `editor_frozen: true` in its YAML frontmatter is excluded from all automated rewrites. `validate_surface.py` skips these pages with a notice and returns exit code 0 for them. Humans may still edit frozen pages directly using a `[human]` commit.

To freeze a page, add the field to its frontmatter:

```yaml
---
editor_frozen: true
---
```

To unfreeze, remove the field in a `[human]` commit.

---

## 10. Reference: Tealc Wiki Prompts and the Accuracy Module

### The five Tealc prompts (in pipeline order)

These prompts live in `~/Drive/00-Lab-Agent/tealc/prompts/` and are executed in sequence by `wiki_pipeline`:

1. **`finding_extractor.md`** — Given a PDF, extract 2–5 findings worth citing. Each finding includes the verbatim quote, a citable paraphrase, and the page number.
2. **`finding_verifier.md`** — For each extracted finding, verify the verbatim quote is a true substring of the PDF text. Blocks ingestion if any quote fails.
3. **`topic_page_writer.md`** — Given the verified findings plus existing topic-page content, update or create the topic page. Respects `<!-- user-start -->` blocks (preserves them byte-for-byte).
4. **`citation_proposer.md`** — Given updated topic content, propose inline citation links in the format `([slug, Finding N](/knowledge/papers/slug/#finding-N))`.
5. **`repo_note_writer.md`** — Writes a one-paragraph entry to `tealc_activity.json` summarizing what changed and why.

### The deterministic accuracy module

**`wiki_tools/accuracy.py`** — Three pure Python functions that implement the rule (b) and (c) checks described in Section 7:

- `digit_substring_ok(claim, quote, allow_tilde=True)` — numeric token substring check with optional tilde zone.
- `region_grammar_ok(markdown)` — validates region marker pairing and nesting.
- `synthesis_rouge_ok(claim, quotes, threshold=0.35)` — ROUGE-L F-score check for synthesis claims.

All three functions are standard-library-only, fully deterministic, and covered by unit tests in `wiki_tools/tests/test_accuracy.py`. Run tests with:

```bash
python -m unittest wiki_tools.tests.test_accuracy
```

---

*This contract is maintained by Heath Blackmon. Proposed changes require a `[human]` commit with a brief justification.*

---

## 11. Click-to-edit overlay

The click-to-edit overlay lets the PI edit `<!-- user-start/end -->` regions directly in the browser during local development, and propose changes to Tealc-managed regions via a lightweight diff-queue flow.

### How to start

Open two terminals in the repo root:

```bash
# Terminal 1 — edit server (localhost only, port 4711)
python3 -m wiki_tools.edit_server

# Terminal 2 — Jekyll dev server (port 4000)
bundle exec jekyll serve
```

### How to activate

Visit any wiki page with `?edit=1` appended:

```
http://localhost:4000/knowledge/topics/sex_chromosome_evolution/?edit=1
```

The overlay activates automatically. It does nothing on the GitHub Pages production site.

### Region semantics

| Region type | Marker | Behaviour |
|---|---|---|
| User-owned | `<!-- user-start --> … <!-- user-end -->` | Directly contenteditable. Changes auto-save (800 ms debounce) via `PATCH /file`. `⌘S` / `Ctrl+S` saves immediately. |
| Tealc-managed | `<!-- tealc:NAME-start --> … <!-- tealc:NAME-end -->` | Read-only in the overlay. Clicking opens an inline textarea + rationale field. Submitting queues a proposal file. |

### Proposal files

Proposals are written to `data/wiki_proposals/<ISO_timestamp>_<slug>.md`. Each file contains YAML frontmatter (`path`, `region`, `proposed_at`, `rationale`) and a fenced block showing the original content alongside the proposed replacement.

Tealc's next `improve_wiki` run scans `data/wiki_proposals/` and ingests any `.md` files it finds, applying or discarding each proposal according to the accuracy contract.

### Security

- The edit server binds `127.0.0.1` exclusively — it is never exposed beyond the local machine.
- The `Host` header is validated on every request; anything not from `localhost` or `127.0.0.1` is rejected.
- CORS is restricted to `http://localhost:4000` and `http://127.0.0.1:4000` only.
- Every write request is validated against the path allowlist in Section 4 before any file I/O occurs.
- All file writes go through an in-process `threading.Lock` to prevent concurrent-tab races.

### V1 limitations

- User regions save their content as plain text (`innerText`). Rich markdown (bold, links, blockquotes) typed directly in the browser will be stored as plain text. Use VS Code for markdown-formatted edits; the overlay is best for prose corrections and short additions.
