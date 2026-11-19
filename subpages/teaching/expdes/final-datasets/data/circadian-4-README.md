# Stable phase estimates from activity records

Data file: `circadian-4.csv`

Each row is one consenting adult's simulated actigraphy record for the same observation duration. Work schedule was recorded, not assigned. No row represents a real person.

Simulated data; 155 observations. No real people, specimens, or institutions are represented.

## Variables

- `stable_phase`: Whether the record met the prespecified criterion for stable activity timing. Binary response. 0 = criterion not met; 1 = criterion met.
- `recording_delay_min`: Minutes between enrollment and device setup. Continuous predictor.
- `watch_mass_g`: Mass of the recording device, in grams. Continuous predictor.
- `daylight_minutes`: Average minutes outdoors during daytime per day. Continuous predictor.
- `work_schedule`: Self-reported usual schedule category. Categorical predictor. Levels: `fixed_day`, `rotating`, `fixed_evening`.
