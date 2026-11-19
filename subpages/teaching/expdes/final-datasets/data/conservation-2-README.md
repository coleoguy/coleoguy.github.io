# Use of artificial roost boxes

Data file: `conservation-2.csv`

Each row is one newly installed box in a different woodland patch. Box material was randomly assigned, and the same observation effort was used for all boxes.

Simulated data; 186 observations. No real people, specimens, or institutions are represented.

## Variables

- `roost_used`: Whether bats used the box at least once during monitoring (1 = yes, 0 = no). Binary response. 0 = criterion not met; 1 = criterion met.
- `tree_diameter_cm`: Trunk diameter of the mounting tree (cm). Continuous predictor.
- `mount_height_m`: Box mounting height (m). Continuous predictor.
- `box_material`: Assigned external box material. Categorical predictor. Levels: `cedar`, `wood_composite`.
- `canopy_open_pct`: Canopy openness above the box location, measured before placement (percent). Continuous predictor.
