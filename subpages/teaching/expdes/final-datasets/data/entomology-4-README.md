# Solitary bee nesting choices

Data file: `entomology-4.csv`

Each row is one nesting shelter at a distinct plot. Shelters were randomly assigned an entrance finish and scored once at the end of a fixed deployment window.

Simulated data; 201 observations. No real people, specimens, or institutions are represented.

## Variables

- `occupied`: Whether a solitary bee established at least one nest in the shelter (1 = yes, 0 = no). Binary response. 0 = criterion not met; 1 = criterion met.
- `noon_wind_m_s`: Mean midday wind speed at mounting point (m/s). Continuous predictor.
- `entrance_finish`: Assigned entrance finish. Categorical predictor. Levels: `plain`, `matte_pattern`, `gloss_pattern`.
- `flower_cover_pct`: Initial ground cover of flowers near the shelter (percent). Continuous predictor.
- `mount_height_cm`: Mounting height above ground (cm). Continuous predictor.
