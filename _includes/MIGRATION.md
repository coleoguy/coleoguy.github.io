# Jekyll Template Migration Guide

The site now has Jekyll scaffolding so we can stop repeating ~80 lines of `<head>`, `<header>`, and `<footer>` boilerplate in every HTML page. GitHub Pages runs Jekyll automatically — no extra build step needed.

## Files

```
_config.yml              # site-wide settings (title, description, GA ID, exclude list)
_layouts/default.html    # the page skeleton — calls the includes below
_includes/head.html      # everything inside <head>
_includes/header.html    # site nav (highlights active item via page.nav_active)
_includes/footer.html    # footer + scripts (loads news-feed.js? gtag? GLightbox?)
```

## Already converted (proof of concept)

| Page | Before | After | Saved |
|------|--------|-------|-------|
| `news.html` | 109 lines | 26 lines | -83 (76%) |
| `join.html` | 162 lines | 91 lines | -71 (44%) |
| `gallery.html` | 165 lines | 75 lines | -90 (55%) |

Pages without front matter (`---`) at the top are passed through unchanged by Jekyll. So adding new converted pages is incremental and safe.

## How to convert a page

Replace the page's `<!DOCTYPE html>` ... `<head>` ... `<header>` ... `</header>` and trailing `<footer>` ... `</body>` ... `</html>` boilerplate with **YAML front matter** at the top, leaving only the `<main>` body content.

### Front-matter fields

```yaml
---
layout: default                              # always
title: Page Title - Blackmon Lab             # used in <title> and OG
description: One-sentence page summary.      # meta description + OG
canonical: https://coleoguy.github.io/X.html # canonical URL
keywords: comma, separated, keywords         # optional
body_class: research-page                    # optional, sets <body class="">
nav_active: research                         # optional, highlights nav item
                                             #   one of: research / publications / team /
                                             #   resources / ai / join / news / gallery
glightbox: true                              # optional, loads GLightbox JS+CSS (gallery only)
extra_head: |                                # optional, raw HTML inserted at end of <head>
  <script type="application/ld+json"> ... </script>
  <style> /* page-specific CSS */ </style>
extra_scripts: |                             # optional, raw HTML before </body>
  <script src="/assets/js/news-feed.js"></script>
---
```

### Example: minimal page

```yaml
---
layout: default
title: My Page - Blackmon Lab
description: This page does X.
canonical: https://coleoguy.github.io/mypage.html
nav_active: resources
---

<section class="page-header">
  <div class="container">
    <h1>My Page</h1>
  </div>
</section>

<section class="section">
  <div class="container">
    <p>Hello world.</p>
  </div>
</section>
```

## Pages still on the legacy boilerplate (~22 files)

These all repeat the same `<head>` + `<header>` + `<footer>` and would each shrink by 50–100 lines after conversion:

- `index.html`, `research.html`, `publications.html`, `team.html`, `resources.html`, `ai.html`
- `biolai-cure.html`, `stegg.html`, `tamu-ai-concentration.html`
- `sex-chromosome-evolution.html`, `genome-structure-evolution.html`, `selection.html`
- `epistasis-line-cross.html`, `epistasis-database.html`, `chromosome-evolution-history.html`
- `coleoptera-genomics.html`, `cures-karyotype-database.html`
- `phylo-explorer.html`, `citation-network.html`, `tau_database.html`
- `phylo-methods/*.html` (7 files)

Convert one at a time, deploy, verify it looks right. The unconverted pages keep working because Jekyll passes through any HTML file without front matter.

## Local preview (optional)

To test the templated site locally before pushing:

```sh
cd ~/Desktop/GitHub/coleoguy.github.io
gem install --user-install jekyll bundler
jekyll serve
# → http://127.0.0.1:4000
```

## Why the converted pages still work without Jekyll installed

GitHub Pages runs Jekyll on every push automatically — you don't need it locally unless you want to preview before pushing.
