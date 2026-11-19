# Aggregate stability across dryland fields

Data file: `soil-science-1.csv`

Each row is a composite sample from a distinct simulated field and one sampling date. Texture and soil measurements were observed, not assigned.

Simulated data; 78 observations. No real people, specimens, or institutions are represented.

## Variables

- `stable_aggregates_pct`: Percent of dry soil mass retained as water-stable aggregates. Continuous response.
- `organic_carbon_pct`: Soil organic carbon as percent of dry sample mass. Continuous predictor.
- `core_length_cm`: Length of the collected core in centimeters. Continuous predictor.
- `sampling_time_hour`: Local collection time in decimal hours on a 24-hour scale. Continuous predictor.
- `texture_class`: Dominant field soil texture. Categorical predictor. Levels: `sandy_loam`, `loam`, `clay_loam`.
