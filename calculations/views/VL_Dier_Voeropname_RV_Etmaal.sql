CREATE VIEW [dbo].[VL_Dier_Voeropname_RV_Etmaal]
AS

SELECT        
    Dat, 
    DieNum, 
    SUM(OpnDSTri) AS SumOpnDSTri, 
    SUM(OpnDSGem) AS SumOPnDSGem, 
    SUM(OpnDS) AS SumOpnDS
FROM
    dbo.VL_Dier_Voeropname_RV
GROUP BY 
    Dat, 
    DieNum

