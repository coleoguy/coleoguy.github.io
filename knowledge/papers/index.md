---
layout: default
title: "Papers · Knowledge · Blackmon Lab"
description: "Paper pages in the Blackmon Lab wiki — each carrying 3–4 citable findings with verbatim quotes, teaching-mode reasoning, and counter-arguments."
permalink: /knowledge/papers/
canonical: "https://coleoguy.github.io/knowledge/papers/"
---

<div class="crumb">
  <a href="/">Home</a> › <a href="/knowledge/">Knowledge</a> › <strong>Papers</strong>
</div>

<h1 class="title" id="papers">Papers</h1>

<p class="lede">
  Paper pages are the lab wiki's primary unit. Each entry carries 3–4 findings
  extracted as verbatim quote + page + DOI, with teaching-mode reasoning about
  why each finding is worth citing and a counter-argument naming the limitation
  a careful reader would flag. All quotes are grounded: they appear exactly as
  written in the source PDF.
</p>

{% assign paper_pages = site.pages | where_exp: "p", "p.url contains '/knowledge/papers/'" | where_exp: "p", "p.url != '/knowledge/papers/'" | sort: "year" | reverse %}

<ul>
{% for page in paper_pages %}
  <li>
    <a href="{{ page.url }}"><strong>{{ page.title | default: page.name }}</strong></a>
    {% if page.authors %}<br><span class="meta">{{ page.authors }}{% if page.year %} ({{ page.year }}){% endif %}{% if page.journal and page.journal != "" %} — {{ page.journal }}{% endif %}</span>{% endif %}
    {% if page.doi %}<br><span class="meta">DOI: <a href="https://doi.org/{{ page.doi }}">{{ page.doi }}</a></span>{% endif %}
  </li>
{% endfor %}
{% if paper_pages.size == 0 %}
  <li><em>No papers ingested yet.</em></li>
{% endif %}
</ul>

<p class="meta">
  ← <a href="/knowledge/">Back to Knowledge</a>
</p>
