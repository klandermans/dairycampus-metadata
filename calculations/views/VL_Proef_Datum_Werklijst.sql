CREATE VIEW dbo.VL_Proef_Datum_Werklijst
AS
SELECT        D.Dat, D.Jar, D.Wek, D.WekDag, P.PrfCod, P.PrfNam, P.BegDat, P.EndDat
FROM            dbo.T_Proef AS P CROSS JOIN
                         dbo.VL_Datum_Werklijst1 AS D
WHERE        (P.EndDat IS NULL) OR
                         (P.EndDat >= D.Dat)
