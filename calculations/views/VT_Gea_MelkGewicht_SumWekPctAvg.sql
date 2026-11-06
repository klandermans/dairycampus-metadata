CREATE VIEW dbo.VT_Gea_MelkGewicht_SumWekPctAvg
AS
SELECT        PrfCod, Jar, Wek, Status, COUNT(OorNum) AS AntDie, SUM(AntDieDat) AS AntDieDat, ROUND(SUM(AntWek), 1) AS AntWek, SUM(AntMlkTot) AS AntMlkTot, SUM(AntGewTot) 
                         AS AntGewTot, ROUND(SUM(AntMlkMis), 1) AS AntMlkMis, ROUND(SUM(AntGewMis), 1) AS AntGewMis, cast(Round(iif(Status = 'Melk', (Sum(AntMlkMis) * 1.0) 
                         / (sum(AntDieDat) * 2.0), 0) * 100, 0) AS real) AS PctMlkMis, cast(Round(iif(Status = 'Melk', (Sum(AntGewMis) * 1.0) / (sum(AntDieDat) * 2.0), (Sum(AntGewMis) * 1.0) 
                         / SUM(AntWek)) * 100, 0) AS real) AS PctGewMis
FROM            dbo.VT_Gea_MelkGewicht_SumWekPct
GROUP BY PrfCod, Status, Jar, Wek
