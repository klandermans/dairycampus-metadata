CREATE VIEW [dbo].[VL_ControleMelkgiftAvg]
AS
SELECT        
    AnimalServerID, AnimalNo, 
    dbo.OchtendAvond(MilkingTime) AS DagDeel, 
    AVG(MilkQuantityMass) AS AvgMilkQuantityMass
FROM            
    dbo.T_Animal_Milkings
WHERE        
    (MilkingDateDT > GETDATE() - 8)
GROUP BY AnimalServerID, dbo.OchtendAvond(MilkingTime), AnimalNo


