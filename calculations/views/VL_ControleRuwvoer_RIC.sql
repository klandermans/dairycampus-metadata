CREATE VIEW dbo.VL_ControleRuwvoer_RIC
AS
SELECT        'R' AS Grp, Dat, CntDie, SumOpn, SumAntBez, SumTydBez
FROM            dbo.VL_RIC_SomPerDat
WHERE        (Dat > GETDATE() - 8)
