-- SET ANSI_NULLS ON
-- GO
-- SET QUOTED_IDENTIFIER ON
-- GO

CREATE view [dbo].[VL_Totaal_Bedrijf_voederwaarde_eab_dier]  as 
select  
    distinct
    p.dat, 
    cow as oornum,  
    p.ingredientname, 
    v.dat as [start], 
    volgende, 

    [TotOpnDag] ,
 
    [OpnKgProd],
    [OpnDsProd],
        [vem]
      ,[dve]
      ,[oeb]
      ,[zetmeel]
      ,[NDF]
      ,[suiker]
      ,[Ruw eiwit]
      ,[ruw eiwit-totaal]
      ,[P]
      ,[N-totaal]
      ,[CFP]
      ,[EF-CH4]
      ,[VEM2022]
      ,[DS]
FROM (
    SELECT
        * 
    FROM  
        TVL_Totaal_sub_ric_opn_prod 
    WHERE 
        [dat]>'2026-01-01'  AND cow=980 AND INGREDIENTNAME<>'Water' 
) as p

LEFT JOIN  (
    SELECT 
        * 
    FROM  
        VL_Totaal_Bedrijf_voederwaarde_eab 
    WHERE 
        [date]>'2026-01-01'
) AS v ON v.INGREDIENTNAME=p.ingredientname AND v.date=p.dat
WHERE 
    p.[dat] >= '2026-01-01' AND p.dat >='2026-01-01'

    and p.dat='2026-09-10'