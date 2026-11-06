# GreenFeed Enteric Emission Summaries (Greenfeed_summarized_data)

**Dataset Identifier:** `Greenfeed_summarized_data`  
**Underlying Database Source:** `T_RAW_Greenfeed_Summarized_Data`  
**Observation Granularity:** One row per validated GreenFeed visit  

## Description

Validated visit-level enteric methane (CH4) and carbon dioxide (CO2) emission measurements from C-Lock GreenFeed automated emission monitoring systems, including emission fluxes, head proximity detection, airflow rates, and sensor calibrations.

## Variables & Data Dictionary

| Column Name | English Label | Data Type | Unit | Type | Description | Calculation / Source |
|:---|:---|:---|:---|:---|:---|:---|
| `AirflowCf` | Airflow correction factor | `integer` | number | N/A | Airflow correction factor | Direct measurement |
| `AirflowLitersPerSec` | Airflow liters per second | `integer` | Liter/sec | Measured | Airflow liters per second | Direct measurement |
| `AnimalName` | Animal name | `integer` | number | Measured | Animal name | Direct measurement |
| `CH4GramsPerDay` | CH4 grams per day | `integer` | number | Measured | CH4 grams per day, methane | Direct measurement |
| `CO2GramsPerDay` | CO2 grams per day | `integer` | number | Measured | CO2 grams per day, carbon dioxide | Direct measurement |
| `cow` | Cow | `integer` | number | N/A | Number on the ear tag of the animal, length 3-4 numbers. Derives from the registration number. Same as AnimalNo, is unique per date. | Direct measurement |
| `date` | Date | `date` | yy-mm-dd | Measured | Date of the data record | Direct measurement |
| `EndTime` | End time | `number` | yy-mm-dd-hh-mm-ss | Measured | End time | Direct measurement |
| `GoodDataDuration` | Good data duration | `datetime` | hh-mm-ss | N/A | Good data duration | Direct measurement |
| `greenfeed` | Greenfeed | `integer` | number | Measured | Greenfeed | Direct measurement |
| `H2GramsPerDay` | H2 grams per day | `integer` | number | Measured | H2 grams per day, hydrogen | Direct measurement |
| `H2SGramsPerDay` | H2S grams per day | `integer` | number | Measured | H2S grams per day, hydrogen sulfide | Direct measurement |
| `InterruptingTags` | Interrupting tags | `integer` | number | N/A | Interrupting tags | Direct measurement |
| `IsPreliminary` | Is preliminary | `integer` | number | N/A | Is preliminary data, validated data comes directly from C-lock. | Direct measurement |
| `O2GramsPerDay` | O2 grams per day | `integer` | number | Measured | O2 grams per day, oxygen | Direct measurement |
| `RFID` | Rfid | `integer` | number | N/A | Rfid | Direct measurement |
| `RunTime` | Run time | `number` | yy-mm-dd-hh-mm-ss | Measured | Run time | Direct measurement |
| `StartTime` | Start time | `number` | hh-mm-ss | Measured | Start time, if subgroup not 0 | Direct measurement |
| `TempPipeDegreesCelsius` | Temperature pipe degrees celsius | `number` | °C | Measured | Temperature pipe degrees celsius | Direct measurement |
| `user` | User | `string` | short text | N/A | User | Direct measurement |
| `WasInterrupted` | Was interrupted | `integer` | number | N/A | Was interrupted | Direct measurement |
| `WindCf` | Wind correction factor | `integer` | number | N/A | Wind correction factor | Direct measurement |
| `WindDirDeg` | Wind direction degrees | `integer` | number | Measured | Wind direction degrees | Direct measurement |
| `WindSpeedMetersPerSec` | Wind speed meters per second | `integer` | meter/sec | Measured | Wind speed meters per second | Direct measurement |
