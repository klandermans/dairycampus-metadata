CREATE VIEW [dbo].[VL_Dier_Melkcontrole]
AS
SELECT        
    TOP (100) PERCENT MSA.AnimalServerID AS DieNum, 
    MSA.SampleDateDT AS Dat, DATEADD(day, - 1, 
    MSB.SampleDateDT) AS DatGldTot, 
    MSA.MilkQuantityMass AS Mlk, 
    MSA.FatPercentage AS Vet, MSA.ProteinPercentage AS Eiw, MSA.LactosePercentage AS Lac, MSA.KetosisCode AS Ket, 
    MSA.Urea AS Ure, MSA.SCCDay as Cel
FROM            
    dbo.T_Animal_MilkSamples AS MSA 
INNER JOIN dbo.T_Animal_MilkSamples AS MSB ON MSA.AnimalServerID = MSB.AnimalServerID
WHERE        
    (MSB.SampleDateDT = (SELECT        MIN(SampleDateDT) AS Expr1
                            FROM            dbo.T_Animal_MilkSamples
                               WHERE        (AnimalServerID = MSA.AnimalServerID) AND (SampleDateDT > MSA.SampleDateDT)))
UNION
SELECT        DieNum, Dat, DatGldTot, Mlk, Vet, Eiw, Lac, Ket, Ure, Cel
FROM            VL_Dier_Melkcontrole_Laatste

