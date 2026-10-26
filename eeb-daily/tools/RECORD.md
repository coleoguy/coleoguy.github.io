# EEB Daily issue record

One canonical JSON file per issue in `eeb-daily/data/`, named `NNNN-YYYY-MM-DD.json` (zero-padded issue number, then the issue date). The cloud editor submits new records to `eeb-daily/inbox/YYYY-MM-DD.json`; the publisher validates and accepts them before `tools/build.py` regenerates the site. Strings marked *html* may contain inline `<em>`, `<sub>`, `<sup>`, `<a href>`; nothing else. No em dashes anywhere.

```json
{
  "no": 9,
  "date": "2026-10-24",
  "weekday": "Saturday",
  "lead": {
    "topic": "Chromosome number and karyotype evolution",
    "headline": "html: short declarative headline, not the paper title",
    "deck": "html: one sentence",
    "authors": "Surname AB, Surname CD, ... Surname XY",
    "journal": "Evolution",
    "pubdate": "22 Oct 2026",
    "doi": "10.xxxx/xxxxx",
    "url": "https://doi.org/10.xxxx/xxxxx",
    "paragraphs": ["html: paragraph 1", "html: paragraph 2"],
    "push": "html: the Where to push box, 45-60 words"
  },
  "people": [
    {"role": "First author", "name": "Full Name", "bio": "html: about 50 words", "links": [{"label": "Lab page", "url": "https://..."}]},
    {"role": "Last author", "name": "Full Name", "bio": "html: about 50 words", "links": []}
  ],
  "slot2": {
    "kind": "BEYOND or CLASSIC",
    "headline": "html",
    "cite": "html: Authors, <em>Journal</em>, year, with the link as <a href>",
    "body": "html: 85-110 words",
    "url": "https://... primary source"
  },
  "slot3": {
    "kind": "SCIENCE, HISTORY, or ACADEMIA",
    "headline": "html",
    "cite": "html: one-line source citation with the link as <a href>",
    "body": "html: 85-110 words (HISTORY 100-130)",
    "why": "html: ACADEMIA only, 30-45 words; omit the key otherwise",
    "history_subject": "HISTORY only: the person or story, used to prevent repeats; omit otherwise",
    "url": "https://... primary source"
  },
  "tomorrow": "Classic and Beyond biology",
  "producer": "ChatGPT",
  "source_audit": [
    {"url": "https://...", "title": "Actual source title", "used_for": "lead", "evidence": "Brief facts checked in the source; disclose abstract-only access when applicable."},
    {"url": "https://...", "title": "First author's institutional page", "used_for": "person_1", "evidence": "Verified public position and affiliation."},
    {"url": "https://...", "title": "Last author's institutional page", "used_for": "person_2", "evidence": "Verified public position and affiliation."},
    {"url": "https://...", "title": "Second paper", "used_for": "slot2", "evidence": "Verified citation and supporting result."},
    {"url": "https://...", "title": "Story's primary source", "used_for": "slot3", "evidence": "Verified story and its date."}
  ]
}
```

Kickers are derived from `kind` (BEYOND: Beyond EEB; CLASSIC: Classic; SCIENCE: Beyond biology; HISTORY: History; ACADEMIA: The wider campus). Legacy kinds FIELDNOTES, FARAFIELD and PAPER exist only in issues 1 through 8.

Dedup queries (run from the repo root):

```sh
jq -r '[.no, .date, .lead.topic, .lead.doi] | @tsv' eeb-daily/data/*.json          # topics of recent issues, featured DOIs
jq -r '.slot2.url, .slot3.url, .lead.url' eeb-daily/data/*.json | sort -u          # every URL already used
jq -r '.slot3.history_subject // empty' eeb-daily/data/*.json                       # history subjects already covered
jq -r '.slot2.kind + " " + .slot2.headline' eeb-daily/data/*.json | grep CLASSIC    # classics already covered
```
