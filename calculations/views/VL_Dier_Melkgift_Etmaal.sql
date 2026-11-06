CREATE VIEW [dbo].[VL_Dier_Melkgift_Etmaal]
AS
SELECT        
    MO.DieNum, MO.MlkDat AS Dat, 
    MO.MlkCnt AS AntMlkO, 
    MO.KgMlk AS KgMlkO, 
    MA.MlkCnt AS AntMlkA, 
    MA.KgMlk AS KgMlkA, 
    Round(MO.KgMlk + MA.KgMlk, 1)   AS KgMlkEtm
FROM dbo.VL_Dier_Melkgift_Ochtend AS MO 
LEFT OUTER JOIN dbo.VL_Dier_Melkgift_Avond AS MA ON MO.MlkDat = MA.MlkDat AND MO.DieNum = MA.DieNum
UNION
SELECT        
    MA.DieNum, 
    MA.MlkDat, 
    MO.MlkCnt, 
    MO.KgMlk AS KgMlkO, 
    MA.MlkCnt, 
    MA.KgMlk AS KgMlkA, 
    Round(MO.KgMlk + MA.KgMlk, 1)
FROM  dbo.VL_Dier_Melkgift_Ochtend AS MO 
RIGHT OUTER JOIN dbo.VL_Dier_Melkgift_Avond AS MA ON MO.MlkDat = MA.MlkDat AND MO.DieNum = MA.DieNum

