CREATE VIEW dbo.VT_Gea_MelkAantalMis
AS
SELECT        TOP (100) PERCENT Dat.Dat, MlkO.AntMlkO, MlkA.AntMlkA
FROM            dbo.VT_Gea_MelkAantalMisO AS MlkO RIGHT OUTER JOIN
                         dbo.T_Datum AS Dat ON MlkO.Dat = Dat.Dat LEFT OUTER JOIN
                         dbo.VT_Gea_MelkAantalMisA AS MlkA ON Dat.Dat = MlkA.Dat
WHERE        (Dat.Dat BETWEEN '1-jan-2017' AND GETDATE())
