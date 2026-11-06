CREATE VIEW [dbo].[VL_Dier_Gewicht_Week]
AS
SELECT        AnimalServerID AS DieNum, DATEPART(YY, WeighDateDT) AS Jaa, DATEPART(ISOWK, WeighDateDT) AS WeeNum, ROUND(AVG(Weight), 0) AS Gew
FROM            dbo.T_Animal_AnimalWeighings
WHERE        (dbo.GewDatOK(WeighDateDT) = 1)
GROUP BY AnimalServerID, DATEPART(YY, WeighDateDT), DATEPART(ISOWK, WeighDateDT)
