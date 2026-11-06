CREATE VIEW dbo.VL_Dier_Analyse_Melkgift2
AS
SELECT        M1.DieNum, M1.Dat, M1.MedCod, M1.VlgNum, Format(M1.DatTyd, 'HH:mm') AS Tyd1, M1.MlkGft AS MlkGft1, Format(M2.DatTyd, 'HH:mm') AS Tyd2, 
                         M2.MlkGft AS MlkGft2, ISNULL(M1.MlkGft, 0) + ISNULL(M2.MlkGft, 0) AS MlkGftSom, ISNULL(SIGN(M1.MlkGft), 0) + ISNULL(SIGN(M2.MlkGft), 0) AS MlkGftAnt
FROM            dbo.T_Dier_Analyse_Melkgift AS M1 INNER JOIN
                         dbo.T_Dier_Analyse_Melkgift AS M2 ON M1.DieNum = M2.DieNum AND M1.Dat = M2.Dat AND M1.MedCod = M2.MedCod AND M1.VlgNum = M2.VlgNum AND 
                         M1.DatTyd < M2.DatTyd
