CREATE VIEW [dbo].[VL_ControleMelkgift]
AS
SELECT        
    P.PrfCod, P.BehCod, M.AnimalServerID AS DieNum, 
    RIGHT('0000' + CAST(M.AnimalNo AS varchar(4)), 4) AS OorNum, 
    Try_Cast(M.AnimalNo AS int) AS OorNumGet, 
    O.AvgMilkQuantityMass AS AvgO, 
    A.AvgMilkQuantityMass AS AvgA, 
    M.MilkingDateDT, M.MilkingTime, 
    CAST(DATEDIFF(day, M.MilkingDateDT, GETDATE()) 
                         * - 1 AS varchar(2)) + dbo.OchtendAvond(M.MilkingTime) AS DagOA, M.MilkQuantityMass
FROM            
    dbo.T_Proef_Dier AS P 
INNER JOIN
    dbo.TB_Animal_Milkings AS M 
INNER JOIN
    dbo.VL_ControleMelkgiftAvg AS O ON M.AnimalServerID = O.AnimalServerID 
INNER JOIN
    dbo.VL_ControleMelkgiftAvg AS A ON M.AnimalServerID = A.AnimalServerID ON P.DieNum = M.AnimalServerID
WHERE        
    (O.DagDeel = 'O') AND (A.DagDeel = 'A') AND (M.MilkingDateDT > GETDATE() - 8) AND (M.MilkingDateDT BETWEEN P.BegDat AND ISNULL(P.EndDat, GETDATE()))


