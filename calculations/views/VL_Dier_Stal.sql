-- SET ANSI_NULLS ON
-- GO
-- SET QUOTED_IDENTIFIER ON
-- GO
CREATE VIEW [dbo].[VL_Dier_Stal]

AS
SELECT        
    M1.MovementID AS ID, 
    M1.AnimalServerID AS DieNum, 
    M1.AnimalNo AS OorNum, 
    M1.MovementDateDT AS BegDat, 
    Dateadd(day, - 1, M2.MovementDateDT) AS EndDat, 
    
    M1.DairySiteAbbr AS Stl, 
    M1.DairyFarmSiteAbbr AS Hok, 
    M1.MovementType AS GebCod, 
    M1.MovementTypeName AS GebOms
FROM 
    dbo.VL_Animal_Movements AS M1 
INNER JOIN 
    dbo.VL_Animal_Movements AS M2 ON M1.AnimalServerID = M2.AnimalServerID
WHERE (M2.MovementDateDT = (
        SELECT 
            MIN(MovementDateDT) AS Expr1
        FROM            
            dbo.VL_Animal_Movements
        WHERE        
            (AnimalServerID = M1.AnimalServerID) 
        AND (MovementDateDT > M1.MovementDateDT))
    ) 
    AND M1.MovementDateDT >= '1-jan-2016' 
    AND M1.DairySiteAbbr IS NOT NULL AND M1.DairyFarmSiteAbbr IS NOT NULL
UNION
SELECT        
    M1.MovementID, 
    M1.AnimalServerID, 
    M1.AnimalNo AS OorNum, 
    M1.MovementDateDT, 
    
    NULL, 
    M1.DairySiteAbbr, 
    M1.DairyFarmSiteAbbr, 
    M1.MovementType, 
    M1.MovementTypeName
FROM            
    dbo.VL_Animal_Movements AS M1
WHERE         
    (M1.MovementDateDT =  (
        SELECT        
            MAX(MovementDateDT) AS Expr1
        FROM            
            dbo.VL_Animal_Movements
        WHERE        
            (AnimalServerID = M1.AnimalServerID))) 
            AND M1.MovementDateDT >= '1-jan-2016' 
            AND M1.DairySiteAbbr IS NOT NULL 
            AND M1.DairyFarmSiteAbbr IS NOT NULL 
            -- and movementid in (853,984,984,964,953,982)  or t_animals.IsOnFarm=1 and  T_datum.dat <= getdate()) 



-- -- deze query hebben fedde en bert aangepast op 9-6-2021
-- -- om dieren die afgevoerd zijn, die geen tak-overgang hebben gehad wel uit  
-- -- t_dier_stal een einddatum te geven combineren we t_dier_stal met t_animals
-- select 
--     ID, 
--     DieNum, 
--     OorNum, 
--     BegDat, 
--     iif(enddat is null and  LastRemovalMovementDate is not null,  LastRemovalMovementDate, EndDat) as  EndDat, 
--     Stl, 
--     Hok, 
--     GebCod, 
--     GebOms
-- from (
-- SELECT        
--     M1.MovementID AS ID, 
--     M1.AnimalServerID AS DieNum, 
--     M1.AnimalNo AS OorNum, 
--     M1.MovementDateDT AS BegDat, 
--     Dateadd(day, - 1, M2.MovementDateDT) AS EndDat, 
--     M1.DairySiteAbbr AS Stl, 
--     M1.DairyFarmSiteAbbr AS Hok, M1.MovementType AS GebCod, 
--     M1.MovementTypeName AS GebOms
-- FROM 
--     dbo.VL_Animal_Movements AS M1 
-- INNER JOIN 
--     dbo.VL_Animal_Movements AS M2 ON M1.AnimalServerID = M2.AnimalServerID
-- WHERE (M2.MovementDateDT = (
--         SELECT 
--             MIN(MovementDateDT) AS Expr1
--         FROM            
--             dbo.VL_Animal_Movements
--         WHERE        
--             (AnimalServerID = M1.AnimalServerID) 
--         AND (MovementDateDT > M1.MovementDateDT))
--     ) 
--     AND M1.MovementDateDT >= '1-jan-2016' 
--     AND M1.DairySiteAbbr IS NOT NULL AND M1.DairyFarmSiteAbbr IS NOT NULL
-- UNION
-- SELECT        
--     M1.MovementID, 
--     M1.AnimalServerID, 
--     M1.AnimalNo AS OorNum, 
--     M1.MovementDateDT, NULL, M1.DairySiteAbbr, 
--     M1.DairyFarmSiteAbbr, 
--     M1.MovementType, 
--     M1.MovementTypeName
-- FROM            
--     dbo.VL_Animal_Movements AS M1
-- WHERE         
--     (M1.MovementDateDT =  (
--         SELECT        
--             MAX(MovementDateDT) AS Expr1
--         FROM            
--             dbo.VL_Animal_Movements
--         WHERE        
--             (AnimalServerID = M1.AnimalServerID))) 
--             AND M1.MovementDateDT >= '1-jan-2016' 
--             AND M1.DairySiteAbbr IS NOT NULL 
--             AND M1.DairyFarmSiteAbbr IS NOT NULL 
-- ) as sub
-- left join t_animals on dienum=AnimalServerID




