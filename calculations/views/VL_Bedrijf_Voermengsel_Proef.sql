CREATE VIEW dbo.VL_Bedrijf_Voermengsel_Proef
AS
SELECT DISTINCT P.PrfCod, Trio.MngNam, Trio.PrtNam
FROM            dbo.TVL_Dier_Datum_Proef AS P INNER JOIN
                         dbo.TVL_Dier_Voeropname_RV AS Opn ON P.Dat = Opn.Dat INNER JOIN
                         dbo.TVL_Trioliet_Laad_DatPrt AS Trio ON Opn.MngNam = Trio.MngNam AND Opn.Dat = Trio.Dat
