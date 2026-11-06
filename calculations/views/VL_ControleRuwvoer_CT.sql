CREATE VIEW [dbo].[VL_ControleRuwvoer_CT]
AS
SELECT        PrfCod, BehCod, DieNum, OorNum, OorNumGet, MngNam, CntOpn, AvgOpn, [-7], [-6], [-5], [-4], [-3], [-2], [-1]
FROM            (SELECT        PrfCod, BehCod, DieNum, OorNum, OorNumGet, MngNam, CntOpn, AvgOpn, Opn, Dag
                          FROM            VL_ControleRuwvoer) AS P PIVOT (max(Opn) FOR Dag IN ([-7], [-6], [-5], [-4], [-3], [-2], [-1])) AS pvt
                          where prfcod<>'4400003406'

