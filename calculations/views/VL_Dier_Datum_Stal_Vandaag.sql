CREATE VIEW dbo.VL_Dier_Datum_Stal_Vandaag
AS
SELECT        Dat, Jar, Wek, WekDag, Stl, Hok, DieNum, LevNum, OorNum, OorNumGet, BegDat, EndDat, GebDat, LftDgn, LacNum, KlfDat, LacDgn, InsDat, DrgZetDat, VrwKlfDat, 
                         VrwDgn, PrdSta, MlkNOK, KVNOK, RVNOK, GewNOK, RowID
FROM            dbo.TVL_Dier_Datum_Stal
WHERE        (Dat = datefromparts(DATEPART(yyyy, GETDATE()), DATEPART(mm, GETDATE()), DATEPART(dd, GETDATE())))
