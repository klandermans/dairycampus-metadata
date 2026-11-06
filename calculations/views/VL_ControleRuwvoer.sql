CREATE VIEW dbo.VL_ControleRuwvoer
AS
SELECT        P.PrfCod, P.PrfNam, P.BehCod, P.DieNum, P.OorNum, P.OorNumGet, dbo.VL_ControleRuwvoerAvg.CntOpn, dbo.VL_ControleRuwvoerAvg.AvgOpn, O.Dat, 
                         DATEDIFF(Day, GETDATE(), O.Dat) AS Dag, O.MngNam, O.Opn, O.AntBez
FROM            dbo.VL_Proef_Dier AS P INNER JOIN
                         dbo.VL_RIC_Dier_Opname_Mengsel AS O ON P.DieNum = O.DieNum INNER JOIN
                         dbo.VL_ControleRuwvoerAvg ON O.DieNum = dbo.VL_ControleRuwvoerAvg.DieNum AND O.MngNam = dbo.VL_ControleRuwvoerAvg.MngNam
WHERE        (O.Dat BETWEEN P.BegDat AND ISNULL(P.EndDat, GETDATE())) AND (O.Dat > GETDATE() - 8)
