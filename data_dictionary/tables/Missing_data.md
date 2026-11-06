# Data Quality and Missing Data Flags (Missing_data)

**Dataset Identifier:** `Missing_data`  
**Underlying Database Source:** `tvl_totaal_missende_data_proef`  
**Observation Granularity:** One row per animal per calendar day  

## Description

Automated data validation and completeness flags per cow per day, tracking whether milk yields, body weights, feed intake, Nedap Velos tracking, or BCS camera observations are missing or suspect.

## Variables & Data Dictionary

| Column Name | English Label | Data Type | Unit | Type | Description | Calculation / Source |
|:---|:---|:---|:---|:---|:---|:---|
| `bcs` | Body condition score | `boolean` | Ja/Nee | Measured | Automatic body condition score camera | Direct measurement |
| `behcod` | Treatment code | `string` | Ja/Nee | Measured | Treatment code | Direct measurement |
| `bijzonderheden` | Particularities | `boolean` | Ja/Nee | Measured | Particularities | Direct measurement |
| `date` | Date | `date` | yy-mm-dd | Measured | Date of the data record | Direct measurement |
| `gewa` | Weight evening | `boolean` | Ja/Nee | Measured | Weight evening | Direct measurement |
| `gewgeaa` | Weight gea evening | `boolean` | Ja/Nee | Measured | Weight gea evening | Direct measurement |
| `gewgeao` | Weight gea morning | `boolean` | Ja/Nee | Measured | Weight gea morning | Direct measurement |
| `gewo` | Weight morning | `boolean` | Ja/Nee | Measured | Weight morning | Direct measurement |
| `hok` | Barn | `boolean` | Ja/Nee | Measured | Barn | Direct measurement |
| `kgmlka` | Kg milk evening | `boolean` | Ja/Nee | Measured | Kg milk evening | Direct measurement |
| `kgmlko` | Kg milk morning | `boolean` | Ja/Nee | Measured | Kg milk morning | Direct measurement |
| `oornum` | Ear number | `integer` | number | N/A | Number on the ear tag of the animal, length 3-4 numbers. Derives from the registration number. | Direct measurement |
| `opnkv` | Intake feed | `boolean` | Ja/Nee | Measured | Intake feed | Direct measurement |
| `opnrv` | Intake roughage | `string` | Ja/Nee | Measured | Intake roughage | Direct measurement |
| `prdsta` | Production stage | `boolean` | Ja/Nee | Measured | Identifying the stage of the cow, producing milk or not | Direct measurement |
| `prfcod` | Trial code | `string` | Ja/Nee | Measured | Trial code | Direct measurement |
| `velos` | Velos | `boolean` | Ja/Nee | Measured | Velos cow behavior | Direct measurement |
