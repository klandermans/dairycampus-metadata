
CREATE view [dbo].[rosalinde_nieuw] as 

WITH dierlijst1 AS (
    SELECT 
        T_Animals.AnimalServerID, 
        T_Animals.AnimalNo, 
        T_Animals.BirthDateDT, 
        T_Animals.LastDairySiteAbbr, 
        T_Animals.RegistrationId, 
        MAX(T_Animal_Calvings.LactationNo) AS MaxOfLactationNo, 
        MAX(T_Animal_Calvings.CalvingDateDT) AS MaxOfCalvingDateDT, 
        
        T_Animals.ForSaleMovementDateDT, 
        T_animal_movements.movementreasontypename AS ForSaleMovementReason
    FROM T_Animals
    left join t_animal_movements on ForSaleMovementID = MovementID


    INNER JOIN T_Animal_Calvings ON T_Animals.AnimalServerID = T_Animal_Calvings.AnimalServerID
    WHERE T_Animals.IsOnFarm = 1 AND T_Animals.KeepOnFarm = 1
    GROUP BY 
        T_Animals.AnimalServerID, 
        T_Animals.AnimalNo, 
        T_Animals.BirthDateDT, 
        T_Animals.LastDairySiteAbbr, 
        T_Animals.RegistrationId, 
        T_Animals.ForSaleMovementDateDT,
        movementreasontypename
),
dierlijst2 AS (
    SELECT 
        d1.AnimalServerID, 
        d1.AnimalNo, 
        d1.BirthDateDT, 
        d1.LastDairySiteAbbr, 
        d1.RegistrationId, 
        d1.MaxOfLactationNo AS Parity, 
        IIF(d1.MaxOfCalvingDateDT > d1.BirthDateDT, d1.MaxOfCalvingDateDT, NULL) AS LastCalving, 
        d1.ForSaleMovementDateDT, 
        d1.ForSaleMovementReason,
        IIF(MAX(T_Animal_Matings.MatingDateDT) > d1.MaxOfCalvingDateDT, MAX(T_Animal_Matings.MatingDateDT), NULL) AS ActualMating, 
        IIF(MAX(T_Animal_FertilityStatus.FertilityStateDateDT) > d1.MaxOfCalvingDateDT, MAX(T_Animal_FertilityStatus.FertilityStateDateDT), NULL) AS ActualFertilityState
    FROM dierlijst1 d1
    LEFT JOIN T_Animal_Matings ON d1.AnimalServerID = T_Animal_Matings.AnimalServerID
    LEFT JOIN T_Animal_FertilityStatus ON d1.AnimalServerID = T_Animal_FertilityStatus.AnimalServerID
    GROUP BY 
        d1.AnimalServerID, 
        d1.AnimalNo, 
        d1.BirthDateDT, 
        d1.LastDairySiteAbbr, 
        d1.RegistrationId, 
        d1.MaxOfLactationNo, 
        d1.MaxOfCalvingDateDT, 
        d1.ForSaleMovementDateDT, 
        ForSaleMovementReason
),
dierlijst3 AS (
    SELECT 
        d2.AnimalServerID, 
        d2.AnimalNo, 
        d2.BirthDateDT, 
        d2.LastDairySiteAbbr, 
        d2.RegistrationId, 
        d2.Parity, 
        d2.LastCalving, 
        d2.ForSaleMovementDateDT, 
        d2.ForSaleMovementReason,
        d2.ActualMating, 
        T_Animal_Matings.MatingTypeName, 
        T_Animal_Matings.BullName, 
        d2.ActualFertilityState, 
        T_Animal_FertilityStatus.FertilityStateTypeName, 
        T_Animal_FertilityStatus.AssumedPregnancyDateDT
    FROM dierlijst2 d2
    LEFT JOIN T_Animal_Matings ON d2.AnimalServerID = T_Animal_Matings.AnimalServerID 
        AND d2.ActualMating = T_Animal_Matings.MatingDateDT
    LEFT JOIN T_Animal_FertilityStatus ON d2.AnimalServerID = T_Animal_FertilityStatus.AnimalServerID 
        AND d2.ActualFertilityState = T_Animal_FertilityStatus.FertilityStateDateDT
),
dierlijst4 AS (
    SELECT 
        d3.AnimalServerID, 
        d3.AnimalNo, 
        d3.BirthDateDT, 
        d3.LastDairySiteAbbr, 
        d3.RegistrationId, 
        d3.Parity, 
        d3.LastCalving, 
        d3.ForSaleMovementDateDT, 
        d3.ForSaleMovementReason,
        IIF(d3.AssumedPregnancyDateDT > 0, d3.AssumedPregnancyDateDT, d3.ActualMating) AS Inseminatie, 
        d3.MatingTypeName, 
        d3.BullName, 
        d3.ActualFertilityState, 
        d3.FertilityStateTypeName
    FROM dierlijst3 d3
),
proeflijst AS (
    SELECT 
        T_Proef_Dier.DieNum, 
        COUNT(DISTINCT T_Proef_Dier.DieNum) AS Proeven, 
        MIN(T_Proef.PrfNam) AS Proef1, 
        iif(MAX(T_Proef.PrfNam) <> MIN(T_Proef.PrfNam), max(T_Proef.PrfNam), '') AS Proef2
    FROM T_Proef_Dier
    INNER JOIN T_Proef ON T_Proef_Dier.PrfCod = T_Proef.PrfCod
    WHERE T_Proef_Dier.EndDat IS NULL
    GROUP BY T_Proef_Dier.DieNum
),
melkgegevens AS (
    SELECT dienum, AVG(KgMlkEtm) AS mlk 
    FROM TVL_Dier_Melkgift_Etmaal_Melkcontrole 
    WHERE AntMlkA > 0 AND AntMlkO > 0 
    AND dat > DATEADD(dd, -8, GETDATE()) 
    GROUP BY dienum 
    HAVING COUNT(DISTINCT dat) > 6
),
gewichten AS (
    SELECT  
        animalserverid, 
        SUM(weight) / COUNT(*) AS gew 
    FROM t_animal_animalweighings 
    WHERE ABS(t_animal_animalweighings.Weight - (
            SELECT SUM(sub.weight) / COUNT(*)  
            FROM t_animal_animalweighings AS sub 
            WHERE sub.animalserverid = t_animal_animalweighings.animalserverid 
            AND WeighDateDT > DATEADD(dd, -28, GETDATE())
        )) < 50
    AND WeighDateDT > DATEADD(dd, -28, GETDATE())
    GROUP BY animalserverid
    HAVING COUNT(DISTINCT CAST(WeighDateDT AS DATE)) > 1
)
SELECT 
    proeflijst.Proef1, 
    proeflijst.Proef2, 
    dierlijst4.AnimalServerID, 
    dierlijst4.AnimalNo, 
    CAST(dierlijst4.BirthDateDT AS DATE) AS BirthDateDT,
    dierlijst4.LastDairySiteAbbr, 
    dierlijst4.RegistrationId, 
    dierlijst4.Parity, 
    CAST(dierlijst4.LastCalving AS DATE) AS LastCalving, 
    CAST(dierlijst4.ForSaleMovementDateDT AS DATE) AS ForSaleMovementDateDT,  
    dierlijst4.ForSaleMovementReason,
    CAST(dierlijst4.Inseminatie AS DATE) AS InseminatieDate, 
    dierlijst4.MatingTypeName, 
    dierlijst4.BullName, 
    CAST(dierlijst4.ActualFertilityState AS DATE) AS ActualFertilityState, 
    dierlijst4.FertilityStateTypeName, 
    CAST(IIF(dierlijst4.Inseminatie > 0, dierlijst4.Inseminatie + 280, '2030-01-01') AS DATE) AS [VW kalfdatum], 
    proeflijst.Proeven, 
    melkgegevens.mlk AS melkproductie,
    LacDgn AS lactatiedagen,
    ROUND(Fat_Concentration, 1) AS vet,
    ROUND(Protein_Concentration, 1) AS eiwit,
    ROUND(Lactose_Concentration, 1) AS lactose,
    ROUND(Urea_Concentration, 0) AS ureum, 
    ROUND(scc, 0) AS celgetal,
    CAST(VL_Dier_Datum_Crv.date AS DATE) AS mprDate,
    [Hok] AS groep,
    gewichten.gew AS gewicht,
    [LftDgn],
    [LacNum],
    CAST([DrgZetDat] AS DATE) AS DrgZetDat,
    [PrdSta]
FROM dierlijst4
LEFT JOIN proeflijst ON dierlijst4.AnimalServerID = proeflijst.DieNum
LEFT JOIN VL_Dier_Datum_Crv ON VL_Dier_Datum_Crv.AnimalServerID = dierlijst4.AnimalServerID 
    AND VL_Dier_Datum_Crv.date = (SELECT MAX(date) FROM VL_Dier_Datum_Crv)
LEFT JOIN tvl_dier_datum_stal ON tvl_dier_datum_stal.dienum = dierlijst4.AnimalServerID 
    AND tvl_dier_datum_stal.dat = CAST(DATEADD(dd, -1, GETDATE()) AS DATE)
LEFT JOIN TVL_Dier_Melkgift_Etmaal_Melkcontrole ON TVL_Dier_Melkgift_Etmaal_Melkcontrole.dienum = dierlijst4.AnimalServerID 
    AND TVL_Dier_Melkgift_Etmaal_Melkcontrole.dat = CAST(DATEADD(dd, -1, GETDATE()) AS DATE)
LEFT JOIN melkgegevens ON melkgegevens.dienum = dierlijst4.AnimalServerID 
LEFT JOIN gewichten ON gewichten.animalserverid = dierlijst4.AnimalServerID;
