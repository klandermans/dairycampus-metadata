CREATE VIEW dbo.VT_Gea_MelkGewicht_SumWekPct
AS
SELECT        PrfCod, Jar, Wek, OorNum, DieNum, Status, AntDieDat, round(AntWek, 1) AS AntWek, AntMlkTot, AntGewTot, AntMlkMis, AntGewMis, cast(Round(iif(status = 'Melk', 
                         (AntMlkMis * 1.0) / (AntDieDat * 2), 0) * 100, 0) AS int) AS PctMlkMis, cast(Round(iif(status = 'Melk', (AntGewMis * 1.0) / (AntDieDat * 2), (AntGewMis * 1.0) / AntWek) * 100, 0) 
                         AS int) AS PctGewMis
FROM            dbo.VT_Gea_MelkGewicht_SumWek
