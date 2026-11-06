CREATE VIEW dbo.VL_Dier_Melkgift_Avond
AS
SELECT        AnimalServerID AS DieNum, AnimalNo AS OorNum, CAST(AnimalNo AS int) AS OorNumGet, MilkingDateDT AS MlkDat, COUNT(MilkQuantityMass) AS MlkCnt, 
                         ROUND(SUM(MilkQuantityMass), 1) AS KgMlk
FROM            dbo.TB_Animal_Milkings
WHERE        (MilkingTime >= CAST('12:00' AS Time))
GROUP BY AnimalServerID, AnimalNo, MilkingDateDT
