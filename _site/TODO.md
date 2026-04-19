# Website TODO

## Pages to build

### "Scientists doing cool work" page
A page highlighting other scientists whose work Heath admires and thinks visitors (especially students) should know about. Not a competitor list, not self-positioning, just a reading list of researchers worth following.

## Open issues
- Citation links in visual guides audited 2026-04-17 — all DOIs verified contextually correct.

## High-priority upgrades

### Wire up in-page Gemini chat (10 minutes)
`cloudflare-worker.js` is written and ready to deploy. Steps:
1. Deploy `cloudflare-worker.js` to Cloudflare Workers (free tier)
2. Add secret `GEMINI_API_KEY` in Worker settings
3. Paste the Worker URL into `WORKER_URL` constant in `assets/js/v3.js`

The chat widget in `index.html` already falls back to clipboard + NotebookLM until the URL is set.

