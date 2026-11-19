# Foraging signs around acorn trays

Data file: `wildlife-3.csv`

Each row is one tray at a separate woodlot. Trays were given a randomly assigned shade screen, and cameras scored use over the same interval without identifying individual squirrels.

Simulated data; 142 observations. No real people, specimens, or institutions are represented.

## Variables

- `squirrel_fed`: Whether a squirrel fed at the tray during monitoring (1 = yes, 0 = no). Binary response. 0 = criterion not met; 1 = criterion met.
- `air_temp_c`: Mean air temperature during morning sampling (degrees C). Continuous predictor.
- `nearby_oak_basal_area_m2_ha`: Oak basal area near the tray (square m per hectare). Continuous predictor.
- `shade_screen`: Assigned screen above the tray. Categorical predictor. Levels: `none`, `mesh`.
- `distance_to_cover_m`: Distance from the tray to the nearest upright woody cover (m). Continuous predictor.
