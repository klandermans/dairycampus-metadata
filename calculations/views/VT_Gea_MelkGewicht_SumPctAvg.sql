CREATE VIEW [dbo].[VT_Gea_MelkGewicht_SumPctAvg]
AS
SELECT        
    PrfCod, 
    Status, 
    COUNT(OorNum) AS AntDie, SUM(AntDat) AS AntDat, cast(round(SUM(AntDat * 1.0) / 7, 1) AS real) AS AntWek, 
    SUM(AntMlkTot) AS AntMlkTot, 
    SUM(AntGewTot) AS AntGewTot, 
    iif(Status = 'Melk', SUM(AntDat) * 2 - sum(antmlktot), 0) AS AntMlkMis, 
    iif(Status = 'Melk', SUM(AntDat) * 2 - SUM(AntGewTot), 
    cast(Round(SUM(AntDat * 1.0) / 7, 1) - sum(antGewTot) as real) ) AS AntGewMis, 
    cast(round(iif(Status = 'Melk', (SUM(AntDat * 1.0) * 2 - sum(antmlktot * 1.0)) / sum(antDat * 2.0), 0) * 100, 2) as real) AS PctMlkMis, 
    cast(round(iif(Status = 'Melk', (SUM(AntDat * 1.0) * 2 - sum(antgewtot * 1.0)) / sum(antDat * 2.0), (SUM(AntDat * 1.0) / 7 - sum(antGewTot)) / (SUM(AntDat * 1.0) / 7)) * 100, 2) as real) AS PctGewMis
FROM            
    dbo.VT_Gea_MelkGewicht_SumPct
GROUP BY PrfCod, Status

