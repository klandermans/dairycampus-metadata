CREATE VIEW dbo.VL_Trioliet_LaadLos_SomPerDatMng
AS
SELECT        Batch.Dat, Batch.TydRea, Batch.TydPln, Batch.OpdID, Batch.MngNam, Laad.SumPrtKgRea, Los.SumMngKgRea, Los.CntBak
FROM            dbo.VL_Trioliet_Los_SomPerDatMng AS Los RIGHT OUTER JOIN
                         dbo.VL_Trioliet_Batch_AntPerDatMng AS Batch ON Los.OpdID = Batch.OpdID AND Los.Dat = Batch.Dat AND Los.MngNam = Batch.MngNam LEFT OUTER JOIN
                         dbo.VL_Trioliet_Laad_SomPerDatMng AS Laad ON Batch.OpdID = Laad.OpdID AND Batch.Dat = Laad.Dat AND Batch.MngNam = Laad.MngNam
