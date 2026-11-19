# Leaf litter decay in forest patches

Data file: `ecology-1.csv`

One row represents a litterbag in a different forest patch. Canopy type was observed; all bags contained the same starting litter mixture.

Simulated data; 78 observations. No real people, specimens, or institutions are represented.

## Variables

- `mass_loss_pct`: Initial dry mass lost after 90 days (percent). Continuous response.
- `soil_moisture_pct`: Mean volumetric soil water content near the bag (percent). Continuous predictor.
- `initial_bag_mass_g`: Initial loaded dry mass (g). Continuous predictor.
- `canopy_type`: Dominant tree type above the litterbag. Categorical predictor. Levels: `broadleaf`, `conifer`, `mixed`.
- `slope_deg`: Local ground slope (degrees). Continuous predictor.
