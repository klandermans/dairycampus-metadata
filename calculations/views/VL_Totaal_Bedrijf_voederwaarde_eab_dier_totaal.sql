-- SET ANSI_NULLS ON
-- GO
-- SET QUOTED_IDENTIFIER ON
-- GO

CREATE view [dbo].[VL_Totaal_Bedrijf_voederwaarde_eab_dier_totaal]  as 
SELECT   
    Dat, 
    OorNum, 
    
    sum([OpnKgProd])                        AS OpnKgProd ,
    sum([OpnDsProd])                        AS OpnDsProd,
    SUM([vem] * [OpnDsProd])                AS [vem],
    SUM([dve] * [OpnDsProd])                AS [dve],
    SUM([oeb] * [OpnDsProd])                AS [oeb],
    SUM([zetmeel] * [OpnDsProd])            AS [zetmeel],
    SUM([NDF] * [OpnDsProd])                AS [NDF],
    SUM([suiker] * [OpnDsProd])             AS [suiker],
    SUM([Ruw eiwit] * [OpnDsProd])          AS [Ruw eiwit],
    SUM([ruw eiwit-totaal] * [OpnDsProd])   AS [ruw eiwit-totaal],
    SUM([P] * [OpnDsProd])                  AS [P],
    SUM([N-totaal] * [OpnDsProd])           AS [N-totaal],
    SUM([CFP] * [OpnDsProd])                AS [CFP],
    SUM([EF-CH4] * [OpnDsProd])             AS [EF-CH4],
    SUM([VEM2022] * [OpnDsProd])            AS [VEM2022]      
FROM 
    [dbo].[VL_Totaal_Bedrijf_voederwaarde_eab_dier] 
WHERE 
    [Dat]='2026-09-10' 
    
GROUP BY 
    Dat, 
    OorNum;

