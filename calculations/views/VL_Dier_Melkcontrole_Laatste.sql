CREATE VIEW dbo.VL_Dier_Melkcontrole_Laatste
AS
SELECT        MS.AnimalServerID AS DieNum, MS.SampleDateDT AS Dat, GETDATE() AS DatGldTot, MS.MilkQuantityMass AS Mlk, MS.FatPercentage AS Vet, 
                         MS.ProteinPercentage AS Eiw, MS.LactosePercentage AS Lac, MS.KetosisCode AS Ket, MS.Urea AS Ure, MS.SCCDay AS Cel
FROM            dbo.T_Animal_MilkSamples AS MS INNER JOIN
                         dbo.VL_Dier_Melkcontrole_Laatste_Sub AS L ON MS.AnimalServerID = L.DieNum AND MS.SampleDateDT = L.DatMax
