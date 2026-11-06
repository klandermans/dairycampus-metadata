CREATE view [dbo].[rosalinde] as 
SELECT 
    RG_DC_dierlijst_excel.[Proef 1], 
    RG_DC_dierlijst_excel.[Proef 2], 

    RG_DC_dierlijst_excel.opmerking, 
    RG_DC_proeflijstdierlijst.AnimalServerID, 
    RG_DC_proeflijstdierlijst.AnimalNo, 
    cast(RG_DC_proeflijstdierlijst.BirthDateDT as date) as BirthDateDT,
    RG_DC_proeflijstdierlijst.LastDairySiteAbbr, 
    RG_DC_proeflijstdierlijst.RegistrationId, 
    RG_DC_proeflijstdierlijst.Parity, 
    cast(RG_DC_proeflijstdierlijst.LastCalving as date) as lastCalving, 
    cast(RG_DC_proeflijstdierlijst.ForSaleMovementDateDT as date) as ForSaleMovementDateDT,  
    cast(RG_DC_proeflijstdierlijst.Inseminatie as date) as inseminatiedate, 
    RG_DC_proeflijstdierlijst.MatingTypeName, 
    RG_DC_proeflijstdierlijst.BullName, 
    cast(RG_DC_proeflijstdierlijst.ActualFertilityState as date) AS ActualFertilityState, 
    RG_DC_proeflijstdierlijst.FertilityStateTypeName, 
    cast(IIf([Inseminatie]>0,[Inseminatie]+280,'1/1/2030')  as date) AS [VW kalfdatum], 
    RG_DC_proeflijstdierlijst.Proeven, 
    RG_DC_proeflijstdierlijst.[Proef A], 
    RG_DC_proeflijstdierlijst.[Proef B], 
    round(mlk,1) as melkproductie,
    LacDgn as lactatiedagen,
    round(Fat_Concentration,1) as vet,
    round(Protein_Concentration,1) as eiwit,
    round(Lactose_Concentration,1) as lactose,
    round(Urea_Concentration ,0) as ureum, 
    round(scc,0) as celgetal,
    cast(VL_Dier_Datum_Crv.date  as date)as mprDate,
    [Hok] as groep,
    round(gew,1) as gewicht,
    [LftDgn],
    [LacNum],
    cast([DrgZetDat] as date) as DrgZetDat,
    [PrdSta]

    -- INTO RG_DC_proeflijstdierlijst_TOTAAL
