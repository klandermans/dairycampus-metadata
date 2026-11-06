# CowConnect Mixer Wagon Rations (TMR_Trioliet_cowconnect_mix)

**Dataset Identifier:** `TMR_Trioliet_cowconnect_mix`  
**Underlying Database Source:** `t_raw_cowconnect_mix`  
**Observation Granularity:** One row per ingredient batch per mix event  

## Description

TMR (Total Mixed Ration) mixing records collected via the CowConnect digital weighing system on mobile mixer wagons. Records loaded quantities, planned vs actual weights, and mixing times per ingredient.

## Variables & Data Dictionary

| Column Name | English Label | Data Type | Unit | Type | Description | Calculation / Source |
|:---|:---|:---|:---|:---|:---|:---|
| `date` | Date | `date` | yy-mm-dd | Measured | Date of the data record | Direct measurement |
| `externalFeedplanID` | External feedpland ID | `string` | ? | N/A | All NULL | Direct measurement |
| `feedplanId` | Feedplan ID | `integer` | number | N/A | Id of the feedplan | Direct measurement |
| `feedplanName` | Feedplan name | `string` | short text | N/A | Name of the feedplan | Direct measurement |
| `id` | ID | `string` | short text | N/A | ID | Direct measurement |
| `isOpen` | Is Open | `integer` | number | N/A | 1 or 0 process running or not. | Direct measurement |
| `loadedSum` | Loaded som | `number` | kg | Calculated | Total / sum of all loads | **Calculated**: ? |
| `mixDate` | Mix date | `datetime` | yy-mm-dd-hh-mm-ss | Measured | Date and time | Direct measurement |
| `mixLoaderId` | Mix loader ID | `integer` | number | N/A | ID of the mix loader | Direct measurement |
| `mixLoaderName` | Mix loader name | `string` | short text | N/A | Name of the mix loader | Direct measurement |
| `rationId` | Ration ID | `string` | ? | N/A | All NULL | Direct measurement |
| `type` | Type | `string` | short text | N/A | Type | Direct measurement |
