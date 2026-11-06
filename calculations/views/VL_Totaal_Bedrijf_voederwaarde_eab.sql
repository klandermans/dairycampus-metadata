-- SET ANSI_NULLS ON
-- GO
-- SET QUOTED_IDENTIFIER ON
-- GO
CREATE view [dbo].[VL_Totaal_Bedrijf_voederwaarde_eab] as 
SELECT  
    [DATE], 
    [filename], 
    INGREDIENTNAME, 
    TRIOLIET, 
    voederwaardes.*
FROM (
        SELECT 
            * 
        from 
            T_RAW_TRIOLIET
        WHERE 
            [date]>'2026-01-01') as T_RAW_TRIOLIET 
LEFT JOIN 
    T_PROEF_JOINS ON TRIOLIET=INGREDIENTNAME
LEFT JOIN (
    SELECT 
        A203820ArtikelOmschrijving as information,
        A702164BonDatum as dat,
        -- Get the bondatum of the next row for the same article
        LEAD(A702164BonDatum) OVER (
            PARTITION BY A203820ArtikelOmschrijving 
            ORDER BY A702164BonDatum ASC
        ) AS volgende, 
        
        -- -  VEM, DVE, OEB, zetmeel, NDF, suiker, Ruw eiwit, ruw eiwit-totaal, P, N-totaal, CFP, EF-CH4
        -- -  VEM-2022:
        [A205806Nutrient-vem] as VEM, 
        [A703335Nutrient-VEM2022] as VEM2022,
        [A205807Nutrient-DVE] as DVE, 
        [A205808Nutrient-OEB] as OEB, 
        [A703305Nutrient-Zetmeel] as zetmeel,
        [A703304Nutrient-NDF]     as NDF,
        [A703325Nutrient-Suiker] as suiker,
        [A702809Nutrient-RE] as [Ruw eiwit],  -- nutrient re =  ruw eiwit
        [A702809Nutrient-RE] as [ruw eiwit-totaal], -- nutrient re =  ruw eiwit bij lor is het niet hetzelfde
        [A204586Nutrient-P] as P,
        [A204585Nutrient-N] as [N-totaal], -- nutrient n = totaal
        [A703310Nutrient-CO2EmOffFarm] as [CFP], -- co2 of farm
        [A703306Nutrient-EF00ProcSnijmais] + [A703307Nutrient-EF40ProcSnijmais] as [EF-CH4], -- ef0 ef80   dit zijn twee colommen EF00 EF40 snijmais hier moet nog iets voor berekend worden. zie views van Jan.     
        [A205802Nutrient-DS] as DS
        
    FROM 
        T_RAW_eab_Leveringen_SegmentEigenschapRegel
    UNION ALL

    SELECT   
        Information, 
        T_PraktijkNetwerk_lor_SpecifiedSampleObservationResult.issuedatetime as dat ,
        getdate() as volgende,  -- dit is niet goed
        avg(iif(parametervalue='VEM',measuredvaluemeasure    , null)) as VEM, -- heb ik als gemiddelde gedaan is dat goed? TODO Controleren!!
        avg(iif(parametervalue='VEM-2022',measuredvaluemeasure    , null))  as [VEM-2022],        
        avg(iif(parametervalue='DVE',measuredvaluemeasure    , null)) as DVE, -- heb ik als gemiddelde gedaan is dat goed?
        avg(iif(parametervalue='OEB',measuredvaluemeasure    , null))  as OEB,
        avg(iif(parametervalue='zetmeel',measuredvaluemeasure    , null))  as zetmeel,
        avg(iif(parametervalue='NDF',measuredvaluemeasure    , null))  as NDF,
        avg(iif(parametervalue='suiker',measuredvaluemeasure    , null))  as suiker,
        avg(iif(parametervalue='Ruw eiwit',measuredvaluemeasure    , null))  as [Ruw eiwit],
        avg(iif(parametervalue='Ruw eiwit totaal',measuredvaluemeasure    , null))  as [Ruw eiwit totaal],
        avg(iif(parametervalue='p',measuredvaluemeasure    , null))  as p,
        avg(iif(parametervalue='N-totaal',measuredvaluemeasure    , null))  as [N-totaal],
        avg(iif(parametervalue='CFP',measuredvaluemeasure    , null))  as CFP,
        avg(iif(parametervalue='EF-CH4',measuredvaluemeasure    , null))  as [EF-CH4],        
        avg(iif(parametervalue='DS',measuredvaluemeasure    , null))  as [VEM-2022]



    from  
        T_PraktijkNetwerk_lor_AgriculturalSample
    LEFT JOIN
        T_PraktijkNetwerk_lor_SpecifiedSampleObservationResult 
    on T_PraktijkNetwerk_lor_AgriculturalSample.LORExchangedDocument_id=T_PraktijkNetwerk_lor_SpecifiedSampleObservationResult.LORExchangedDocument_id
    
    GROUP BY 
        information,T_PraktijkNetwerk_lor_SpecifiedSampleObservationResult.issuedatetime

) AS voederwaardes ON (information=EAB  or information=lor) and dat<=date and volgende>date

WHERE 
    [filename] IS NOT NULL and ingredientname <> ''
    AND
    T_RAW_TRIOLIET.date>'2026-01-01'



