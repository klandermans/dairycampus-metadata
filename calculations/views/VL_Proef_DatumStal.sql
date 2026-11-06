CREATE VIEW dbo.VL_Proef_DatumStal
AS
SELECT        TOP (100) PERCENT DDP.PrfCod, DDP.Dat, DDS.Hok, COUNT(DDS.DieNum) AS AntPrfDie
FROM            dbo.TVL_Dier_Datum_Proef AS DDP INNER JOIN
                         dbo.TVL_Dier_Datum_Stal AS DDS ON DDP.Dat = DDS.Dat AND DDP.DieNum = DDS.DieNum
GROUP BY DDP.PrfCod, DDP.Dat, DDS.Hok
HAVING        (DDP.PrfCod = '4400001506')
ORDER BY DDP.Dat, DDS.Hok
