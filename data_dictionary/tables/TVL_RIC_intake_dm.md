# Roughage Daily Intake and Dry Matter (TVL_RIC_intake_dm)

**Dataset Identifier:** `TVL_RIC_intake_dm`  
**Underlying Database Source:** `TVL_totaal_sub_ric_opn`  
**Observation Granularity:** One row per cow per feed group per calendar day  

## Description

Daily aggregated roughage intake per cow per feed group/ration, combining fresh intake, laboratory dry matter determination, and ration dry matter intake.

## Variables & Data Dictionary

| Column Name | English Label | Data Type | Unit | Type | Description | Calculation / Source |
|:---|:---|:---|:---|:---|:---|:---|
| `cow` | Cow | `integer` | number | N/A | Number on the ear tag of the animal, length 3-4 numbers. Derives from the registration number. Same as AnimalNo, is unique per date. | Direct measurement |
| `date` | Date | `date` | yy-mm-dd | Measured | Date of the data record | Direct measurement |
| `dsPct` | dry matter percentage | `integer` | number | Calculated | Percentage of dry matter in the feed | **Calculated**: ? *(Source: ?)* |
| `feedtype` | feedtype | `string` | short text | N/A | Type of feed | Direct measurement |
| `name` | Name | `string` | short text | N/A | Name collected based on other value | Direct measurement |
| `opnDsVR` | Intake dry matter Roughage RIC | `number` | kg | N/A | Intake of dry matter from roughage RIC | Direct measurement |
| `opnIncWater` | Intake including water | `number` | kg | Calculated | Feed intake including water | **Calculated**: ? *(Source: ?)* |
| `opnMinWater` | Intake subtracting water | `number` | kg | Calculated | Feed intake excluding water | **Calculated**: ? *(Source: ?)* |
| `opnProd` | Intake product | `number` | kg | N/A | Total intake of product | Direct measurement |
| `ricBez` | Ric visits | `integer` | number | N/A | Number of visits to RIC | Direct measurement |
| `RowID` | Row ID | `integer` | number | N/A | Unique number for row in a specific table. | Direct measurement |
| `trBatches` | Tioliet batches | `integer` | number | N/A | Number of times the triolith has released feed. | Direct measurement |
