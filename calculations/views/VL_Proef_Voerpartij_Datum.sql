CREATE VIEW [dbo].[VL_Proef_Voerpartij_Datum]
AS
SELECT 
    D.Dat, V.PrfCod, V.BehCod, V.DieNum, V.PrcComCod, V.KvrNum, V.PrtNam, V.BegDat, V.EinDat
FROM dbo.T_Datum AS D 
CROSS JOIN dbo.VL_Proef_Voerpartij AS V
WHERE        (D.Dat BETWEEN V.BegDat AND V.EinDat)

