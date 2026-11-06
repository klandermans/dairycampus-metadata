CREATE VIEW dbo.VT_Gea_Gewicht
AS
SELECT        dbo.TVL_Dier_Datum_Proef.Dat, dbo.TVL_Dier_Datum_Proef.WekDag, dbo.TVL_Dier_Datum_Proef.PrfCod, dbo.TVL_Dier_Datum_Proef.OorNumGet, 
                         dbo.TVL_Dier_Gewicht_Etmaal.GewO, dbo.TVL_Dier_Gewicht_Etmaal.GewA, dbo.TVL_Dier_Datum_Proef.PrdSta
FROM            dbo.TVL_Dier_Datum_Proef LEFT OUTER JOIN
                         dbo.TVL_Dier_Gewicht_Etmaal ON dbo.TVL_Dier_Datum_Proef.Dat = dbo.TVL_Dier_Gewicht_Etmaal.Dat AND 
                         dbo.TVL_Dier_Datum_Proef.DieNum = dbo.TVL_Dier_Gewicht_Etmaal.DieNum
WHERE        (dbo.TVL_Dier_Datum_Proef.PrfCod = '4400001506')
