# Blackmon Lab Website — Context for Future Claude Sessions

**Repo:** `coleoguy.github.io` (GitHub Pages, static HTML — no build step, no framework)
**Live site:** https://coleoguy.github.io
**Owner:** Dr. Heath Blackmon, Associate Professor & Associate Head, Dept. of Biology, Texas A&M University

---

## Site Purpose

The Blackmon Lab website serves three audiences:
1. **Researchers / peer labs** — publications, citation network, software, karyotype databases
2. **Students / prospective members** — team, join page, grad funding opportunities, resources
3. **Public / learners** — interactive PCM guide, simulators, AI program info, glossary

---

## Technology Stack

- **Pure static HTML** — no React, no build pipeline, no server
- **Bootstrap 5** — grid/nav: `assets/vendor/bootstrap/`
- **Bootstrap Icons** — `assets/vendor/bootstrap-icons/`
- **AOS (Animate on Scroll)** — `assets/vendor/aos/`
- **D3.js** — loaded via CDN where needed (citation network, some PCM visuals)
- **Custom CSS** — `assets/css/main.css` (all CSS variables defined here)
- **Custom JS** — `assets/js/main.js` (scroll-top, mobile nav, AOS init), `assets/js/news-feed.js` (homepage news)
- **Google Analytics** — G-4J0HZ3LNQX (present on every page)

---

## Design System

### CSS Variables (defined in `assets/css/main.css`)
```
--accent:          #c9a227  (gold — primary brand color)
--bg:              #0c0c0c  (near-black background)
--bg-card:         rgba(255,255,255,0.03)
--bg-card-hover:   rgba(255,255,255,0.06)
--text:            rgba(248,244,237,0.9)
--text-heading:    #f8f4ed
--text-secondary:  rgba(200,197,190,0.65)
--text-muted:      rgba(200,197,190,0.45)
--border:          rgba(255,255,255,0.07)
--font-heading:    (serif, set in main.css)
--font-mono:       monospace
```

### Common Patterns
- **Page header:** `<section class="page-header">` with `<h1>` and subtitle `<p>`
- **Section:** `<section class="section">` or `<section class="content-section">`
- **Hub cards** (homepage): `<a href="..." class="hub-card">` with Bootstrap icon + span label
- **Topic cards** (PCM index): `<a href="..." class="topic-card">` with card-icon emoji, card-title, card-description, card-footer with difficulty-badge
- **Grant lists:** `.grants-section-heading` + `ul.grant-list` (two-column via CSS `columns: 2`)
- **Resource columns:** `.res-grid` (3-col CSS grid), `.res-col`, `.res-list`, `.res-divider`
- **Nav buttons** (PCM pages): `.nav-button` links at page bottom
- **Accent links:** `style="color: var(--accent)"` inline for contextual links within body text

### Standard Header (all pages)
```html
<header id="header" class="header d-flex align-items-center fixed-top">
  <div class="container-fluid container-xl position-relative d-flex align-items-center justify-content-between">
    <div class="logo-group">
      <a href="[../]index.html" class="logo d-flex align-items-center">
        <h1 class="sitename">Blackmon<span class="accent">Lab</span></h1>
      </a>
    </div>
    <nav id="navmenu" class="navmenu">
      <ul>
        <li><a href="[../]research.html">Research</a></li>
        <li><a href="[../]publications.html">Publications</a></li>
        <li><a href="[../]team.html">Team</a></li>
        <li><a href="[../]resources.html">Resources</a></li>
        <li><a href="[../]ai.html">AI</a></li>
        <li><a href="[../]join.html">Join</a></li>
        <li><a href="[../]gallery.html" class="nav-cta">Lab Life</a></li>
      </ul>
      <i class="mobile-nav-toggle d-sm-none bi bi-list"></i>
    </nav>
  </div>
</header>
```
Pages in subdirectories (`phylo-methods/`, `subpages/`, `karyotypes/`) use `../` prefix on all asset and nav paths.

### Standard Footer
```html
<footer id="footer" class="footer">
  <div class="container">
    <div class="copyright text-center">
      <p>© <span>Copyright</span> <strong class="px-1 sitename">Blackmon Lab</strong> <span>All Rights Reserved</span></p>
    </div>
  </div>
</footer>
```

