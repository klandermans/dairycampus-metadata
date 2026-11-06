CREATE VIEW dbo.VL_Dier_Melkcontrole_Laatste_Sub
AS
SELECT        AnimalServerID AS DieNum, MAX(SampleDateDT) AS DatMax
FROM            dbo.T_Animal_MilkSamples
GROUP BY AnimalServerID
