CREATE VIEW dbo.VL_Dier_Analyse_Melk_Standaard
AS
SELECT        SampleDateDT AS Dat, AnimalServerID, FatPercentage AS Vet, ProteinPercentage AS Eiwit, LactosePercentage AS Lactose, Urea AS Ureum, 
                         SCCDay AS Celgetal
FROM            dbo.T_Animal_MilkSamples AS M
