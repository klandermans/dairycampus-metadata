CREATE VIEW dbo.VL_Dier_Analyse_Melk_Proef
AS
SELECT        AP.Dat, AP.DieNum, AP.VlgNum, AM.Tyd1, dbo.OchtendAvond(AM.Tyd1) AS OA1, AM.MlkGft1, AM.Tyd2, dbo.OchtendAvond(AM.Tyd2) AS OA2, AM.MlkGft2, 
                         ROUND(AM.MlkGft1 + AM.MlkGft2, 1) AS MlkGftEtm, AP.Vet, AP.Eiwit, AP.Lactose, AP.Ureum, AP.Celgetal
FROM            dbo.VL_Dier_Analyse_Melkgift2 AS AM RIGHT OUTER JOIN
                         dbo.VL_Dier_Analyse_Parameter_CT AS AP ON AM.DieNum = AP.DieNum AND AM.Dat = AP.Dat AND AM.MedCod = AP.MedCod AND AM.VlgNum = AP.VlgNum
