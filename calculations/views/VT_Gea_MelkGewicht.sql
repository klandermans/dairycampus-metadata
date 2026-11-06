CREATE VIEW dbo.VT_Gea_MelkGewicht
AS
SELECT        TOP (100) PERCENT DP.PrfCod, DP.Jar, DP.Wek, DP.OorNum, DP.DieNum, DP.Dat, IIF(DP.KlfDat > DP.DrgZetDat OR
                         DP.DrgZetDat IS NULL, 'Melk', 'Droog') AS Status, DP.LacNum, Sign(ME.AntMlkO) AS AntMlkO, Sign(ME.AntMlkA) AS AntMlkA, Sign(GE.AntGewO) AS AntGewO, 
                         Sign(GE.AntGewA) AS AntGewA, DP.DrgZetDat, DP.VrwKlfDat, DP.KlfDat
FROM            dbo.TVL_Dier_Datum_Proef AS DP LEFT OUTER JOIN
                         dbo.VL_Dier_Gewicht_Etmaal AS GE ON DP.DieNum = GE.DieNum AND DP.Dat = GE.Dat LEFT OUTER JOIN
                         dbo.VL_Dier_Melkgift_Etmaal AS ME ON DP.DieNum = ME.DieNum AND DP.Dat = ME.Dat
WHERE        PrfCod IN ( '4400001506', '4400002021')
