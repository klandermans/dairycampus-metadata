CREATE VIEW dbo.VL_ControleRuwvoerAvg
AS
SELECT        DieNum, MngNam, COUNT(Opn) AS CntOpn, ROUND(AVG(Opn), 1) AS AvgOpn
FROM            dbo.VL_RIC_Dier_Opname_Mengsel
WHERE        (Dat > GETDATE() - 8)
GROUP BY DieNum, MngNam
