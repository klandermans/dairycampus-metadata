CREATE VIEW [dbo].[VL_ControleGewicht]
AS
SELECT        
    P.PrfCod, P.BehCod, P.DieNum, RIGHT('0000' + CAST(W.AnimalNo AS varchar(4)), 4) AS OorNum, 
    CAST(W.AnimalNo AS int) AS OorNumGet, 
    W.WeighDateDT, 
                         dbo.OchtendAvond(W.WeighDateDT) AS OA, 
    CAST(W.Weight AS int) AS Weight, 
    O.Weight AS AvgO, 
    A.Weight AS AvgA, 
    CAST(DATEDIFF(day, W.WeighDateDT, GETDATE()) * - 1 AS varchar(2)) + dbo.OchtendAvond(W.WeighDateDT) AS DagOA
FROM            
    dbo.T_Animal_AnimalWeighings AS W 
INNER JOIN
    dbo.VL_ControleGewichtAvg AS O ON W.AnimalServerID = O.AnimalServerID 
INNER JOIN
    dbo.VL_ControleGewichtAvg AS A ON W.AnimalServerID = A.AnimalServerID 
INNER JOIN
    dbo.T_Proef_Dier AS P ON W.AnimalServerID = P.DieNum
WHERE      (O.DagDeel = 'O') AND (A.DagDeel = 'A') AND (W.WeighDateDT > GETDATE() - 8) AND (W.WeighDateDT BETWEEN P.BegDat AND ISNULL(P.EndDat, GETDATE()))

