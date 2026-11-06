# Laboratory Dry Matter Content Oven Tests (DC_DM_content)

**Dataset Identifier:** `DC_DM_content`  
**Underlying Database Source:** `VL_totaal_droogstoof`  
**Observation Granularity:** One row per feed sample test  

## Description

Official laboratory oven-drying dry matter test results (droogstoof) for feed batches, silage cuts, and mixed rations sampled at Dairy Campus.

## Variables & Data Dictionary

| Column Name | English Label | Data Type | Unit | Type | Description | Calculation / Source |
|:---|:---|:---|:---|:---|:---|:---|
| `BlkDat` | Can date | `datetime` | yy-mm-dd-hh-mm-ss | Measured | Date the can was weighed | Direct measurement |
| `BlkGew` | Can weight | `number` | gram | Measured | Weight of the can | Direct measurement |
| `BlkNum` | Can number | `integer` | number | N/A | Number of the can | Direct measurement |
| `DatMon` | Sample date | `datetime` | yy-mm-dd-hh-mm-ss | Measured | Date the sample was obtained | Direct measurement |
| `DatSes` | Date session | `datetime` | yy-mm-dd-hh-mm-ss | Measured | Date of weigh session | Direct measurement |
| `DrgDat` | Dried date | `datetime` | yy-mm-dd-hh-mm-ss | Measured | Date end of the analysis | Direct measurement |
| `DrgGew` | Dried weight | `number` | gram | Measured | Dried sample weight, with or without weight of the can? | Direct measurement |
| `DrgStfGkg` | Dry matter weight kg | `number` | gram | Measured | Weight of the dry matter | Direct measurement |
| `DrgTyd` | dry time | `number` | hh-mm-ss | Measured | Time end of the analysis when all moisture has evaporated | Direct measurement |
| `ObjCod` | Object code | `string` | short text | N/A | Short description/code of the sample | Direct measurement |
| `ObjCodNum` | Object code number | `integer` | number | N/A | Used when analyzing duplicate or triplicate samples | Direct measurement |
| `PrjCod` | Project code | `string` | short text | N/A | Project code | Direct measurement |
| `VlgNum` | Tracking number | `integer` | number | N/A | Tracking number | Direct measurement |
| `VrsDat` | fresh date | `datetime` | yy-mm-dd-hh-mm-ss | Measured | Date start of the analysis | Direct measurement |
| `VrsGew` | fresh weight | `number` | gram | Measured | Weight at the start of the analysis | Direct measurement |
| `VrsTyd` | fresh time | `number` | hh-mm-ss | Measured | Time start of the analysis, fresh sample is weighed | Direct measurement |
