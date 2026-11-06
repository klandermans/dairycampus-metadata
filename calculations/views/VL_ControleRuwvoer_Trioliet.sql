CREATE VIEW dbo.VL_ControleRuwvoer_Trioliet
AS
SELECT        'T' AS Grp, CAST(Dat AS datetime) AS Dat, CntBat, SumPrtKgRea, SumMngKgRea, CntBak
FROM            dbo.VL_Trioliet_LaadLos_SomPerDat
WHERE        (Dat > GETDATE() - 8)
