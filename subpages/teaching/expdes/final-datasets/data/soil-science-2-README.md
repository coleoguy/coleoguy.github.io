# Surface ponding after a storm

Data file: `soil-science-2.csv`

Each row is one simulated field observed after a rain event, with no repeated fields. Surface management category and field conditions were recorded rather than assigned.

Simulated data; 156 observations. No real people, specimens, or institutions are represented.

## Variables

- `ponded_water`: Whether standing water was visible 24 hours after the rain (1 = yes, 0 = no). Binary response. 0 = criterion not met; 1 = criterion met.
- `bulk_density_g_cm3`: Dry soil bulk density in grams per cubic centimeter. Continuous predictor.
- `air_temp_c`: Air temperature at the visit in degrees Celsius. Continuous predictor.
- `surface_management`: Surface cover management observed on the field. Categorical predictor. Levels: `mulched`, `bare`.
- `slope_deg`: Mean field surface slope in degrees. Continuous predictor.
