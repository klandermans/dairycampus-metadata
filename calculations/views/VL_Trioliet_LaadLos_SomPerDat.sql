CREATE VIEW dbo.VL_Trioliet_LaadLos_SomPerDat
AS
SELECT        DatumsTerug_1.Dat, Batch.CntBat, Laad.SumPrtKgRea, Los.SumMngKgRea, Los.CntBak
FROM            dbo.VL_Trioliet_Batch_AntPerDat AS Batch RIGHT OUTER JOIN
                         dbo.DatumsTerug(50) AS DatumsTerug_1 ON Batch.Dat = DatumsTerug_1.Dat LEFT OUTER JOIN
                         dbo.VL_Trioliet_Los_SomPerDat AS Los ON Batch.Dat = Los.Dat LEFT OUTER JOIN
                         dbo.VL_Trioliet_Laad_SomPerDat AS Laad ON Batch.Dat = Laad.Dat
