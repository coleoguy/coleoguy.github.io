# Seedling leaf pattern in beans

Data file: `genetics-2.csv`

One common-bean seedling was scored from each independently sampled full-sib family in a teaching collection. The inherited marker was recorded and not assigned.

Simulated data; 144 observations. No real people, specimens, or institutions are represented.

## Variables

- `mottle_present`: Whether the first true leaf showed a visible mottled pattern (1 yes, 0 no). Binary response. 0 = criterion not met; 1 = criterion met.
- `pot_rim_mm`: Internal pot rim diameter (mm). Continuous predictor.
- `cotyledon_width_mm`: Maximum cotyledon width (mm). Continuous predictor.
- `marker_class`: Inherited marker class. Categorical predictor. Levels: `a`, `a_b`, `b`.
- `emergence_h`: Time from sowing to emergence (hours). Continuous predictor.