FROM (
    SELECT 
        RG_DC_dierlijst4_T.AnimalServerID, 
        RG_DC_dierlijst4_T.AnimalNo, 
        RG_DC_dierlijst4_T.BirthDateDT, 
        RG_DC_dierlijst4_T.LastDairySiteAbbr, 
        RG_DC_dierlijst4_T.RegistrationId, 
        RG_DC_dierlijst4_T.Parity, 
        RG_DC_dierlijst4_T.LastCalving, 
        RG_DC_dierlijst4_T.ForSaleMovementDateDT, 
        IIf([AssumedPregnancyDateDT]>0,[AssumedPregnancyDateDT],[ActualMating]) AS Inseminatie, 

        RG_DC_dierlijst4_T.MatingTypeName, 
        RG_DC_dierlijst4_T.BullName, 
        RG_DC_dierlijst4_T.ActualFertilityState, 
        RG_DC_dierlijst4_T.FertilityStateTypeName, 
        RG_DC_proeflijst2_T.Proeven, 
        RG_DC_proeflijst2_T.Proef1 AS [Proef A],
        IIf([Proeven]=2,[Proef2], null) AS [Proef B] 
        --  INTO RG_DC_proeflijstdierlijst
    FROM (
    SELECT 
        RG_DC_dierlijst3_T.AnimalServerID, 
        RG_DC_dierlijst3_T.AnimalNo, 
        RG_DC_dierlijst3_T.BirthDateDT, 
        RG_DC_dierlijst3_T.LastDairySiteAbbr, 
        RG_DC_dierlijst3_T.RegistrationId, 
        RG_DC_dierlijst3_T.Parity, 
        RG_DC_dierlijst3_T.LastCalving, 
        RG_DC_dierlijst3_T.ForSaleMovementDateDT, 
        RG_DC_dierlijst3_T.ActualMating, 
        T_Animal_Matings.MatingTypeName, 
        T_Animal_Matings.BullName, 
        RG_DC_dierlijst3_T.ActualFertilityState, 
        T_Animal_FertilityStatus.FertilityStateTypeName, 
        T_Animal_FertilityStatus.AssumedPregnancyDateDT 
    FROM 
        (
        SELECT 
            RG_DC_dierlijst2_T.AnimalServerID, 
            RG_DC_dierlijst2_T.AnimalNo, RG_DC_dierlijst2_T.BirthDateDT, 
            RG_DC_dierlijst2_T.LastDairySiteAbbr, 
            RG_DC_dierlijst2_T.RegistrationId, ([MaxOfLactationNo]) AS Parity, 
            IIf([MaxOfCalvingDateDT]>[BirthDateDT],[MaxOfCalvingDateDT], null) AS LastCalving, 
            RG_DC_dierlijst2_T.ForSaleMovementDateDT, 
            IIf([MaxMatingDate]>[MaxOfCalvingDateDT],[MaxMatingDate],null) AS ActualMating, 
            IIf([MaxFertStateDate]>[MaxOfCalvingDateDT],[MaxFertStateDate],null) AS ActualFertilityState
        FROM ( 
            SELECT 
                RG_DC_dierlijst1_T.AnimalServerID, 
                RG_DC_dierlijst1_T.AnimalNo, 
                RG_DC_dierlijst1_T.BirthDateDT, 
                RG_DC_dierlijst1_T.LastDairySiteAbbr, 
                RG_DC_dierlijst1_T.RegistrationId, RG_DC_dierlijst1_T.MaxOfLactationNo, 
                RG_DC_dierlijst1_T.MaxOfCalvingDateDT, RG_DC_dierlijst1_T.ForSaleMovementDateDT, 
                Max(T_Animal_Matings.MatingDateDT) AS MaxMatingDate, 
                Max(T_Animal_FertilityStatus.FertilityStateDateDT) AS MaxFertStateDate 
                -- INTO RG_DC_dierlijst2_T
            FROM (
                SELECT 
                    T_Animals.AnimalServerID, T_Animals.AnimalNo, T_Animals.BirthDateDT, T_Animals.LastDairySiteAbbr, T_Animals.RegistrationId, Max(T_Animal_Calvings.LactationNo) AS MaxOfLactationNo, Max(T_Animal_Calvings.CalvingDateDT) AS MaxOfCalvingDateDT, T_Animals.ForSaleMovementDateDT 
                    -- INTO RG_DC_dierlijst1_T
                FROM T_Animals 
                INNER JOIN T_Animal_Calvings ON T_Animals.AnimalServerID = T_Animal_Calvings.AnimalServerID
                GROUP BY T_Animals.AnimalServerID, T_Animals.AnimalNo, T_Animals.BirthDateDT, T_Animals.LastDairySiteAbbr, T_Animals.RegistrationId, T_Animals.ForSaleMovementDateDT, T_Animals.IsOnFarm, T_Animals.KeepOnFarm
                HAVING (((T_Animals.IsOnFarm)=1) AND ((T_Animals.KeepOnFarm)=1))
            ) as RG_DC_dierlijst1_T
            LEFT JOIN T_Animal_Matings ON RG_DC_dierlijst1_T.AnimalServerID = T_Animal_Matings.AnimalServerID
            LEFT JOIN T_Animal_FertilityStatus ON RG_DC_dierlijst1_T.AnimalServerID = T_Animal_FertilityStatus.AnimalServerID
            GROUP BY RG_DC_dierlijst1_T.AnimalServerID, RG_DC_dierlijst1_T.AnimalNo, RG_DC_dierlijst1_T.BirthDateDT, RG_DC_dierlijst1_T.LastDairySiteAbbr, RG_DC_dierlijst1_T.RegistrationId, RG_DC_dierlijst1_T.MaxOfLactationNo, RG_DC_dierlijst1_T.MaxOfCalvingDateDT, RG_DC_dierlijst1_T.ForSaleMovementDateDT
            -- ORDER BY RG_DC_dierlijst1_T.AnimalServerID;
        ) as RG_DC_dierlijst2_T
    ) as RG_DC_dierlijst3_T 
    LEFT JOIN 
        T_Animal_Matings ON (RG_DC_dierlijst3_T.ActualMating = T_Animal_Matings.MatingDateDT) AND (RG_DC_dierlijst3_T.AnimalServerID = T_Animal_Matings.AnimalServerID) 
    LEFT JOIN 
        T_Animal_FertilityStatus ON (RG_DC_dierlijst3_T.ActualFertilityState = T_Animal_FertilityStatus.FertilityStateDateDT) AND (RG_DC_dierlijst3_T.AnimalServerID = T_Animal_FertilityStatus.AnimalServerID)
    -- ORDER BY RG_DC_dierlijst3_T.AnimalServerID;



        
    ) as RG_DC_dierlijst4_T 
    LEFT JOIN (
        SELECT 
            RG_DC_proeflijst1_T.DieNum, 
            Count(distinct RG_DC_proeflijst1_T.DieNum) AS Proeven, 

            min(RG_DC_proeflijst1_T.PrfNam) AS Proef1, 
            max(RG_DC_proeflijst1_T.PrfNam) AS Proef2 
            -- INTO RG_DC_proeflijst2_T
        FROM (SELECT 
            T_Proef_Dier.BegDat, 
            T_Proef_Dier.EndDat, 
            T_Proef_Dier.DieNum, 
            T_Proef_Dier.PrfCod, 
            T_Proef.PrfNam 
        -- INTO RG_DC_proeflijst1_T
        FROM T_Proef_Dier INNER JOIN T_Proef ON T_Proef_Dier.PrfCod = T_Proef.PrfCod
        WHERE (((T_Proef_Dier.EndDat) Is Null))) as RG_DC_proeflijst1_T
        GROUP BY RG_DC_proeflijst1_T.DieNum
    ) as RG_DC_proeflijst2_T ON RG_DC_dierlijst4_T.AnimalServerID = RG_DC_proeflijst2_T.DieNum
) as RG_DC_proeflijstdierlijst 


