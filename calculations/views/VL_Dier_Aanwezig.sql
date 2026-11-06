CREATE VIEW [dbo].[VL_Dier_Aanwezig]
AS
SELECT        
    A.AnimalServerID AS DieNum, 
    RIGHT('0000' + CAST(A.AnimalNo AS varchar(4)), 4) AS OorNum, 
    CAST(A.AnimalNo AS int) AS OorNumGet, A.RegistrationId AS LevNum, 
                         A.GenderTypeName AS Gsl, 
    A.LastSupplyDairyFarmSiteAbbr AS Tak, C.LactationNo AS LacNum, 
    A.BirthDateDT AS GebDat, C.CalvingDateDT AS KlfDat, 
    iif(C.LactationNo IS NULL OR C.LactationNo = 0, NULL, 
    iif(dbo.T_Animal_DryOffs.DryOffDateDT IS NOT NULL, 'Droog', 'Melk')) AS PrdSta, C.LactationFertilityStateDateDT AS VruStaDat, 
    C.LactationFertilityStateTypeName AS VruSta, 
    C.ExpectedDryOffDateDT AS VrwDrgZetDat,
    dbo.T_Animal_DryOffs.DryOffDateDT AS DrgZetDat, 
    C.ExpectedCalvingDateDT AS VrwKlfDat, 
    M.RollingDateDT AS MlkConDat, 
    M.MilkQuantityMass305d AS Mlk305, 
    M.FatQuantityMass305d AS Vet305, 
    M.ProteinQuantityMass305d AS Eiw305, 
    dbo.ZitInProeven(A.AnimalServerID) As ZitInPrf
FROM dbo.T_Animal_MilkSampleRollings AS M 
INNER JOIN
     dbo.VL_LaatsteMilkSampleRolling ON M.AnimalServerID = dbo.VL_LaatsteMilkSampleRolling.AnimalServerID AND 
                         M.RollingDateDT = dbo.VL_LaatsteMilkSampleRolling.MaxRollingDateDT 
RIGHT OUTER JOIN 
    dbo.VL_LaatsteAfkalving AS L 
INNER JOIN 
    dbo.T_Animal_Calvings AS C ON L.AnimalServerID = C.AnimalServerID AND L.MaxCalvingDateDT = C.CalvingDateDT ON  M.LactationNo = C.LactationNo AND M.AnimalServerID = C.AnimalServerID 
LEFT OUTER JOIN
    dbo.T_Animal_DryOffs ON C.CalvingID = dbo.T_Animal_DryOffs.CalvingID 
RIGHT OUTER JOIN T_Animals AS A ON C.AnimalServerID = A.AnimalServerID AND 
    M.AnimalMilkSampleRollingID = dbo.VL_LaatsteMilkSampleRolling.MaxAnimalMilkSampleRollingID
WHERE        
    (A.IsOnFarm <> 0)



