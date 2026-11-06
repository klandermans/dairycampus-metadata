CREATE VIEW dbo.VL_Dier_Voeropname_RV_Week
AS
SELECT        DieNum, DATEPART(YY, Dat) AS Jaa, DATEPART(ISOWK, Dat) AS WeeNum, ROUND(AVG(SumOpnDS), 2) AS OpnDS
FROM            dbo.VL_Dier_Voeropname_RV_Etmaal
WHERE        (dbo.RVDatOK(Dat) = 1)
GROUP BY DieNum, DATEPART(YY, Dat), DATEPART(ISOWK, Dat)
