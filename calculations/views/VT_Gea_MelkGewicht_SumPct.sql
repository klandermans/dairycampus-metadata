CREATE VIEW dbo.VT_Gea_MelkGewicht_SumPct
AS
SELECT        PrfCod, OorNum, DieNum, Status, AntDat, AntWek, AntMlkTot, AntGewTot, AntMlkMis, AntGewMis, cast(Round(iif(status = 'Melk', (AntMlkMis * 1.0) / (AntDat * 2), 0) 
                         * 100, 0) AS int) AS PctMlkMis, cast(Round(iif(status = 'Melk', (AntGewMis * 1.0) / (AntDat * 2), (AntGewMis * 1.0) / AntWek) * 100, 0) AS int) AS PctGewMis
FROM            dbo.VT_Gea_MelkGewicht_Sum
