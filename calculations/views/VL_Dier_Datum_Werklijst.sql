CREATE VIEW dbo.VL_Dier_Datum_Werklijst
AS
SELECT        Toe.Dat, Toe.Jar, Toe.Wek, Toe.WekDag, Toe.PrfCod, Prf.PrfNam, Toe.BehCod, Toe.HrhNum, Toe.Blk, Toe.DieNum, Toe.LevNum, Toe.OorNum, Toe.OorNumGet, 
                         Toe.BegDatPrf, Toe.GebDat, Toe.LftDgn, Toe.LacNum, Toe.KlfDat, Toe.LacDgn, Toe.InsDat, Toe.DrgZetDat, Toe.VrwKlfDat, Toe.VrwDgn, 
                         dbo.VL_Dier_Datum_Stal_Vandaag.Hok
FROM            dbo.VL_Dier_Datum_Proef_Toekomst AS Toe INNER JOIN
                         dbo.T_Proef AS Prf ON Toe.PrfCod = Prf.PrfCod LEFT OUTER JOIN
                         dbo.VL_Dier_Datum_Stal_Vandaag ON Toe.DieNum = dbo.VL_Dier_Datum_Stal_Vandaag.DieNum
WHERE        (Toe.Dat < GETDATE() + 14)
