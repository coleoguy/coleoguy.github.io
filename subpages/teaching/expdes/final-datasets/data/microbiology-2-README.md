# Visible budding in commercial yeast lots

Data file: `microbiology-2.csv`

A single cell was drawn from each independently sampled retail lot of food-grade yeast. Product format was recorded, and no growth treatment was assigned.

Simulated data; 138 observations. No real people, specimens, or institutions are represented.

## Variables

- `bud_visible`: Whether an attached bud was identifiable in the image (1 yes, 0 no). Binary response. 0 = criterion not met; 1 = criterion met.
- `image_offset_um`: Distance from cell to image center (micrometers). Continuous predictor.
- `cell_area_um2`: Projected area of the focal cell (square micrometers). Continuous predictor.
- `slide_light_pct`: Lamp output during imaging (percent of range). Continuous predictor.
- `product_format`: Label category of food-grade yeast. Categorical predictor. Levels: `instant`, `active_dry`, `fresh`.
