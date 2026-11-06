# Experimental Cohort Animal Daily Records (Environment_barn_Animal_experim)

**Dataset Identifier:** `Environment_barn_Animal_experim`  
**Underlying Database Source:** `TVL_Dier_Datum_Proef`  
**Observation Granularity:** One row per experimental animal per calendar day  

## Description

Experiment-specific animal daily tracking table joining trial assignment, treatment codes, block numbers, and longitudinal performance parameters.

## Variables & Data Dictionary

| Column Name | English Label | Data Type | Unit | Type | Description | Calculation / Source |
|:---|:---|:---|:---|:---|:---|:---|
| `AntMlkA` | Number of milkings afternoon | `integer` | number | Measured | How often an animal was milked in the afternoon. 1 is the assumed value. 0 means a missing value/something wrong with registration. 2+ means reattachment of the milking apparatus, can be outlier values. | Direct measurement |
| `AntMlkO` | Number of milkings morning | `integer` | number | Measured | How often an animal was milked in the morning. 1 is the assumed value. 0 means a missing value/something wrong with registration. 2+ means reattachment of the milking apparatus, can be outlier values. | Direct measurement |
| `Date` | Date | `datetime` | yy-mm-dd-hh-mm-ss | Measured | Date | Direct measurement |
| `VrwDgn` | Expected Days | `integer` | days | Calculated | Expected remaining gestation days or planned days dry prior to the anticipated calving date. | **Calculated**: Expected calving date minus current date. *(Source: TVL_Dier_Datum_Stal)* |
| `AgeDays` | Age in Days | `integer` | days | Calculated | Age of the animal in days calculated as recording date minus birth date. | **Calculated**: Recording date - Birth date. *(Source: TVL_Dier_Datum_Stal)* |
| `AnimalNumber` | Animal Number | `integer` | number | N/A | Unique animal server identifier issued across the different systems at Dairy Campus | Direct measurement |
| `BirthDate` | Date of birth | `date` | yyyy-mm-dd | Measured | The cows date of birth | Direct measurement |
| `DaysInLactation` | Days in lactation | `integer` | number | Calculated | Amount of days producing milk | **Calculated**: Date - calving date *(Source: ?)* |
| `DryDate` | Start date dry period | `date` | yy-mm-dd | Measured | Starting date of the dry period | Direct measurement |
| `EarNumber` | Ear number | `integer` | number | N/A | Number on the ear tag of the animal, length 3-4 numbers. Derives from the registration number. | Direct measurement |
| `EndDate` | Ending date experiment | `date` | yy-mm-dd | Measured | Expected end date of the experiment | Direct measurement |
| `Fat%` | Calculated day fat concentration | `number` | % | Calculated | An estimated daily milk fat concentration based on the AO sampling and the corresponding milk yield of that day.  x | **Calculated**: Calculated by whom or what or how? *(Source: ?)* |
| `GewTot` | Total Weight | `number` | kg | Measured | Total live animal body weight (average or latest measurement for the date). | Source: TVL_Dier_Gewicht_Etmaal |
| `InsiminationDate` | Insemination day | `date` | yy-mm-dd | Measured | Date of last insemination | Direct measurement |
| `Ket` | Ketosis Indicator | `string` | code | Calculated | Ketosis classification indicator (0: healthy/negative, 1: suspected subclinical ketosis, 2: clinical ketosis). | **Calculated**: Laboratory diagnostic score from milk recording analysis. *(Source: T_Animal_MilkSamples)* |
| `Lactose%` | Calculated day lactose concentration | `number` | % | Calculated | An estimated daily milk lactose concentration based on the AO sampling and the corresponding milk yield of that day. | **Calculated**: Calculated by whom or what or how? *(Source: ?)* |
| `LastCalvingDate` | Last calving date | `date` | yy-mm-dd | Measured | Date of last calving | Direct measurement |
| `NumberAnimal` | Number Animal | `integer` | number | N/A | Unique animal server identifier issued across the different systems at Dairy Campus | Direct measurement |
| `NumberOLactations` | Parity | `integer` | number | Measured | Parity (amount of calvings) of the animal | Direct measurement |
| `NumbOfDates` | Number of Dates | `date` | count | Calculated | Count of observation days recorded for the animal within the experimental reporting period. | **Calculated**: Count of distinct active recording dates. *(Source: TVL_Dier_Datum_Proef)* |
| `Projectcode` | Project Code | `string` | identifier | Measured | Unique research experiment / trial code (e.g. 4400003634). Same as prfcod. | Source: t_proef |
| `ProjectName` | Project Name | `string` | text | Measured | Official descriptive name of the research project or trial. Same as prfnam. | Source: t_proef |
| `Protein%` | Calculated day protein concentration | `number` | % | Calculated | An estimated daily milk protein concentration based on the AO sampling and the corresponding milk yield of that day. | **Calculated**: Calculated by whom or what or how? *(Source: ?)* |
| `SampleDateEvening` | Sample date evening | `datetime` | yy-mm-dd-hh-mm-ss | Measured | Date the sample was obtained during the evening | Direct measurement |
| `SampleDateMorning` | Sample date morning | `datetime` | yy-mm-dd-hh-mm-ss | Measured | Date the sample was obtained during the morning | Direct measurement |
| `SCC` | Calculated day somatic cell count | `string` | 1000 cells/mL | Calculated | An estimated daily somatic cell count based on the AO sampling and the corresponding milk yield of that day. | **Calculated**: Calculated by whom or what or how? *(Source: ?)* |
| `StartDate` | Start date | `datetime` | hh-mm-ss | Measured | Start date | Direct measurement |
| `SumVoeGft` | Total Feed Granted | `number` | kg | Calculated | Total amount of concentrate feed programmed/granted to the animal over the period. | **Calculated**: Sum of programmed concentrate feeding amounts. *(Source: TVL_Dier_Voeropname_KV_Etmaal)* |
| `SumVoeRst` | Total Feed Residual | `number` | kg | Calculated | Total amount of unconsumed concentrate feed remaining in the troughs. | **Calculated**: Total Feed Granted minus Total Feed Intake. *(Source: TVL_Dier_Voeropname_KV_Etmaal)* |
| `Unit` | Unit / barn number | `integer` | number | N/A | Location of where the cows are housed. | Direct measurement |
| `Urea (mg/100g)` | Weekly milk urea concentration | `string` | mg/dL | Measured | Weekly milk urea concentration during the AO sampling for animals in an experiment. AO = avond ochtend (eveningn morning) sample, taken on Tuesday evening and Wednesday morning. So 2 values per week. | Direct measurement |
| `Week` | Week | `integer` | number | Measured | Calender week number of data record | Direct measurement |
| `WeekDay` | Day of the week | `string` | short text | N/A | Abbreviaton of weekday (Ma = Monday, Di = Tuesday, Wo = Wednesday, Do = Thursday, Vr = Friday, Za = Saturday, Zo = Sunday) | Direct measurement |
| `WeightAfternoon` | Weight afternoon | `number` | kg | Measured | Weight of the animal after milking in the afternoon | Direct measurement |
| `WeightMorning` | Weight morning | `number` | kg | Measured | Weight of the animal after milking in the morning | Direct measurement |
| `Year` | number | `string` | N/A | N/A | Measured | Direct measurement |
| `AntGewA` | Weight afternoon | `number` | kg | Measured | Weight of the animal after milking in the afternoon | Direct measurement |
| `AntGewO` | Weight morning | `number` | kg | Measured | Weight of the animal after milking in the morning | Direct measurement |
| `IDNumber` | Animal Identification Number | `string` | identifier | Measured | Official national unique life identification number of the animal (LevNum / EU identification tag). | Source: t_animals |
| `DateMelkCon4Wk` | Date of 4-Weekly Milk Recording | `date` | yyyy-mm-dd | Measured | Date of the most recent official 4-weekly milk control / recording event (MPR). | Source: T_Animal_MilkSamples |
| `DatGldTot` | Valid Until Date | `datetime` | yyyy-mm-dd | Calculated | Date until which the current housing, lactation, or trial assignment status remains valid. | **Calculated**: End validity date of status record. *(Source: TVL_Dier_Datum_Stal)* |
| `Eiw` | Protein concentration standard | `number` | % | Calculated | Protein concentration of the monthly milk test | **Calculated**: Calculated by whom or what or how? *(Source: ?)* |
| `ExpecCalvingDate` | Expected Calving Date | `date` | yyyy-mm-dd | Calculated | Estimated date of the next calving, based on confirmed insemination date + gestation length (~270-280 days). | **Calculated**: Calculated by ExpectedCalvingDate() function from last successful insemination. *(Source: t_animal_matings / ExpectedCalvingDate)* |
| `Lac` | Lactose concentration standard | `number` | % | Calculated | Lactose of the monthly milk test | **Calculated**: Calculated by whom or what or how? *(Source: ?)* |
| `Milk_Yield` | Milk Yield | `number` | kg | Calculated | Milk yield | **Calculated**: Verschil Milk_Yield, MilkYield en MilkDay? |
| `MilkAfternoon` | Milk Yield afternoon | `number` | kg | Calculated | Milk Yield afternoon | **Calculated**: N/A |
| `MilkDay` | Milk Yield day | `number` | kg | Calculated | Milk Yield day | **Calculated**: N/A |
| `MilkMorming` | Morning Milk Yield | `number` | kg | Measured | Total quantity of milk produced during morning milking sessions. | Source: TVL_Dier_Melkgift_Etmaal_Melkcontrole |
| `MilkYield` | Milk Yield | `number` | kg | Calculated | Milk yield | **Calculated**: N/A |
| `MlkCon` | Milk Recording Present | `boolean` | boolean | Calculated | Indicator flag showing whether official milk recording (MPR) data was collected on this date. | **Calculated**: Boolean flag indicating presence of milk laboratory sample record. *(Source: T_Animal_MilkSamples)* |
| `Stl` | Barn Section | `string` | identifier | Measured | Physical barn building or housing section identifier at Dairy Campus. | Source: TVL_Dier_Datum_Stal |
| `Ure` | Calculated day urea concentration | `string` | mg/dL | Calculated | An estimated daily milk urea concentration based on the AO sampling and the corresponding milk yield of that day. | **Calculated**: Calculated by whom or what or how? *(Source: ?)* |
| `Vet` | Weekly milk fat concentration | `number` | % | Measured | Weekly milk fat concentration during the AO sampling for animals in an experiment. AO = avond ochtend (eveningn morning) sample, taken on Tuesday evening and Wednesday morning. So 2 values per week. | Direct measurement |
| `SumVoeOpnm` | Total Feed Intake | `number` | kg | Calculated | Total actual concentrate feed consumed by the animal over the period. | **Calculated**: Sum of consumed concentrate intake amounts. *(Source: TVL_Dier_Voeropname_KV_Etmaal)* |
