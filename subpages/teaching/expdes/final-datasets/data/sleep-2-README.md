# Sleep onset in a study of evening light

Data file: `sleep-2.csv`

Each record is a different simulated volunteer who completed one laboratory night. The evening display mode was randomly assigned. The prior week was summarized by diary.

Simulated data; 153 observations. No real people, specimens, or institutions are represented.

## Variables

- `asleep_within_20_min`: Whether sleep onset occurred within 20 minutes of lights out. Binary response. 0 = criterion not met; 1 = criterion met.
- `display_mode`: Assigned display mode during the evening session. Categorical predictor. Levels: `warm`, `cool`.
- `sensor_cable_cm`: Measured length of the attached recording cable, in cm. Continuous predictor.
- `room_humidity_pct`: Relative humidity at lights out, in percentage points. Continuous predictor.
- `prior_sleep_h`: Mean nightly sleep time reported in the diary for the previous week, in hours. Continuous predictor.
