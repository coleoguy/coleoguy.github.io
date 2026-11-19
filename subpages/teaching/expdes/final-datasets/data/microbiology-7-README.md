# Sparkling cider bubble observations

Data file: `microbiology-7.csv`

Each row is an unopened bottle from a distinct commercial batch of nonalcoholic sparkling apple cider. Label style was observed, and no production or growth steps were manipulated.

Simulated data; 132 observations. No real people, specimens, or institutions are represented.

## Variables

- `foam_ring`: Whether a visible foam ring remained after a standardized pour observation (1 yes, 0 no). Binary response. 0 = criterion not met; 1 = criterion met.
- `label_sugar_g`: Labelled sugar per 100 mL (g). Continuous predictor.
- `product_style`: Producer-labelled style. Categorical predictor. Levels: `clear`, `cloudy`.
- `co2_g_l`: Measured dissolved carbon dioxide (g/L). Continuous predictor.
- `bottle_height_cm`: External bottle height (cm). Continuous predictor.
