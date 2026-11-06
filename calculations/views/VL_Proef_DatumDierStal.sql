CREATE VIEW dbo.VL_Proef_DatumDierStal
AS
SELECT        DDS.Dat, DDS.Hok, DDS.DieNum, DDS.OorNumGet, DDP.PrfCod, KV.PrcCom, KV.VoeNum, KV.VoeGft, KV.VoeRst, KV.PrtNam
FROM            dbo.TVL_Dier_Voeropname_KV AS KV RIGHT OUTER JOIN
                         dbo.TVL_Dier_Datum_Stal AS DDS ON KV.DieNum = DDS.DieNum AND KV.Dat = DDS.Dat LEFT OUTER JOIN
                         dbo.TVL_Dier_Datum_Proef AS DDP ON DDS.Dat = DDP.Dat AND DDS.DieNum = DDP.DieNum
