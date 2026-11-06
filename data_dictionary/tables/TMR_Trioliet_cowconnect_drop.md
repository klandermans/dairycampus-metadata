# CowConnect Feed Distribution Drops (TMR_Trioliet_cowconnect_drop)

**Dataset Identifier:** `TMR_Trioliet_cowconnect_drop`  
**Underlying Database Source:** `t_raw_cowconnect_drop`  
**Observation Granularity:** One row per feed fence discharge drop  

## Description

Discharge and delivery logs of mixed rations to feed fences and groups recorded via the CowConnect system.

## Variables & Data Dictionary

| Column Name | English Label | Data Type | Unit | Type | Description | Calculation / Source |
|:---|:---|:---|:---|:---|:---|:---|
| `id` | ID | `string` | short text | N/A | ID | Direct measurement |
| `externalMixTaskId` | External mix task ID | `string` | short text | N/A | External mix task ID | Direct measurement |
| `quantity` | Quantity | `number` | kg | Measured | Quantity | Direct measurement |
| `leftOverQuantity` | Left over quantity | `number` | kg | Measured | Quantity left over | Direct measurement |
| `noOfAnimals` | Number of animals | `integer` | number | N/A | Number of animals | Direct measurement |
| `feedSectionName` | Feed section name | `string` | short text | N/A | Name of the feed section | Direct measurement |
| `feedsectionType` | feed section type | `integer` | number | N/A | Feedsection type | Direct measurement |
| `externalFeedSectionId` | External feed sectiond ID | `integer` | number | N/A | External Feed section ID if the feed section has an external ID | Direct measurement |
| `externalMixTask` | External mix task | `string` | N/A | N/A | NULL | Direct measurement |
| `mix_id` | Mix ID | `string` | short text | N/A | Mix ID and external mix task id are foreign keys of the ID (primairy key) | Direct measurement |
| `type` | Type | `string` | short text | N/A | Type | Direct measurement |
