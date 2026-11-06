# Dairy Campus Data Dictionary

This directory contains the machine-readable and human-readable data dictionaries for all 19 standardized research datasets provided by the Dairy Campus Research Data Platform (Wageningen University & Research).

## Overview of Datasets

| Dataset Code | Dataset Title | Variables | Primary Granularity | Source Table / System |
|:---|:---|:---|:---|:---|
| [TVL_total](tables/TVL_total.md) | Daily Total Cow Research Summary (TVL_total) | 97 | One row per animal per calendar day | `tvl_totaal_bedrijf / tvl_totaal_bedrijf_proef` |
| [Hokofarm_SAC_concentrates](tables/Hokofarm_SAC_concentrates.md) | Automatic Concentrate Feeder Intake (Hokofarm_SAC_concentrates) | 42 | One row per concentrate feeding station visit | `t_raw_hokofarmvb` |
| [Hokofarm_RIC](tables/Hokofarm_RIC.md) | Roughage Intake Control Individual Visits (Hokofarm_RIC) | 18 | One row per roughage trough feeding visit | `t_raw_hokofarmvr` |
| [TVL_RIC_intake_dm](tables/TVL_RIC_intake_dm.md) | Roughage Daily Intake and Dry Matter (TVL_RIC_intake_dm) | 12 | One row per cow per feed group per calendar day | `TVL_totaal_sub_ric_opn` |
| [Triomatic_RIC_load](tables/Triomatic_RIC_load.md) | Trioliet Feeding Robot Mixer Loading Records (Triomatic_RIC_load) | 46 | One row per ingredient loaded per mixing batch | `t_raw_trioliet (subgroupnr = 0)` |
| [Triomatic_RIC_drop](tables/Triomatic_RIC_drop.md) | Trioliet Feeding Robot Trough Delivery Records (Triomatic_RIC_drop) | 46 | One row per feeding delivery drop event | `t_raw_trioliet (subgroupnr <> 0)` |
| [GEA_gates](tables/GEA_gates.md) | GEA Separation and Smart Gate Passages (GEA_gates) | 5 | One row per smart gate passage event | `T_RAW_Gea_Separatie` |
| [GEA_milkings](tables/GEA_milkings.md) | GEA Milking Robot and Parlor Transactions (GEA_milkings) | 13 | One row per milking event | `T_RAW_Gea_milk` |
| [TMR_Trioliet_cowconnect_mix](tables/TMR_Trioliet_cowconnect_mix.md) | CowConnect Mixer Wagon Rations (TMR_Trioliet_cowconnect_mix) | 12 | One row per ingredient batch per mix event | `t_raw_cowconnect_mix` |
| [Velos_behaviour](tables/Velos_behaviour.md) | Nedap Velos Cow Behaviour Intervals (Velos_behaviour) | 4 | One row per behavior state transition / interval | `T_RAW_velos_behaviour` |
| [Velos_behaviour_day](tables/Velos_behaviour_day.md) | Nedap Velos Daily Cow Behaviour Summary (Velos_behaviour_day) | 7 | One row per cow per calendar day | `T_RAW_velos_behaviour (aggregated daily)` |
| [TMR_Trioliet_cowconnect_drop](tables/TMR_Trioliet_cowconnect_drop.md) | CowConnect Feed Distribution Drops (TMR_Trioliet_cowconnect_drop) | 11 | One row per feed fence discharge drop | `t_raw_cowconnect_drop` |
| [DC_DM_content](tables/DC_DM_content.md) | Laboratory Dry Matter Content Oven Tests (DC_DM_content) | 16 | One row per feed sample test | `VL_totaal_droogstoof` |
| [Greenfeed_summarized_data](tables/Greenfeed_summarized_data.md) | GreenFeed Enteric Emission Summaries (Greenfeed_summarized_data) | 24 | One row per validated GreenFeed visit | `T_RAW_Greenfeed_Summarized_Data` |
| [Greenfeed_feed_aggregrated](tables/Greenfeed_feed_aggregrated.md) | GreenFeed Bait Feed Aggregations (Greenfeed_feed_aggregrated) | 13 | One row per cow per GreenFeed station day | `T_RAW_Greenfeed_Feed_data` |
| [Weatherstation](tables/Weatherstation.md) | Dairy Campus Meteorological Weather Station (Weatherstation) | 18 | Hourly / ten-minute meteorological records | `T_RAW_weerstation` |
| [Missing_data](tables/Missing_data.md) | Data Quality and Missing Data Flags (Missing_data) | 17 | One row per animal per calendar day | `tvl_totaal_missende_data_proef` |
| [Environment_barn_Animal_day](tables/Environment_barn_Animal_day.md) | Barn Environment & Animal Daily Profile (Environment_barn_Animal_day) | 52 | One row per animal per housing location per calendar day | `TVL_Dier_Datum_Stal` |
| [Environment_barn_Animal_experim](tables/Environment_barn_Animal_experim.md) | Experimental Cohort Animal Daily Records (Environment_barn_Animal_experim) | 54 | One row per experimental animal per calendar day | `TVL_Dier_Datum_Proef` |

## Directory Structure

- **`tables/`**: Individual Markdown documentation pages for each table, including variable names, English labels, data types, physical measurement units, calculation formulas, and sensor descriptions.
- **`csv/`**: Clean, UTF-8 encoded machine-readable CSV dictionaries for automated ingestion into R, Python, and data catalog tools.
  - `all_metadata_dictionary.csv`: Master data dictionary containing every variable across all 19 datasets in a unified schema.
- **`datapackage.json`**: Standardized [Frictionless Data Package](https://specs.frictionlessdata.io/data-package/) specification describing each dataset resource and field schema.

## Variable Standards

- **Identifier Fields**:
  - `AnimalServerId` / `dienum`: Central internal integer animal identifier issued across Dairy Campus systems.
  - `cow` / `oornum` / `AnimalNo`: Practical ear tag management number (typically 3 to 4 digits).
  - `LevNum`: Full European official animal registration / life number.
  - `prfcod`: Research experiment / trial code (e.g., `4400003634`).
- **Measurement vs. Calculated**:
  - `Measured`: Directly recorded by hardware sensors, RFID transponders, scales, meters, or laboratory analyzers.
  - `Calculated`: Derived via mathematical transformation, temporal aggregation, dry matter correction, or subtraction of mixer wagon added water (defined in `calculations/`).