### Standard Script Block (end of body)
```html
<script src="[../]assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
<script src="[../]assets/vendor/aos/aos.js"></script>
<script src="[../]assets/js/main.js"></script>
```

---

## Complete Page Inventory

### Root-level pages
| File | Description |
|------|-------------|
| `index.html` | Homepage — hub cards linking to major sections, news feed |
| `research.html` | Research overview — 4 main areas with links to related tools/pages |
| `publications.html` | Publication list with OpenAlex citation metrics, Google Scholar / ORCID / Citation Network buttons |
| `team.html` | Lab members — PI, grad students, undergrads |
| `resources.html` | 3-column compact resource list: Software \| Data \| Teaching |
| `join.html` | Prospective student info |
| `news.html` | Lab news feed |
| `gallery.html` | Lab life photos |
| `ai.html` | AI-native biology program overview |
| `biolai-cure.html` | Bio & AI CURE course details |
| `stegg.html` | STEGG conference page |
| `tamu-ai-concentration.html` | AI concentration in Biology degree |
| `chromosome-evolution-history.html` | Intellectual history of chromosome evolution research; newspaper two-column layout with Playfair Display font; includes "What Has This Lab Added?" section |
| `citation-network.html` | D3 force-directed citation network, fetches from OpenAlex by ORCID |
| `sitemap.xml` | XML sitemap — update when adding new pages |
| `llms.txt` | Plain-text site guide for LLMs — update when adding new pages |
| `robots.txt` | Standard crawl rules |

### `phylo-methods/` — Interactive PCM Guide
| File | Description |
|------|-------------|
| `index.html` | PCM guide hub — topic cards for each module |
| `phylogenies.html` | What is a phylogeny; D3 chronogram visualization |
| `continuous.html` | Brownian motion, phylogenetic signal, PGLS |
| `discrete.html` | Mk model, ASR, stochastic character mapping, chromePlus, ML vs Bayesian; links to likelihood-ridges.html |
| `discrete-continuous.html` | Pagel's lambda, PGLS-ANCOVA |
| `bd-simulator.html` | Birth-death tree simulator (Gillespie algorithm); two panels, same rates, different outcomes; gold=alive, grey=extinct, red=extinction event, teal=extant tip |
| `likelihood-ridges.html` | Explains likelihood ridge problem in Mk models; interactive canvas visualization with tip-proportion slider |

### `karyotypes/` — Karyotype Databases
| File | Description |
|------|-------------|
| `index.html` | Hub for karyotype databases |
| `subpages/karyotype-data/coleoptera.html` | 4,960 records |
| `subpages/karyotype-data/diptera.html` | 3,443 records |
| `subpages/karyotype-data/amphibian.html` | 2,124 records |
| `subpages/karyotype-data/mammal.html` | 1,440 records |
| `subpages/karyotype-data/drosophila.html` | 1,247 records |
| `subpages/karyotype-data/polyneoptera.html` | 823 records |

### `subpages/` — Supporting Pages
| File | Description |
|------|-------------|
| `grants.html` | Curated grad funding opportunities; sections: Internal, General, Taxon-Based, Ecology & Evolution, Microbiology, Neuroscience, Aggregators; thank-you to Dr. Ryan Earley (UA) |
| `data-sources.html` | Public data sources: AVONET, PanTHERIA, GBIF, Open Tree, Dryad, Zenodo, etc. |
| `glossary.html` | ~50 research terms across PCM, chromosome evolution, pop-gen, and genomics |
| `popgen-sim.html` | Wright-Fisher simulator |
| `karyotype-agent.html` | Autonomous AI karyotype collector description |
| `evobir.html` | evobiR R package page |
| `phylo101.html` | Phylogenetics intro resource |
| `expdes.html` | Experimental design resource |
| `grad101.html` | Grad school guide |
| `AI-Tools.html` | AI tools for biologists |
| `Prompting.html` | Prompting guide |
| `biol682.html` | BIOL 682: Communication in the Biological Sciences — writing, revision, peer review materials |
| `cures.html` | CUREs info |

---

## Key Intersite Link Network

The following pages are deliberately cross-linked — maintain these when editing:

