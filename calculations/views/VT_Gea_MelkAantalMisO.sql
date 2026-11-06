CREATE VIEW dbo.VT_Gea_MelkAantalMisO
AS
SELECT        TOP (100) PERCENT dbo.T_Datum.Dat, COUNT(dbo.TVL_Dier_Melkgift_Etmaal_Melkcontrole.DieNum) AS AntMlkO
FROM            dbo.TVL_Dier_Melkgift_Etmaal_Melkcontrole RIGHT OUTER JOIN
                         dbo.T_Datum ON dbo.TVL_Dier_Melkgift_Etmaal_Melkcontrole.Dat = dbo.T_Datum.Dat
WHERE        (dbo.TVL_Dier_Melkgift_Etmaal_Melkcontrole.KgMlkO IS NULL) AND (dbo.T_Datum.Dat BETWEEN '1-jan-2017' AND GETDATE())
GROUP BY dbo.T_Datum.Dat
