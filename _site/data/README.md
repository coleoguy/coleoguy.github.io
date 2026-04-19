# Data

This directory holds the JSON and CSV data that backs coleoguy.github.io. The site fetches these files at runtime, so updating them updates the site without touching any HTML. The files are also the intended open-data export: everything here is CC BY 4.0 (see `LICENSE`) and the full manifest is in `index.json`.

If you are an agent or a script, start with `index.json`. It lists every file with a description, format, record count, the page it backs, and a primary publication when one exists.

## Files

### Lab state

| File | Used by | Records | Refresh |
|------|---------|---------|---------|
| `team.json` | `team.html` | 20 | edit by hand when members join or leave |
| `alumni.json` | `lineage.html` | 21 | edit by hand when alumni update positions |
| `news.json` | `news.html` + homepage feed | 12 | edit by hand |
| `lab-status.json` | homepage live-activity strip | 4 signals | edit by hand weekly |
| `undergrad-papers.json` | `undergrad-papers.html` | 8 | add as undergrad-led papers publish |
| `prompts.json` | `subpages/Prompting.html` | 7 | pull from github.com/coleoguy/prompting |
| `publications.json` | `publications.html` | 57 (snapshot) | re-snapshot from ORCID (script below) |

### Databases

| File | Used by | Records | Primary publication |
|------|---------|---------|---------------------|
| `cures-karyotype-database.csv` | `cures-karyotype-database.html` | 63,542 | Copeland et al. 2026, bioRxiv |
| `cures-karyotype-data.json` | `cures-karyotype-database.html` | 63,542 | (JSON form of the CSV above) |
| `tau-database.json` | `tau_database.html` | 1,960 | re-export from `subpages/tau-data/results.csv` |
| `epistasis-database.csv` + `epistasis-database.json` | `epistasis-database.html` | 1,606 | Burch et al. 2024, Evolution |
| `epistasis-database-citations.csv` | — | 128 | primary sources for the 1,606 crosses |
| `karyotypes-coleoptera.csv` | `karyotypes/index.html` | 4,959 | Blackmon & Demuth 2015 |
| `karyotypes-diptera.csv` | `karyotypes/index.html` | 3,474 | Morelli, Blackmon & Hjelmen |
| `karyotypes-amphibia.csv` | `karyotypes/index.html` | 2,124 | Perkins et al. 2019 |
| `karyotypes-mammalia.csv` | `karyotypes/index.html` | 1,440 | Blackmon Lab, curated |
| `karyotypes-drosophila.csv` | `karyotypes/index.html` | 1,247 | Morelli, Blackmon & Hjelmen |
| `karyotypes-polyneoptera.csv` | `karyotypes/index.html` | 823 | Sylvester et al. 2020 |
| `karyotypes-coleoptera-citations.csv` | — | 251 | primary sources for beetle records |
| `karyotypes-six-index.json` | — | — | manifest for the six clade CSVs |

### Manifest and licensing

| File | Purpose |
|------|---------|
| `index.json` | Full machine-readable manifest of every file in this directory |
| `LICENSE` | CC BY 4.0 license text and attribution guidance |

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

## epistasis-database.csv

Line-cross datasets from plants and animals analyzed in Burch et al. 2024 with the SAGA2 information-theoretic framework. One row per dataset; see `epistasis-database.json` for the full schema and the 128 source citations in `epistasis-database-citations.csv`.

If you use this dataset, please cite:

Burch, B.D., Alexander, E.P., Fu, Y., and Blackmon, H. (2024). Information theoretic line-cross analysis and the evidence for pervasive epistasis. *Evolution* 78(4): 624-634. https://doi.org/10.1093/evolut/qpae003

## Six karyotype databases

The files `karyotypes-coleoptera.csv`, `karyotypes-diptera.csv`, `karyotypes-amphibia.csv`, `karyotypes-mammalia.csv`, `karyotypes-drosophila.csv`, and `karyotypes-polyneoptera.csv` are the raw CSVs behind the clade cards on [coleoguy.github.io/karyotypes/](https://coleoguy.github.io/karyotypes/index.html). Each CSV has its own column set because the databases were built at different times for different projects; `karyotypes-six-index.json` lists them in one place with columns and primary publication for each. Coleoptera ships with a separate `karyotypes-coleoptera-citations.csv` file of primary sources.

## License

All files in this directory are released under CC BY 4.0. See `LICENSE` for the full terms and a short note on how to attribute.
