# Data

This directory holds the JSON/CSV data the site fetches at runtime. Files here are loaded by `cures-karyotype-database.html`, `tau_database.html`, `news.html`, and the publications widget. Updating these files updates the site without touching any HTML.

## Files

| File | Used by | Records | Refresh |
|------|---------|---------|---------|
| `cures-karyotype-database.csv` | (download from CUREs DB page) | 63,542 | manual |
| `cures-karyotype-data.json` | `cures-karyotype-database.html` | 63,542 | re-export from the master CSV when records are added |
| `tau-database.json` | `tau_database.html` | 1,960 | re-export from `subpages/tau-data/results.csv` when updated |
| `news.json` | `news.html` + homepage feed | (variable) | edit by hand to add/edit lab news cards |
| `publications.json` | `publications.html` | 57 (snapshot) | re-snapshot from ORCID when a new pub appears (script below) |

## Refreshing the publications snapshot

The publications page tries `data/publications.json` first and falls back to a live ORCID API call. The snapshot keeps the page fast and resilient when ORCID is slow or down. To regenerate:

```sh
cd ~/Desktop/GitHub/coleoguy.github.io
python3 << 'EOF'
import json, urllib.request, time
ORCID = "0000-0002-5433-4036"
BASE = f"https://pub.orcid.org/v3.0/{ORCID}"
def fetch(url):
    req = urllib.request.Request(url, headers={'Accept': 'application/json'})
    with urllib.request.urlopen(req, timeout=30) as r: return json.loads(r.read())
data = fetch(f"{BASE}/works")
ALLOWED = {'journal-article', 'book', 'book-chapter', 'preprint'}
works, put_codes = [], []
for g in data.get('group', []):
    s = g.get('work-summary', [{}])[0] or {}
    pc = s.get('put-code')
    title = (s.get('title') or {}).get('title', {}).get('value', '')
    journal = (s.get('journal-title') or {}).get('value', '')
    year = (s.get('publication-date') or {}).get('year', {}).get('value', '')
    typ = s.get('type', '')
    doi = ''; doi_url = ''
    for eid in (s.get('external-ids') or {}).get('external-id', []):
        if eid.get('external-id-type') == 'doi':
            doi = eid.get('external-id-value', '')
            doi_url = (eid.get('external-id-url') or {}).get('value') or f'https://doi.org/{doi}'
            break
    if not title or typ not in ALLOWED: continue
    works.append({'putCode': pc, 'title': title, 'journal': journal, 'year': year,
                  'doi': doi, 'doiUrl': doi_url, 'type': typ, 'authors': ''})
    put_codes.append(pc)
authors = {}
for i in range(0, len(put_codes), 25):
    batch = put_codes[i:i+25]
    b = fetch(f"{BASE}/works/{','.join(str(p) for p in batch)}")
    for entry in b.get('bulk', []):
        w = entry.get('work', {})
        contribs = (w.get('contributors') or {}).get('contributor', [])
        names = [(c.get('credit-name') or {}).get('value') for c in contribs
                 if (c.get('contributor-attributes') or {}).get('contributor-role') == 'author']
        authors[w.get('put-code')] = ', '.join(n for n in names if n)
    time.sleep(0.2)
for w in works:
    if w['putCode'] in authors: w['authors'] = authors[w['putCode']]
with open('data/publications.json', 'w') as f:
    json.dump({'orcid': ORCID, 'fetched_at': time.strftime('%Y-%m-%dT%H:%M:%SZ', time.gmtime()), 'works': works}, f, indent=2, ensure_ascii=False)
print(f"Wrote {len(works)} works to data/publications.json")
EOF
```

## cures-karyotype-database.csv

Chromosome number records collected through Course-based Undergraduate Research Experiences (CUREs) at Texas A&M University. Accompanies the interactive browser at [coleoguy.github.io/cures-karyotype-database.html](https://coleoguy.github.io/cures-karyotype-database.html).

- Rows: 63,542
- Clades: 56
- Columns:
  - `clade` — clade name (e.g. Accipitriformes, Fabaceae)
  - `species` — species binomial
  - `haploid_number` — haploid chromosome number (n)
  - `citation` — source of karyotype data for the clade (one citation per clade)

Citations are clade-level: every species within a clade shares the citation listed in the "Karyotype Source" column of the project tracking sheet. Phylogeny sources and per-clade student leads are available from the lab on request.

### Citation

If you use this dataset, please cite:

Copeland, M., McConnell, M., Barboza, A., Abraham, H.M., Alfieri, J., Arackal, S., Bernard, C.E., Bryant, K., Cast, S., Chien, S., Clark, E., Cruz, C.E., Diaz, A.Y., Deiterman, O., Girish, R., Harper, K., Hjelmen, C.E., Thompson, M.J., Koehl, R., Koneru, T., Laird, K., Lee, Y., Lopez, V.R., Murphy, M., Perez, N., Schmalz, S., Sylvester, T., and Blackmon, H. (2026). Dismantling Chromosomal Stasis Across the Eukaryotic Tree of Life. *bioRxiv* 2026.04.14.718287. https://doi.org/10.64898/2026.04.14.718287

Please also cite the original karyotype sources listed in the `citation` column.

```bibtex
@article{Copeland2026.04.14.718287,
  author    = {Copeland, Megan and McConnell, Meghann and Barboza, Andres and Abraham, Hannah M and Alfieri, James and Arackal, Steven and Bernard, Carrie E and Bryant, Kiedon and Cast, Shelbie and Chien, Sean and Clark, Emily and Cruz, Cassandra E and Diaz, Aileen Y and Deiterman, Olivia and Girish, Riya and Harper, Kaya and Hjelmen, Carl E and Thompson, Michelle J and Koehl, Rachel and Koneru, Tanvi and Laird, Kenzie and Lee, Yoonseo and Lopez, Virginia R and Murphy, Mallory and Perez, Nayeli and Schmalz, Sarah and Sylvester, Terrence and Blackmon, Heath},
  title     = {Dismantling Chromosomal Stasis Across the Eukaryotic Tree of Life},
  year      = {2026},
  doi       = {10.64898/2026.04.14.718287},
  publisher = {Cold Spring Harbor Laboratory},
  journal   = {bioRxiv},
  elocation-id = {2026.04.14.718287},
  url       = {https://www.biorxiv.org/content/early/2026/04/16/2026.04.14.718287}
}
```
