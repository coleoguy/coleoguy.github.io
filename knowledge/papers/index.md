---
layout: default
title: "Papers · Knowledge · Blackmon Lab"
description: "Paper pages in the Blackmon Lab wiki — each carrying 3–4 citable findings with verbatim quotes, teaching-mode reasoning, and counter-arguments."
permalink: /knowledge/papers/
canonical: "https://coleoguy.github.io/knowledge/papers/"
extra_head: |
  <style>
    .wiki-papers-list {
      list-style: none;
      padding: 0;
      margin: 0;
    }
    .wiki-papers-list li {
      padding: 5px 0;
      border-bottom: 1px solid var(--rule);
      font-size: 14px;
      line-height: 1.4;
    }
    .wiki-papers-list li:last-child { border-bottom: none; }
    .wiki-papers-list .pmeta {
      font-family: var(--font-mono);
      font-size: 11px;
      color: var(--ink-faint);
      margin-left: 6px;
    }
  </style>
---

<div class="crumb">
  <a href="/">Home</a> › <a href="/knowledge/">Knowledge</a> › <strong>Papers</strong>
</div>

<h1 class="title" id="papers">Papers</h1>

<p class="lede">
  Each entry carries 3–4 findings extracted as verbatim quote + page + DOI,
  with teaching-mode reasoning about why each finding is worth citing and a
  counter-argument naming the limitation a careful reader would flag.
</p>

{% assign paper_pages = site.pages | where_exp: "p", "p.url contains '/knowledge/papers/'" | where_exp: "p", "p.url != '/knowledge/papers/'" | sort: "year" | reverse %}

<ul class="wiki-papers-list">
{% for page in paper_pages %}
  <li>
    <a href="{{ page.url }}">{{ page.title | default: page.name }}</a><span class="pmeta">{% if page.authors %}{{ page.authors | split: "," | first | strip }}{% if page.authors contains "," %} et al.{% endif %}{% if page.year %} · {{ page.year }}{% endif %}{% endif %}{% if page.journal and page.journal != "" %} · {{ page.journal }}{% endif %}</span>
  </li>
{% endfor %}
{% if paper_pages.size == 0 %}
  <li><em>No papers ingested yet.</em></li>
{% endif %}
</ul>

<p class="meta" style="margin-top:16px;">
  ← <a href="/knowledge/">Back to Knowledge</a>
</p>
