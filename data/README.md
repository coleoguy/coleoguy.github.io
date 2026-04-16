# Data

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