- `research.html` ↔ `karyotypes/index.html` ↔ `chromosome-evolution-history.html` ↔ `phylo-methods/discrete.html`
- `phylo-methods/discrete.html` ↔ `phylo-methods/likelihood-ridges.html`
- `resources.html` → `subpages/data-sources.html`, `subpages/glossary.html`, `phylo-methods/bd-simulator.html`
- `index.html` hub cards → all major sections including `chromosome-evolution-history.html`
- `publications.html` → `citation-network.html`

---

## Software / R Packages (Blackmon Lab)

| Package | Description |
|---------|-------------|
| `evobiR` | Empirical data analysis, simulation, and teaching in evolutionary biology |
| `chromePlus` | Markov models for chromosome number + binary trait evolution (extends ChromEvol) |
| `SAGA2` | Model-averaged line cross analysis using AICc |
| `DirectRepeateR` | Find/annotate direct repeats in genome assemblies |
| `micRocounter` | 2–6mer repeat identification in genome assemblies |
| `RateScape` | Penalized likelihood for branch-specific rate scalars (in development) |

---

## Active Grants (as of March 2026)

1. **Google.org Impact Challenge: AI for Science** — deadline April 17, 2026 (~$2–3M); AI-Native Biology initiative at TAMU. HIGHEST PRIORITY.
2. **NHGRI PAR-25-228** (RateScape for pathogen drug resistance) — deadline June 5, 2026

---

## Active Manuscripts

- **OpenClaw** — autonomous AI agent as lead investigator on evolutionary biology manuscript
- **Sex-autosome fusion fixation probability** — theory paper
- **RateScape method paper**

---

## PI Contact / Key People

| Person | Role | Email |
|--------|------|-------|
| Heath Blackmon | PI, Assoc. Prof. & Assoc. Head | coleoguy@gmail.com |
| Alex Keene | Department Head (PI's supervisor) | akeene@bio.tamu.edu |
| Bethany Walker | Admin coordinator | bawalker@tamu.edu |
| Sean Chien | Grad student — Dynastes pop gen | schien@tamu.edu |
| Kaya Harper | Grad student — bird mating systems | kayaharper@tamu.edu |
| Andres Barboza Pereira | Grad student — plant traits/SeqDef | andresdbp@tamu.edu |

---

## Recent Work (PCM Site Overhaul, March 2026)

Major additions made across two extended sessions:

- **Citation network** (`citation-network.html`): Fixed edge visibility (opacity 0.55 base, 0.9 hover), fixed Labels button (D3 `labelGroup` / `labelSel` separation bug)
- **Chromosome history page** (`chromosome-evolution-history.html`): New page tracing intellectual history of karyotype evolution; newspaper two-column layout; "What Has This Lab Added?" section covering 4 contribution areas
- **Resources page** (`resources.html`): Redesigned from 5 verbose categories to 3-column compact grid (Software \| Data \| Teaching)
- **Grants page** (`subpages/grants.html`): Added Dr. Earley thank-you; added 10 society grants across two rounds of review
- **BD tree simulator** (`phylo-methods/bd-simulator.html`): Gillespie-algorithm birth-death simulator; two paired canvases; bug fixed (assignY() was never called, causing all NaN coordinates)
- **Likelihood ridges page** (`phylo-methods/likelihood-ridges.html`): Interactive canvas with likelihood surface visualization
- **Public data sources** (`subpages/data-sources.html`): Curated directory of open-access databases
- **Glossary** (`subpages/glossary.html`): ~50 terms across 4 research areas
- **Sitemap + llms.txt**: Updated to include all new pages

---

## Notes for Future Sessions

- **Always update `sitemap.xml` and `llms.txt`** when adding new pages
- **`next-session-tasks.md`** in this folder has a separate list of department communication writing tasks (feature stories for BiolAI CURE, AI concentrations, strategic plan, and a pitch for "The Bonsall Lecture")
- When editing PCM pages, check intersite links are bidirectional
- The `deprecated/` folder contains old pages — do not restore without checking with Heath
- Canvas-based visualizations must call `assignY()` before drawing; use `clientWidth || offsetWidth || fallback` for sizing
- D3 label toggling pattern: separate `labelGroup` (the `<g>` element) from `labelSel` (the text selection); toggle `labelGroup.style('display', ...)` not `labelSel`
- Google Analytics ID: `G-4J0HZ3LNQX` — present on every page
- Heath writes short, direct emails; always match that style in drafts
- Heath is an expert R user — do not over-explain R or statistics