LEFT JOIN (
    select 
        0 as [Server ID], 
        0 as [Proef 1], 
        0 as [Proef 2], 
        0 as Louise, 
        0 as opmerking 
)  as RG_DC_dierlijst_excel ON RG_DC_proeflijstdierlijst.AnimalServerID = RG_DC_dierlijst_excel.[Server ID]
left join VL_Dier_Datum_Crv on VL_Dier_Datum_Crv.AnimalServerID=RG_DC_proeflijstdierlijst.AnimalServerID and date=(select max(date) from VL_Dier_Datum_Crv)
left join tvl_dier_datum_stal on tvl_dier_datum_stal.dienum = RG_DC_proeflijstdierlijst.AnimalServerID and tvl_dier_datum_stal.dat = cast(dateadd(dd, -1, getdate()) as date)
left join TVL_Dier_Melkgift_Etmaal_Melkcontrole on TVL_Dier_Melkgift_Etmaal_Melkcontrole.dienum = RG_DC_proeflijstdierlijst.AnimalServerID and TVL_Dier_Melkgift_Etmaal_Melkcontrole.dat = cast(dateadd(dd, -1, getdate()) as date)
-- voorwaarde melkgift 
---- gemiddeld (minimaal 7 dagen, 
---- 2 giften per dag)
left join (
    select dienum, avg(KgMlkEtm) as mlk 
    from TVL_Dier_Melkgift_Etmaal_Melkcontrole 
    where AntMlkA>0 and AntMlkO>0 
    and dat > dateadd(dd, -8, getdate()) 
    group by dienum 
    having count(distinct dat)>6
) as mlk on mlk.dienum= RG_DC_proeflijstdierlijst.AnimalServerID 
-- voorwaarde 
---- niet meer dan 50k afwijking van weekgemiddelde
---- minimaal 7 weegdagen
left join (
    select  
        animalserverid , 
        sum(weight)/count(*) as gew 
    from 
        t_animal_animalweighings 
    where abs(t_animal_animalweighings.Weight-(
            select 
                sum(sub.weight)/count(*)  
            from 
                t_animal_animalweighings  as sub 
            where 
                sub.animalserverid=t_animal_animalweighings.animalserverid 
            and 
            WeighDateDT > dateadd(dd, -28, getdate())
        )) < 50
    AND
        WeighDateDT > dateadd(dd, -28, getdate())
    group by animalserverid
    having count(distinct cast(WeighDateDT as date)) > 1
) as gewichten  on gewichten.animalserverid= RG_DC_proeflijstdierlijst.AnimalServerID 
-- where   RG_DC_proeflijstdierlijst.AnimalServerID=12951
