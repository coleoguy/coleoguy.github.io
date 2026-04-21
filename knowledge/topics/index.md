---
layout: default
title: "Topics · Knowledge · Blackmon Lab"
description: "Topic pages in the Blackmon Lab wiki — state-of-understanding synthesized from findings across papers, with contradictions between studies surfaced explicitly."
permalink: /knowledge/topics/
canonical: "https://coleoguy.github.io/knowledge/topics/"
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

<ul>
{% for page in topic_pages %}
  <li>
    <a href="{{ page.url }}"><strong>{{ page.title | default: page.name }}</strong></a>
    {% if page.papers_supporting and page.papers_supporting.size > 0 %}
      <br><span class="meta">{{ page.papers_supporting.size }} supporting paper{% if page.papers_supporting.size != 1 %}s{% endif %}{% if page.last_updated %} · updated {{ page.last_updated | date: "%b %-d, %Y" }}{% endif %}</span>
    {% endif %}
  </li>
{% endfor %}
{% if topic_pages.size == 0 %}
  <li><em>No topic pages yet.</em></li>
{% endif %}
</ul>

<p class="meta">
  ← <a href="/knowledge/">Back to Knowledge</a>
</p>
