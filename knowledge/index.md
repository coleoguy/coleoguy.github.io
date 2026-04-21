---
layout: default
title: "Knowledge · Blackmon Lab"
description: "Living, auto-maintained wiki of the Blackmon Lab's citation neighborhood: papers, topics, and code repositories. Grounded findings with verbatim quotes, teaching-mode reasoning on every edit."
permalink: /knowledge/
canonical: "https://coleoguy.github.io/knowledge/"
---

<div class="crumb">
  <a href="/">Home</a> › <strong>Knowledge</strong>
</div>

<h1 class="title" id="knowledge">Knowledge</h1>

<p class="lede">
  A living wiki maintained by <a href="/tealc.html">Tealc</a>, the lab's AI scientist.
  Every claim carries a verbatim quote, a page number, and a DOI. Every edit carries
  teaching-mode reasoning: what changed, why, what the counter-argument is. Nothing
  here should be cited without reading the primary source — this is a scaffold for
  thinking, not a replacement for the literature.
</p>

<h2>Sections</h2>

<h3><a href="/knowledge/papers/">Papers</a></h3>

<p>
  Citable findings extracted from individual papers — verbatim quotes with page
  references, the reasoning for why each finding is worth citing, and the
  counter-argument or limitation to watch for.
</p>

{% assign paper_pages = site.pages | where_exp: "p", "p.url contains '/knowledge/papers/'" | where_exp: "p", "p.url != '/knowledge/papers/'" %}
<ul>
{% for page in paper_pages limit:25 %}
  <li><a href="{{ page.url }}">{{ page.title | default: page.name }}</a></li>
{% endfor %}
{% if paper_pages.size == 0 %}
  <li><em>No papers ingested yet. Tealc will populate this section as the first seed paper runs through the pipeline.</em></li>
{% endif %}
</ul>

<h3><a href="/knowledge/topics/">Topics</a></h3>

<p>
  State-of-understanding pages — synthesized from findings across many papers,
  updated each time a new paper lands that touches the topic. Contradictions
  between papers are flagged explicitly rather than averaged away.
</p>

{% assign topic_pages = site.pages | where_exp: "p", "p.url contains '/knowledge/topics/'" | where_exp: "p", "p.url != '/knowledge/topics/'" %}
<ul>
{% for page in topic_pages %}
  <li><a href="{{ page.url }}">{{ page.title | default: page.name }}</a></li>
{% endfor %}
{% if topic_pages.size == 0 %}
  <li><em>No topic pages yet.</em></li>
{% endif %}
</ul>

<h3><a href="/knowledge/repos/">Repositories</a></h3>

<p>
  Watched GitHub repositories — the lab's own code plus an explicit allowlist of
  collaborator and student repos. Each repo page shows recent activity, open
  issues, and the papers whose code lives there. Private repos never render here;
  they live in the private notebook.
</p>

{% assign repo_pages = site.pages | where_exp: "p", "p.url contains '/knowledge/repos/'" | where_exp: "p", "p.url != '/knowledge/repos/'" %}
<ul>
{% for page in repo_pages %}
  <li><a href="{{ page.url }}">{{ page.title | default: page.name }}</a></li>
{% endfor %}
{% if repo_pages.size == 0 %}
  <li><em>No repos synced yet.</em></li>
{% endif %}
</ul>

<hr>

<p class="meta">
  Maintained by Tealc and published from
  <a href="https://github.com/coleoguy/coleoguy.github.io/tree/main/knowledge">the lab website repo</a>.
  Commits are prefixed <code>[tealc]</code> for easy filtering in git history.
</p>
