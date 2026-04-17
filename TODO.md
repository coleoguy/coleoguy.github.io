# Website TODO

## Pages to build

### Lineage page
A page showing Heath's academic lineage (advisor, grandadvisor, etc.) and the people the lab has trained and where they went. Related to the alumni list on `team.html` but expanded into a proper genealogy-style page. Possible inspiration: the EEB / academic family trees that some labs run.

### "Scientists doing cool work" page
A page highlighting other scientists whose work Heath admires and thinks visitors (especially students) should know about. Not a competitor list, not self-positioning, just a reading list of researchers worth following.

## Open issues
- Many citation links in the visual guides (selection.html, coleoptera-genomics.html, epistasis-line-cross.html, chromosome-evolution-history.html, genome-structure-evolution.html, sex-chromosome-evolution.html) were auto-generated and may point to the wrong paper/book. See the link audit run on 2026-04-16.

## High-priority upgrades

### In-page chat with Gemini free tier (path 2)
The current "Ask the lab" block on `homepage-v2.html` opens NotebookLM in a pinned tab with the question on the clipboard (path 1). A visitor never gets an answer inside the site.

**Upgrade:** wire a true in-page chat using Google Gemini 2.0 Flash (free tier: 15 req/min, 1500 req/day, 1M input tokens), using the same Google account that owns the NotebookLM. Context seed: `llms-full.txt`. API key cannot live in the HTML, so this needs a tiny serverless proxy:
- **Cloudflare Worker** (free tier, recommended): holds the API key, accepts POST /ask with a question, forwards to Gemini, streams the response back.
- Alternative: Vercel serverless function (also free tier).
- HPRC self-hosting is **not** appropriate for public web traffic.

Swap the chat UI from "copy + open NotebookLM" to streaming answers into the chat window. Keep the "open in NotebookLM" link as a fallback for deep dives. Estimated effort: 30 minutes on a laptop evening. $0/month at expected traffic.

