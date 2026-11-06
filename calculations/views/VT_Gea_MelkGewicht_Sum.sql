CREATE VIEW dbo.VT_Gea_MelkGewicht_Sum
AS
SELECT        TOP (100) PERCENT PrfCod, OorNum, DieNum, Status, COUNT(Dat) AS AntDat, ROUND(COUNT(Dat) * 1.0 / 7, 1) AS AntWek, SUM(Isnull(AntMlkO, 0)) 
                         + SUM(isnull(AntMlkA, 0)) AS AntMlkTot, SUM(isnull(AntGewO, 0)) + SUM(isnull(AntGewA, 0)) AS AntGewTot, iif(Status = 'Melk', count(dat) * 2 - (SUM(Isnull(AntMlkO, 0)) 
                         + SUM(isnull(AntMlkA, 0))), 0) AS AntMlkMis, IIF(Status = 'Melk', count(dat) * 2 - (SUM(isnull(AntGewO, 0)) + SUM(isnull(AntGewA, 0))), ROUND(COUNT(Dat) * 1.0 / 7, 1) 
                         - (SUM(isnull(AntGewO, 0)) + SUM(isnull(AntGewA, 0)))) AS AntGewMis
FROM            dbo.VT_Gea_MelkGewicht
GROUP BY PrfCod, OorNum, DieNum, Status
