---
layout: default
title: "Knowledge · Blackmon Lab"
description: "Living, auto-maintained wiki of the Blackmon Lab's citation neighborhood: topics, papers, and code repositories. Grounded findings with verbatim quotes, teaching-mode reasoning on every edit."
permalink: /knowledge/
canonical: "https://coleoguy.github.io/knowledge/"
extra_head: |
  <style>
    /* ── compact paper list ── */
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

    /* ── nested topic category accordions ── */
    .wiki-cat details {
      border: 1px solid var(--rule);
      border-radius: 5px;
      margin: 5px 0;
    }
    .wiki-cat summary {
      padding: 8px 14px;
      cursor: pointer;
      font-family: var(--font-mono);
      font-size: 13px;
      font-weight: 600;
      letter-spacing: 0.02em;
      list-style: none;
      display: flex;
      align-items: center;
      gap: 8px;
      user-select: none;
    }
    .wiki-cat summary::-webkit-details-marker { display: none; }
    .wiki-cat summary::before {
      content: "▶";
      font-size: 9px;
      color: var(--ink-faint);
      transition: transform 0.15s;
      flex-shrink: 0;
    }
    .wiki-cat details[open] summary::before { transform: rotate(90deg); }
    .wiki-cat .cat-count { font-weight: 400; color: var(--ink-faint); font-size: 12px; }
    .wiki-cat ul { margin: 0; padding: 4px 14px 10px 32px; list-style: disc; }
    .wiki-cat li { padding: 3px 0; font-size: 14px; }
    .wiki-cat li .meta { font-size: 12px; color: var(--ink-faint); margin-left: 6px; }

    /* ── repo list ── */
    .wiki-repo-list { list-style: none; padding: 0; margin: 0; }
    .wiki-repo-list li { padding: 5px 0; border-bottom: 1px solid var(--rule); font-size: 14px; }
    .wiki-repo-list li:last-child { border-bottom: none; }
    .wiki-repo-list .rmeta { font-family: var(--font-mono); font-size: 11px; color: var(--ink-faint); margin-left: 6px; }
  </style>
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

{% assign paper_pages = site.pages | where_exp: "p", "p.url contains '/knowledge/papers/'" | where_exp: "p", "p.url != '/knowledge/papers/'" | sort: "year" | reverse %}
{% assign topic_pages = site.pages | where_exp: "p", "p.url contains '/knowledge/topics/'" | where_exp: "p", "p.url != '/knowledge/topics/'" | sort: "title" %}
{% assign repo_pages  = site.pages | where_exp: "p", "p.url contains '/knowledge/repos/'"  | where_exp: "p", "p.url != '/knowledge/repos/'"  | sort: "title" %}
{% assign grouped = topic_pages | group_by: "category" | sort: "name" %}

<!-- ── Topics ── -->
<details class="layer">
  <summary>
    <span class="layer-summary-text">
      <span class="sum-kicker">Topics</span>
      <span class="sum-head">State-of-understanding pages synthesized across many papers</span>
      <span class="sum-trail">Updated each time a new paper with findings tagged to that topic is ingested. Contradictions between papers are flagged explicitly. {{ topic_pages | size }} topics across {{ grouped | size }} areas.</span>
    </span>
  </summary>
  <div class="layer-body">
    {% if topic_pages.size == 0 %}
      <p><em>No topic pages yet.</em></p>
    {% else %}
      <div class="wiki-cat">
      {% for group in grouped %}
        {% if group.name != "" %}
        <details>
          <summary>{{ group.name }}<span class="cat-count">&nbsp;({{ group.items | size }})</span></summary>
          <ul>
          {% assign sorted_items = group.items | sort: "title" %}
          {% for page in sorted_items %}
            <li>
              <a href="{{ page.url }}">{{ page.title | default: page.name }}</a>{% if page.papers_supporting and page.papers_supporting.size > 0 %}<span class="meta">{{ page.papers_supporting.size }} paper{% if page.papers_supporting.size != 1 %}s{% endif %}</span>{% endif %}
            </li>
          {% endfor %}
          </ul>
        </details>
        {% endif %}
      {% endfor %}
      </div>
    {% endif %}
  </div>
</details>

<!-- ── Papers ── -->
<details class="layer">
  <summary>
    <span class="layer-summary-text">
      <span class="sum-kicker">Papers</span>
      <span class="sum-head">Citable findings extracted from individual papers</span>
      <span class="sum-trail">Verbatim quotes with page references, the reasoning for why each finding matters, and the counter-argument or limitation to watch for. {{ paper_pages | size }} papers ingested.</span>
    </span>
  </summary>
  <div class="layer-body">
    {% if paper_pages.size == 0 %}
      <p><em>No papers ingested yet. Tealc will populate this section as papers run through the pipeline.</em></p>
    {% else %}
      <ul class="wiki-papers-list">
      {% for page in paper_pages %}
        <li>
          <a href="{{ page.url }}">{{ page.title | default: page.name }}</a><span class="pmeta">{% if page.authors %}{{ page.authors | split: "," | first | strip }}{% if page.authors contains "," %} et al.{% endif %}{% if page.year %} · {{ page.year }}{% endif %}{% endif %}{% if page.journal and page.journal != "" %} · {{ page.journal }}{% endif %}</span>
        </li>
      {% endfor %}
      </ul>
    {% endif %}
  </div>
</details>

<!-- ── Repositories ── -->
<details class="layer">
  <summary>
    <span class="layer-summary-text">
      <span class="sum-kicker">Repositories</span>
      <span class="sum-head">Watched GitHub repositories — lab code and key collaborator repos</span>
      <span class="sum-trail">Each repo page shows README summary, recent commit activity, and cross-links to the papers whose analyses live in that code. Private repos never render here.</span>
    </span>
  </summary>
  <div class="layer-body">
    {% if repo_pages.size == 0 %}
      <p><em>No repositories synced yet.</em></p>
    {% else %}
      <ul class="wiki-repo-list">
      {% for page in repo_pages %}
        <li>
          <a href="{{ page.url }}">{{ page.title | default: page.name }}</a><span class="rmeta">{% if page.repo %}<a href="https://{{ page.repo }}">{{ page.repo }}</a>{% endif %}{% if page.language %} · {{ page.language }}{% endif %}{% if page.papers_using and page.papers_using.size > 0 %} · {{ page.papers_using.size }} paper{% if page.papers_using.size != 1 %}s{% endif %}{% endif %}</span>
        </li>
      {% endfor %}
      </ul>
    {% endif %}
  </div>
</details>

<hr>

<p class="meta">
  Maintained by Tealc and published from
  <a href="https://github.com/coleoguy/coleoguy.github.io/tree/main/knowledge">the lab website repo</a>.
  Commits are prefixed <code>[tealc]</code> for easy filtering in git history.
</p>
