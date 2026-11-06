# GEA Milking Robot and Parlor Transactions (GEA_milkings)

**Dataset Identifier:** `GEA_milkings`  
**Underlying Database Source:** `T_RAW_Gea_milk`  
**Observation Granularity:** One row per milking event  

## Description

Individual milking session transactions from GEA milking systems (automatic milking rotary/robots). Records milk yield per quarter/session, milking duration, milk conductivity, blood detection, animal body weight at milking, and status flags.

## Variables & Data Dictionary

| Column Name | English Label | Data Type | Unit | Type | Description | Calculation / Source |
|:---|:---|:---|:---|:---|:---|:---|
| `Cow` | Cow | `integer` | number | N/A | Number on the ear tag of the animal, length 3-4 numbers. Derives from the registration number. Same as AnimalNo, is unique per date. | Direct measurement |
| `IMDat` | Gea Date and time | `datetime` | yy-mm-dd-hh-mm-ss | N/A | GEA, Date and time milking | Direct measurement |
| `Reg1` | Registration number | `integer` | text + number | N/A | National registration number of the animal. | Direct measurement |
| `RespISO` | Responder number | `integer` | number | N/A | Number of the cows responder | Direct measurement |
| `Name` | Name | `string` | N/A | N/A | Number in GEA, should be same as cow | Direct measurement |
| `IMTim` | Gea time | `string` | N/A | N/A | Time? | Direct measurement |
| `IMWt` | Cow Weight at Milking | `number` | kg | Measured | Live animal body weight measured by the integrated scale inside the GEA milking stall or exit platform. | Source: T_RAW_Gea_milk |
| `IMFlg` | Milking Status Flag | `string` | code | Measured | Status/diagnostic flag from GEA milking robot/parlor indicating normal completion, kick-off, or incomplete milking. | Source: T_RAW_Gea_milk |
| `IMDim` | Days in Milk | `integer` | days | Calculated | Days in Milk (DIM) recorded in GEA at the time of the milking event. | **Calculated**: Milking date minus most recent calving date. *(Source: T_RAW_Gea_milk)* |
| `IMAvFlo` | Avarage milkflow | `string` | N/A | N/A | Average milkflow? | Direct measurement |
| `IMMxFlow` | Max. milkflow | `string` | N/A | N/A | Max. milkflowAlleen '\|\|\|\|' als waarde??? | Direct measurement |
| `IMStall` | Gea barn | `integer` | number | N/A | Place in the Gea milking carousel 1-40 | Direct measurement |
| `IMStartSec` | Gea start sec | `string` | N/A | N/A | Alleen '?????' als waarde??? | Direct measurement |
