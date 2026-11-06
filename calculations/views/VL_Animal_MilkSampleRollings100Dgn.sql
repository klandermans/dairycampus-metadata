CREATE VIEW dbo.VL_Animal_MilkSampleRollings100Dgn
AS
SELECT        MS.AnimalServerID AS DieNum, MS.AnimalNo AS OorNum, CAST(MS.AnimalNo AS int) AS OorNumGet, MS.LactationNo, MS.CalvingDateDT, MS.RollingDateDT, 
                         MS.LactationDays, MS.MilkQuantityMass, ROUND(CAST(MS.MilkQuantityMass AS real) / MS.LactationDays * 100, 0) AS MilkQuantityMass100Dgn, 
                         MS.FatQuantityMass, ROUND(MS.FatQuantityMass / MS.LactationDays * 100, 2) AS FatQuantityMass100Dgn, MS.ProteinQuantityMass, 
                         ROUND(MS.ProteinQuantityMass / MS.LactationDays * 100, 2) AS ProteinQuantityMass100Dgn, MS.LactationValue, C.ExpectedCalvingDateDT
FROM            dbo.T_Animal_MilkSampleRollings AS MS INNER JOIN
                         dbo.VL_Animal_MilkSampleRollings_100DgnB AS MSB ON MS.AnimalServerID = MSB.AnimalServerID AND MS.LactationNo = MSB.LactationNo AND 
                         ABS(MS.LactationDays) = MSB.MinLactationDays LEFT OUTER JOIN
                         dbo.T_Animal_Calvings AS C ON MS.LactationNo = C.LactationNo AND MS.AnimalServerID = C.AnimalServerID
