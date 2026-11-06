CREATE VIEW [dbo].[VL_Proef_DatumDierStal_KV]
AS
SELECT        TOP (100) PERCENT DS.PrfCod, DS.Dat, DS.Hok, DS.AntPrfDie, DDS.DieNum, DDS.OorNumGet, DDS.PrfCod AS Expr1, DDS.PrcCom, DDS.VoeNum, DDS.VoeGft, 
                         DDS.VoeRst, DDS.PrtNam
FROM            dbo.VL_Proef_DatumStal AS DS LEFT OUTER JOIN
                         dbo.VL_Proef_DatumDierStal AS DDS ON DS.Hok = DDS.Hok AND DS.Dat = DDS.Dat
WHERE        (DS.PrfCod = '4400001506')
ORDER BY DS.Dat, DS.Hok
