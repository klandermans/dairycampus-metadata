CREATE VIEW dbo.VL_Dier_Datum_Proef_Toekomst
AS
SELECT        D.Dat, dbo.EU_JAAR(D.Dat) AS Jar, dbo.EU_WEEK(D.Dat) AS Wek, dbo.DagNam(DATEPART(dw, D.Dat)) AS WekDag, P.PrfCod, P.BehCod, P.HrhNum, P.Blk, 
                         P.DieNum, dbo.T_Animals.RegistrationId AS LevNum, L.OorNum, L.OorNumGet, P.BegDat AS BegDatPrf, dbo.T_Animals.BirthDateDT AS GebDat, DATEDIFF(day, 
                         dbo.T_Animals.BirthDateDT, D.Dat) AS LftDgn, L.LacNum, L.KlfDat, DATEDIFF(day, L.KlfDat, D.Dat) AS LacDgn, L.InsDat, L.DrgZetDat, L.VrwKlfDat, DATEDIFF(day, 
                         D.Dat, L.VrwKlfDat) AS VrwDgn
FROM            dbo.T_Proef_Dier AS P INNER JOIN
                         dbo.T_Animals ON P.DieNum = dbo.T_Animals.AnimalServerID INNER JOIN
                         dbo.VL_Dier_Lactatie AS L ON P.DieNum = L.DieNum INNER JOIN
                         dbo.VL_LaatsteAfkalving ON L.DieNum = dbo.VL_LaatsteAfkalving.AnimalServerID AND L.KlfDat = dbo.VL_LaatsteAfkalving.MaxCalvingDateDT CROSS JOIN
                         dbo.T_Datum AS D
WHERE        (D.Dat BETWEEN GETDATE() - 3 AND GETDATE() + 365) AND (D.Dat BETWEEN P.BegDat AND ISNULL(P.EndDat, GETDATE() + 365))
