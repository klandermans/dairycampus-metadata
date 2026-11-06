# Barn Environment & Animal Daily Profile (Environment_barn_Animal_day)

**Dataset Identifier:** `Environment_barn_Animal_day`  
**Underlying Database Source:** `TVL_Dier_Datum_Stal`  
**Observation Granularity:** One row per animal per housing location per calendar day  

## Description

Integrated animal-level daily profile linking barn compartment/pen locations, lactation days, age, group movements, and daily intake/yield metrics.

## Variables & Data Dictionary

| Column Name | English Label | Data Type | Unit | Type | Description | Calculation / Source |
|:---|:---|:---|:---|:---|:---|:---|
| `AgeDAys` | Age | `integer` | number | Measured | Age of the animal in days | Direct measurement |
| `AnimalNumber` | Animal Number | `integer` | number | N/A | Unique animal server identifier issued across the different systems at Dairy Campus | Direct measurement |
| `AntGewA` | Weight afternoon | `number` | kg | Measured | Weight of the animal after milking in the afternoon | Direct measurement |
| `AntGewO` | Weight morning | `number` | kg | Measured | Weight of the animal after milking in the morning | Direct measurement |
| `BirthDate` | Date of birth | `date` | yyyy-mm-dd | Measured | The cows date of birth | Direct measurement |
| `DateMelkCon4Wk` | Date of 4-Weekly Milk Recording | `date` | yyyy-mm-dd | Measured | Date of the most recent official 4-weekly milk control / recording event (MPR). | Source: T_Animal_MilkSamples |
| `DatGldTot` | Valid Until Date | `datetime` | yyyy-mm-dd | Calculated | Date until which the current housing, lactation, or trial assignment status remains valid. | **Calculated**: End validity date of status record. *(Source: TVL_Dier_Datum_Stal)* |
| `DaysInLactation` | Days in lactation | `integer` | number | Calculated | Amount of days producing milk | **Calculated**: Date - calving date *(Source: ?)* |
| `DryDate` | Start date dry period | `date` | yy-mm-dd | Measured | Starting date of the dry period | Direct measurement |
| `EarNumber` | Ear number | `integer` | number | N/A | Number on the ear tag of the animal, length 3-4 numbers. Derives from the registration number. | Direct measurement |
| `Eiw` | Protein concentration standard | `number` | % | Calculated | Protein concentration of the monthly milk test | **Calculated**: Calculated by whom or what or how? *(Source: ?)* |
| `EndDate` | Ending date experiment | `date` | yy-mm-dd | Measured | Expected end date of the experiment | Direct measurement |
| `Ket` | Ketose concentration of the monthly milk test | `string` | Calculated | Calculated | number | **Calculated**: Laboratory diagnostic score from milk recording analysis. *(Source: T_Animal_MilkSamples)* |
| `ExpecCalvingDate` | Expected calving date | `date` | yy-mm-dd | Calculated | Expected calving date based on insemination date | **Calculated**: Calculated by ExpectedCalvingDate() function from last successful insemination. *(Source: t_animal_matings / ExpectedCalvingDate)* |
| `Fat%` | Calculated day fat concentration | `number` | % | Calculated | An estimated daily milk fat concentration based on the AO sampling and the corresponding milk yield of that day.  x | **Calculated**: Calculated by whom or what or how? *(Source: ?)* |
| `GewTot` | Weight totaal | `number` | kg | Measured | Average weight of the animal for the day. | Source: TVL_Dier_Gewicht_Etmaal |
| `IDNumber` | ID nummer | `integer` | National registration number of the animal. | Measured | Registration number same as LevNum | Source: t_animals |
| `InsiminationDate` | Insemination day | `date` | yy-mm-dd | Measured | Date of last insemination | Direct measurement |
| `Lac` | Lactose concentration standard | `number` | % | Calculated | Lactose of the monthly milk test | **Calculated**: Calculated by whom or what or how? *(Source: ?)* |
| `Lactose%` | Calculated day lactose concentration | `number` | % | Calculated | An estimated daily milk lactose concentration based on the AO sampling and the corresponding milk yield of that day. | **Calculated**: Calculated by whom or what or how? *(Source: ?)* |
| `LastCalvingDate` | Last calving date | `date` | yy-mm-dd | Measured | Date of last calving | Direct measurement |
| `Milk_Yield` | Milk Yield | `number` | kg | Calculated | Milk yield | **Calculated**: Verschil Milk_Yield, MilkYield en MilkDay? |
| `MilkAfternoon` | Milk Yield afternoon | `number` | kg | Calculated | Milk Yield afternoon | **Calculated**: N/A |
| `MilkDay` | Milk Yield day | `number` | kg | Calculated | Milk Yield day | **Calculated**: N/A |
| `MilkMorning` | Milk Yield morning | `number` | kg | Calculated | Milk Yield morning | **Calculated**: N/A |
| `MilkYield` | Milk Yield | `number` | kg | Calculated | Milk yield | **Calculated**: N/A |
| `MlkCon` | Milk Con? | `boolean` | boolean | Calculated | Indicator flag showing whether official milk recording (MPR) data was collected on this date. | **Calculated**: Boolean flag indicating presence of milk laboratory sample record. *(Source: T_Animal_MilkSamples)* |
| `NumberAnimal` | Number Animal | `integer` | number | N/A | Unique animal server identifier issued across the different systems at Dairy Campus | Direct measurement |
| `NumberOLactations` | Parity | `integer` | number | Measured | Parity (amount of calvings) of the animal | Direct measurement |
| `NumbOfDates` | Number of dates? | `date` | count | Calculated | Count of observation days recorded for the animal within the experimental reporting period. | **Calculated**: Count of distinct active recording dates. *(Source: TVL_Dier_Datum_Proef)* |
| `Protein%` | Calculated day protein concentration | `number` | % | Calculated | An estimated daily milk protein concentration based on the AO sampling and the corresponding milk yield of that day. | **Calculated**: Calculated by whom or what or how? *(Source: ?)* |
| `SampleDateEvening` | Sample date evening | `datetime` | yy-mm-dd-hh-mm-ss | Measured | Date the sample was obtained during the evening | Direct measurement |
| `SampleDateMorning` | Sample date morning | `datetime` | yy-mm-dd-hh-mm-ss | Measured | Date the sample was obtained during the morning | Direct measurement |
| `SCC` | Calculated day somatic cell count | `string` | 1000 cells/mL | Calculated | An estimated daily somatic cell count based on the AO sampling and the corresponding milk yield of that day. | **Calculated**: Calculated by whom or what or how? *(Source: ?)* |
| `StartDate` | Start date | `datetime` | hh-mm-ss | Measured | Start date | Direct measurement |
| `Stl` | Barn Section | `string` | identifier | Measured | Physical barn building or housing section identifier at Dairy Campus. | Source: TVL_Dier_Datum_Stal |
| `SumVoeGft` | Total Feed Granted | `number` | kg | Calculated | Total amount of concentrate feed programmed/granted to the animal over the period. | **Calculated**: Sum of programmed concentrate feeding amounts. *(Source: TVL_Dier_Voeropname_KV_Etmaal)* |
| `SumVoeOpnm` | Total Feed Intake | `number` | kg | Calculated | Total actual concentrate feed consumed by the animal over the period. | **Calculated**: Sum of consumed concentrate intake amounts. *(Source: TVL_Dier_Voeropname_KV_Etmaal)* |
| `SumVoeRst` | Total Feed Residual | `number` | kg | Calculated | Total amount of unconsumed concentrate feed remaining in the troughs. | **Calculated**: Total Feed Granted minus Total Feed Intake. *(Source: TVL_Dier_Voeropname_KV_Etmaal)* |
| `Unit` | Unit / barn number | `integer` | number | N/A | Location of where the cows are housed. | Direct measurement |
| `Ure` | Calculated day urea concentration | `string` | mg/dL | Calculated | An estimated daily milk urea concentration based on the AO sampling and the corresponding milk yield of that day. | **Calculated**: Calculated by whom or what or how? *(Source: ?)* |
| `Urea (mg/100g)` | Weekly milk urea concentration | `string` | mg/dL | Measured | Weekly milk urea concentration during the AO sampling for animals in an experiment. AO = avond ochtend (eveningn morning) sample, taken on Tuesday evening and Wednesday morning. So 2 values per week. | Direct measurement |
| `Vet` | Weekly milk fat concentration | `number` | % | Measured | Weekly milk fat concentration during the AO sampling for animals in an experiment. AO = avond ochtend (eveningn morning) sample, taken on Tuesday evening and Wednesday morning. So 2 values per week. | Direct measurement |
| `Week` | Week | `integer` | number | Measured | Calender week number of data record | Direct measurement |
| `WeekDay` | Day of the week | `string` | short text | N/A | Abbreviaton of weekday (Ma = Monday, Di = Tuesday, Wo = Wednesday, Do = Thursday, Vr = Friday, Za = Saturday, Zo = Sunday) | Direct measurement |
| `WeightAfternoon` | Weight afternoon | `number` | kg | Measured | Weight of the animal after milking in the afternoon | Direct measurement |
| `WeightMorning` | Weight morning | `number` | kg | Measured | Weight of the animal after milking in the morning | Direct measurement |
| `Year` | number | `string` | N/A | N/A | Measured | Direct measurement |
| `VrwDgn` | Expected Days | `integer` | days | Calculated | Expected remaining gestation days or planned days dry prior to the anticipated calving date. | **Calculated**: Expected calving date minus current date. *(Source: TVL_Dier_Datum_Stal)* |
| `AntMlkO` | Number of milkings morning | `integer` | number | Measured | How often an animal was milked in the morning. 1 is the assumed value. 0 means a missing value/something wrong with registration. 2+ means reattachment of the milking apparatus, can be outlier values. | Direct measurement |
| `AntMlkA` | Number of milkings afternoon | `integer` | number | Measured | How often an animal was milked in the afternoon. 1 is the assumed value. 0 means a missing value/something wrong with registration. 2+ means reattachment of the milking apparatus, can be outlier values. | Direct measurement |
| `Date` | Date | `datetime` | yy-mm-dd-hh-mm-ss | Measured | Date | Direct measurement |
