# Website TODO

## Pages to build

### "Scientists doing cool work" page
A page highlighting other scientists whose work Heath admires and thinks visitors (especially students) should know about. Not a competitor list, not self-positioning, just a reading list of researchers worth following.

## Open issues
- Citation links in visual guides audited 2026-04-17 — all DOIs verified contextually correct.
- Legacy Bootstrap theme still used by `reading.group/index.html` and `rseminar/*` (3 pages). Decide: migrate to v3 layout or mark as archive. These are the only pages keeping `assets/css/main.css` and `assets/vendor/` alive.
- `data/publications.json` received three manual 2026 additions on 2026-08-14 (JEB voag025, GCE ygcen.2026.114929, bioRxiv 718287). Next ORCID sync should pick these up and can drop the `manual_additions` note.
- `assets/data/scholar-metrics.json` last updated 2026-03-05; Scholar blocks automated fetch, needs a manual refresh of citations/h-index.

## Done
- In-page chat is live (Cloudflare worker deployed, `WORKER_URL` set in `assets/js/v3.js`). Removed the stale wiring instructions that used to live here.
- Full people/news/pubs update 2026-08-14 (Copeland and Barboza graduated; McConnell to Tennessee; Laird to UBC; Anderson PVAMU summer wrap-up; Burnett joined).
