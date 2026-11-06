CREATE VIEW dbo.VT_Gea_MelkAantal
AS
SELECT        TOP (100) PERCENT Dat.Dat, iif(COUNT(Mlk.KgMlkO) > COUNT(Mlk.KgMlkA), COUNT(Mlk.KgMlkO) , COUNT(Mlk.KgMlkA)) As AntDie  ,  COUNT(Mlk.KgMlkO) AS AntDieO, SUM(Mlk.AntMlkO) AS AntMlkO, MlkMis.AntMlkO AS AntMlkMisO, COUNT(Mlk.KgMlkA) AS AntDieA, 
                         SUM(Mlk.AntMlkA) AS AntMlkA, MlkMis.AntMlkA AS AntMlkMisA
FROM            dbo.VT_Gea_MelkAantalMis AS MlkMis RIGHT OUTER JOIN
                         dbo.T_Datum AS Dat ON MlkMis.Dat = Dat.Dat LEFT OUTER JOIN
                         dbo.TVL_Dier_Melkgift_Etmaal_Melkcontrole AS Mlk ON Dat.Dat = Mlk.Dat
WHERE        (Dat.Dat BETWEEN CONVERT(DATETIME, '2017-01-01 00:00:00', 102) AND GETDATE())
GROUP BY Dat.Dat, MlkMis.AntMlkO, MlkMis.AntMlkA
