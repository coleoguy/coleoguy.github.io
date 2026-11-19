# Menu item nutrient-density labeling

Data file: `nutrition-2.csv`

Each row is one distinct hypothetical menu item in a simulated audit. Cuisine category and quantitative measures were recorded, not assigned.

Simulated data; 165 observations. No real people, specimens, or institutions are represented.

## Variables

- `posted_quality_badge`: Whether the item displayed the program's hypothetical quality badge (1 = yes, 0 = no). Binary response. 0 = criterion not met; 1 = criterion met.
- `serving_temp_c`: Plated food temperature in degrees Celsius. Continuous predictor.
- `menu_category`: Section of the menu where the item was listed. Categorical predictor. Levels: `bowl`, `sandwich`, `plate`.
- `vegetable_mass_g`: Grams of non-starchy vegetables per serving. Continuous predictor.
- `plate_diameter_cm`: Serving plate diameter in centimeters. Continuous predictor.
