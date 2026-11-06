CREATE VIEW dbo.VT_Gea_MelkGewicht_SumWek
AS
SELECT        PrfCod, Jar, Wek, OorNum, DieNum, Status, COUNT(Dat) AS AntDieDat, cast(ROUND(COUNT(Dat) * 1.0 / 7, 1) AS real) AS AntWek, SUM(Isnull(AntMlkO, 0)) 
                         + SUM(isnull(AntMlkA, 0)) AS AntMlkTot, SUM(isnull(AntGewO, 0)) + SUM(isnull(AntGewA, 0)) AS AntGewTot, iif(Status = 'Melk', count(dat) * 2 - (SUM(Isnull(AntMlkO, 0)) 
                         + SUM(isnull(AntMlkA, 0))), 0) AS AntMlkMis, IIF(Status = 'Melk', count(dat) * 2 - (SUM(isnull(AntGewO, 0)) + SUM(isnull(AntGewA, 0))), cast(ROUND(COUNT(Dat) * 1.0 / 7, 
                         1) AS real) - (SUM(isnull(AntGewO, 0)) + SUM(isnull(AntGewA, 0)))) AS AntGewMis
FROM            dbo.VT_Gea_MelkGewicht
GROUP BY PrfCod, Jar, Wek, OorNum, DieNum, Status
