CREATE VIEW dbo.VL_LaatsteMilkSampleRolling
AS
SELECT        AnimalServerID, AnimalNo, MAX(RollingDateDT) AS MaxRollingDateDT, MAX(AnimalMilkSampleRollingID) AS MaxAnimalMilkSampleRollingID
FROM            dbo.T_Animal_MilkSampleRollings
GROUP BY AnimalServerID, AnimalNo
