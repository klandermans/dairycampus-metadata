CREATE VIEW dbo.VT_Gea_MelkAantalMisA
AS
SELECT        TOP (100) PERCENT Dat.Dat, COUNT(Mlk.DieNum) AS AntMlkA
FROM            dbo.TVL_Dier_Melkgift_Etmaal_Melkcontrole AS Mlk RIGHT OUTER JOIN
                         dbo.T_Datum AS Dat ON Mlk.Dat = Dat.Dat
WHERE        (Mlk.KgMlkA IS NULL) AND (Dat.Dat BETWEEN '1-jan-2017' AND GETDATE())
GROUP BY Dat.Dat
