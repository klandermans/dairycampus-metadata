CREATE VIEW [dbo].[VL_ControleGewichtAvg]
AS
SELECT        
    AnimalServerID, AnimalNo, 
    dbo.OchtendAvond(WeighDateDT) AS DagDeel,     
    CAST(AVG(Weight) AS int) AS Weight
FROM            
    dbo.T_Animal_AnimalWeighings
WHERE        
    (WeighDateDT > GETDATE() - 8)
GROUP BY AnimalServerID, AnimalNo, dbo.OchtendAvond(WeighDateDT)


