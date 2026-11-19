# Salt accumulation and emergence in a pot assay

Data file: `toxicology-5.csv`

Each row is one singly planted pot from a simulated salinity-stress assay; potting-medium type was randomly assigned and no plant contributed to two records.

Simulated data; 165 observations. No real people, specimens, or institutions are represented.

## Variables

- `emerged`: Whether the seedling emerged by the end of observation (1 = yes, 0 = no). Binary response. 0 = criterion not met; 1 = criterion met.
- `seed_mass_mg`: Mass of the individual seed before planting in milligrams. Continuous predictor.
- `rim_height_cm`: Height of the pot rim above the tray in centimeters. Continuous predictor.
- `extract_salinity_ppt`: Measured salinity of a root-zone water extract in parts per thousand. Continuous predictor.
- `potting_medium`: Assigned medium category. Categorical predictor. Levels: `peat_free`, `bark_mix`, `coir_mix`.
