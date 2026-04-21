---
layout: default
title: "Topics · Knowledge · Blackmon Lab"
description: "Topic pages in the Blackmon Lab wiki — state-of-understanding synthesized from findings across papers, with contradictions between studies surfaced explicitly."
permalink: /knowledge/topics/
canonical: "https://coleoguy.github.io/knowledge/topics/"
extra_head: |
  <style>
    .wiki-cat details { border: 1px solid var(--rule); border-radius: 5px; margin: 6px 0; }
    .wiki-cat summary {
      padding: 9px 14px;
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
    .wiki-cat .cat-count {
      font-weight: 400;
      color: var(--ink-faint);
      font-size: 12px;
    }
    .wiki-cat ul {
      margin: 0;
      padding: 4px 14px 10px 32px;
      list-style: disc;
    }
    .wiki-cat li { padding: 3px 0; font-size: 14px; }
    .wiki-cat li .meta { font-size: 12px; color: var(--ink-faint); margin-left: 6px; }
  </style>
---

<div class="crumb">
  <a href="/">Home</a> › <a href="/knowledge/">Knowledge</a> › <strong>Topics</strong>
</div>

<h1 class="title" id="topics">Topics</h1>

<p class="lede">
  Topic pages synthesize findings across many papers into the lab's current
  understanding of a research question. Each page is updated whenever a new
  paper with findings tagged to that topic is ingested. Contradictions between
  papers are flagged explicitly, not averaged away.
</p>

{% assign topic_pages = site.pages | where_exp: "p", "p.url contains '/knowledge/topics/'" | where_exp: "p", "p.url != '/knowledge/topics/'" | sort: "title" %}
{% assign grouped = topic_pages | group_by: "category" | sort: "name" %}

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

<p class="meta" style="margin-top:18px;">
  ← <a href="/knowledge/">Back to Knowledge</a>
</p>
