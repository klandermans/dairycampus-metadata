CREATE VIEW [dbo].[VL_Dier_Analyse_Melkgift2Parameter]
AS
SELECT        MA.DieNum, MA.Dat, MA.MedCod, MA.VlgNum, MG.MlkGftSom, MG.MlkGftAnt, MA.Vet, MA.Eiwit, MA.Lactose, MA.Ureum, MA.Celgetal
FROM            dbo.VL_Dier_Analyse_Melkgift2 AS MG 
RIGHT OUTER JOIN
                         dbo.VL_Dier_Analyse_Parameter_CT AS MA ON MG.DieNum = MA.DieNum AND MG.Dat = MA.Dat AND MG.MedCod = MA.MedCod AND MG.VlgNum = MA.VlgNum

