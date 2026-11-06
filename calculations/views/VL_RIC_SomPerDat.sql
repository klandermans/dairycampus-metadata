CREATE VIEW [dbo].[VL_RIC_SomPerDat]
AS
/**
 * Deze view wordt gebriukt in het ric voeropnamen formulier in access 
 */
SELECT        
    CAST(DatumsTerug_1.Dat AS datetime) AS Dat, 
    COUNT(DISTINCT dbo.T_Dier_Voeropname_Mengsel.DieNum) AS CntDie, 
    ROUND(SUM(dbo.T_Dier_Voeropname_Mengsel.Opn), 0) AS SumOpn, 
    SUM(dbo.T_Dier_Voeropname_Mengsel.AntBez) AS SumAntBez, 
    dbo.UrenMinutenSeconden(SUM(dbo.T_Dier_Voeropname_Mengsel.TydBez)) AS SumTydBez
FROM            
    dbo.T_Dier_Voeropname_Mengsel 
RIGHT OUTER JOIN
    dbo.DatumsTerug(50) AS DatumsTerug_1 ON dbo.T_Dier_Voeropname_Mengsel.Dat = DatumsTerug_1.Dat
GROUP BY DatumsTerug_1.Dat


