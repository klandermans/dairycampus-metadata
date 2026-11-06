# Trioliet Feeding Robot Trough Delivery Records (Triomatic_RIC_drop)

**Dataset Identifier:** `Triomatic_RIC_drop`  
**Underlying Database Source:** `t_raw_trioliet (subgroupnr <> 0)`  
**Observation Granularity:** One row per feeding delivery drop event  

## Description

Batch delivery (discharge) records from the Trioliet Triomatic feeding robot to individual barn pens, groups, and RIC feeding bins. Captures distributed weight, delivery time, and destination pen.

## Variables & Data Dictionary

| Column Name | English Label | Data Type | Unit | Type | Description | Calculation / Source |
|:---|:---|:---|:---|:---|:---|:---|
| `AnimalCount` | Animal count | `integer` | number | N/A | The number of animals | Direct measurement |
| `Date` | Date | `datetime` | yy-mm-dd-hh-mm-ss | Measured | Date | Direct measurement |
| `Extra` | Extra | `integer` | number | N/A | Extra information | Direct measurement |
| `FeedingGroup` | Feeding group | `integer` | number | Measured | Log source 0 = 1, log source 1 = NULL betekenis Feeding group? | Direct measurement |
| `filename` | Filename | `string` | short text | N/A | Name of the file containing information | Direct measurement |
| `FinishedReady` | Finished ready | `string` | ? | N/A | NULL? | Direct measurement |
| `GroupID` | Group ID | `integer` | number | N/A | Id of the group | Direct measurement |
| `GroupName` | Group name | `string` | short text | N/A | Name of the group | Direct measurement |
| `Id` | ID | `integer` | number | N/A | ID | Direct measurement |
| `IngredientName` | Ingredient name | `string` | short text | N/A | Name of the ingredient | Direct measurement |
| `k42` | k42 | `integer` | number | N/A | Validation record for data processing | Direct measurement |
| `LogSource` | Log source | `integer` | number | N/A | 0 meaning feed preparation, and 1 the distribution of feed to RIC bins | Direct measurement |
| `NettoLoadedWeight` | Netto loaded weight | `number` | kg | Measured | Netto weight loaded | Direct measurement |
| `NrOfSplittings` | Number of splittings | `integer` | number | N/A | Number of splittings | Direct measurement |
| `NumberRecipeLines` | Number of recipe lines | `integer` | number | N/A | Total number of recipe lines | Direct measurement |
| `OpdrachtID` | Job ID | `integer` | number | N/A | Job ID | Direct measurement |
| `PerformedFeedFactor` | Performed feed factor | `integer` | number | N/A | Performed feed factor | Direct measurement |
| `PerformedProductDryWeightKgAfterDrop` | Kg dry weight after drop | `number` | kg | Measured | Kg dry weight after drop | Direct measurement |
| `PerformedProductDryWeightPartAfterDrop` | Part of dry weight after drop | `number` | kg | Measured | Part of dry weight after drop | Direct measurement |
| `PerformedProductError` | Performed product error | `number` | kg | Calculated | Error, difference between Scheduled kg and performed kg feed | **Calculated**: ? |
| `PerformedProductKgAfterDrop` | Kg product after drop | `number` | kg | Measured | Kg product after drop | Direct measurement |
| `PerformedProductKgAtStop` | Kg product at stop | `number` | kg | Measured | Kg product at stop | Direct measurement |
| `PerformedTime` | Performed time | `number` | hh-mm-ss | Measured | Performed time | Direct measurement |
| `PushingGroup` | Pushing group | `integer` | number | N/A | Pushing group | Direct measurement |
| `Ready` | Ready | `integer` | number | N/A | Ready | Direct measurement |
| `ReadyTime` | Ready time | `number` | hh-mm-ss | N/A | Ready time, if log source 1 | Direct measurement |
| `ReceptLineNr` | Recept line number | `integer` | number | N/A | Current number of recipe line | Direct measurement |
| `ReceptName` | Recipe name | `string` | short text | N/A | Name of the feed recipe | Direct measurement |
| `ScheduledDryWeightContent` | Scheduled dry weight content | `integer` | number | Calculated | Scheduled dry weight content | **Calculated**: ? |
| `ScheduledDryWeightContentPart` | Scheduled dry weight content part | `integer` | number | Calculated | Scheduled dry weight content part | **Calculated**: ? |
| `ScheduledDryWeightKg` | Scheduled dry weight kg | `number` | kg | Calculated | Scheduled dry weight kg | **Calculated**: ? |
| `ScheduledFeedFactor` | Scheduled feed factor | `integer` | number | N/A | Scheduled feed factor | Direct measurement |
| `ScheduledPart` | Scheduled part | `integer` | number | Calculated | Scheduled part | **Calculated**: ? |
| `ScheduledProductKg` | Scheduled product kg | `number` | kg | N/A | Scheduled product kg | Direct measurement |
| `ScheduledTime` | Scheduled time | `number` | hh-mm-ss | N/A | Scheduled time, if log source 1 | Direct measurement |
| `SplittedNr` | Splitted number | `integer` | number | N/A | Splitted number, only 1 | Direct measurement |
| `StartPosition` | Start position | `integer` | number | Measured | Start position, if subgroup not 0 | Direct measurement |
| `StartTime` | Start time | `number` | hh-mm-ss | Measured | Start time, if subgroup not 0 | Direct measurement |
| `StartWeight` | Start weight | `number` | kg | Measured | Start weight, if subgroup not 0 | Direct measurement |
| `StopPosition` | Stop position | `integer` | number | Measured | Stop position, if subgroup not 0 | Direct measurement |
| `StopTime` | Stop time | `number` | hh-mm-ss | Measured | Stop time, if subgroup not 0 | Direct measurement |
| `StopWeight` | Stop weight | `number` | kg | Measured | Stop weight, if subgroup not 0 | Direct measurement |
| `StrawGroup` | Straw group | `integer` | number | N/A | Straw group | Direct measurement |
| `SubGroupNr` | Subgroup number | `integer` | number | N/A | Number of the subgroup, 0 no subgroup | Direct measurement |
| `TakeoffTime` | Take off time | `number` | hh-mm-ss | Measured | Take off time, if log source 1 | Direct measurement |
| `TrackSection` | Track section | `integer` | number | N/A | Track section, if subgroup 1 if there is no subgroup 0 | Direct measurement |
