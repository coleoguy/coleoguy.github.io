# Flower form and pollen placement

Data file: `evolution-4.csv`

Each row represents a different plant and its first recorded visit by a different bee. Floral form was observed rather than assigned.

Simulated data; 153 observations. No real people, specimens, or institutions are represented.

## Variables

- `pollen_deposited`: Whether pollen was detected on the stigma after the visit (1 = yes, 0 = no). Binary response. 0 = criterion not met; 1 = criterion met.
- `nectar_depth_mm`: Distance from flower opening to nectar surface (mm). Continuous predictor.
- `floral_form`: Observed floral opening shape. Categorical predictor. Levels: `bell`, `tube`.
- `plant_height_cm`: Height of the flowering stem (cm). Continuous predictor.
- `visit_start_hour`: Local decimal hour at which visit began (e.g., 10.5 = 10:30). Continuous predictor.
