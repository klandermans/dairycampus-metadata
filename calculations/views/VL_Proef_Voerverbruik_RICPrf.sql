CREATE VIEW dbo.VL_Proef_Voerverbruik_RICPrf
AS
SELECT        TOP (100) PERCENT OpnRV.PrtNam, dbo.EU_JAAR(OpnRV.Dat) AS Jar, dbo.EU_WEEK(OpnRV.Dat) AS Wek, COUNT(OpnRV.DieNum) AS DieDag, SUM(OpnRV.OpnDS) 
                         AS OpnDS, ISNULL(DDP.PrfCod, 'Geen proef') AS PrfCod
FROM            dbo.TVL_Dier_Datum_Proef AS DDP RIGHT OUTER JOIN
                         dbo.TVL_Dier_Voeropname_RV AS OpnRV ON DDP.Dat = OpnRV.Dat AND DDP.DieNum = OpnRV.DieNum
WHERE        (OpnRV.PrtNam IS NOT NULL)
GROUP BY DDP.PrfCod, dbo.EU_JAAR(OpnRV.Dat), dbo.EU_WEEK(OpnRV.Dat), OpnRV.PrtNam
