

CREATE VIEW [dbo].[VL_Dier_Lactatie]
AS
           
    SELECT 
        C1.AnimalServerID AS DieNum, 
        C1.AnimalNo AS OorNum, 
        C1.AnimalNo  COLLATE SQL_Latin1_General_CP1_CI_AS  AS OorNumGet, 
        C1.LactationNo AS LacNum, 
        C1.CalvingDateDT AS KlfDat,
        C1.ConceptionDateDT AS InsDat, 
        C1.DryOffDateDT AS DrgZetDat, 
        C1.ExpectedCalvingDateDT AS VrwKlfDat, 
        C2.CalvingDateDT - 1 AS EinDat, 
        C2.CalvingDateDT as VlgKlfDat, 
        DateDiff(day, C1.CalvingDateDT, C2.CalvingDateDT) AS TKT
    FROM    
        dbo.T_Animal_Calvings AS C1
    LEFT OUTER JOIN 
        dbo.T_Animal_Calvings AS C2 ON C1.AnimalServerID = C2.AnimalServerID
    WHERE 
        (C1.LactationNo + 1 = C2.LactationNo)
UNION
    SELECT 
        AnimalServerID, 
        AnimalNo COLLATE SQL_Latin1_General_CP1_CI_AS as AnimalNo, 
        Cast(AnimalNo AS int), 
        LactationNo, 
        CalvingDateDT, 
        ConceptionDateDT, 
        DryOffDateDT, 
        ExpectedCalvingDateDT, 
        cast(getdate() AS Date), 
        null, 
        NULL
    FROM 
        dbo.VL_AnimalCalvings_Last


--     SELECT 
--         C1.AnimalServerID AS DieNum, 
--         C1.AnimalNo AS OorNum, 
--         Cast(C1.AnimalNo AS int) AS OorNumGet, 
--         C1.LactationNo AS LacNum, 
--         C1.CalvingDateDT AS KlfDat,
--         C1.ConceptionDateDT AS InsDat, 
--         C1.DryOffDateDT AS DrgZetDat, 
--         C1.ExpectedCalvingDateDT AS VrwKlfDat, 
--         C2.CalvingDateDT - 1 AS EinDat, 
--         C2.CalvingDateDT as VlgKlfDat, 
--         DateDiff(day, C1.CalvingDateDT, C2.CalvingDateDT) AS TKT
--     FROM (
--         select  t_animal_calvings.* from t_animal_calvings 
--         left join t_animals on t_animal_calvings.animalserverid=t_animals.animalserverid 
--         where calvingdate<>birthdate
--     ) AS C1
--     LEFT OUTER JOIN (
--         select  t_animal_calvings.* from t_animal_calvings 
--         left join t_animals on t_animal_calvings.animalserverid=t_animals.animalserverid 
--         where calvingdate<>birthdate
--     ) AS C2 ON C1.AnimalServerID = C2.AnimalServerID
--     WHERE 
--         (C1.LactationNo + 1 = C2.LactationNo)
-- UNION
--     SELECT 
--         AnimalServerID, 
--         AnimalNo, 
--         Cast(AnimalNo AS int), 
--         LactationNo, 
--         CalvingDateDT, 
--         ConceptionDateDT, 
--         DryOffDateDT, 
--         ExpectedCalvingDateDT, 
--         cast(getdate() AS Date), 
--         null, 
--         NULL
--     FROM 
--         dbo.VL_AnimalCalvings_Last





-- GO
