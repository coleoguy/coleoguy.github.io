---
layout: default
title: "Repositories · Knowledge · Blackmon Lab"
description: "Watched GitHub repositories in the Blackmon Lab wiki — code associated with lab papers, plus an explicit allowlist of collaborator and student repos."
permalink: /knowledge/repos/
canonical: "https://coleoguy.github.io/knowledge/repos/"
---

<div class="crumb">
  <a href="/">Home</a> › <a href="/knowledge/">Knowledge</a> › <strong>Repositories</strong>
</div>

<h1 class="title" id="repos">Repositories</h1>

<p class="lede">
  Watched GitHub repositories — the lab's own code plus an explicit allowlist
  of collaborator and student repos. Each repo page shows README summary,
  recent commit activity, open issues flagged for attention, and cross-links
  to the papers whose analyses live in that code. Private repos never render
  here; they live in the private notebook layer.
</p>

{% assign repo_pages = site.pages | where_exp: "p", "p.url contains '/knowledge/repos/'" | where_exp: "p", "p.url != '/knowledge/repos/'" | sort: "name" %}

<ul>
{% for page in repo_pages %}
  <li>
    <a href="{{ page.url }}"><strong>{{ page.title | default: page.name }}</strong></a>
    {% if page.repo %}<br><span class="meta"><a href="https://{{ page.repo }}">{{ page.repo }}</a>{% if page.language %} — {{ page.language }}{% endif %}</span>{% endif %}
    {% if page.papers_using and page.papers_using.size > 0 %}<br><span class="meta">Backs {{ page.papers_using.size }} paper{% if page.papers_using.size != 1 %}s{% endif %}</span>{% endif %}
  </li>
{% endfor %}
{% if repo_pages.size == 0 %}
  <li><em>No repositories synced yet.</em></li>
{% endif %}
</ul>

<p class="meta">
  ← <a href="/knowledge/">Back to Knowledge</a>
</p>
