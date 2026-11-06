CREATE VIEW [dbo].[VL_Animal_Movements]
AS
SELECT TOP (100) PERCENT 
    MovementID, 
    AnimalID, 
    AnimalServerID, 
    AnimalNo COLLATE SQL_Latin1_General_CP1_CI_AS as AnimalNo, 
    SortAnimalNo, 
    MovementDate, 
    -- MovementDateDT,
    iif(DATEPART(HH,MovementDateDT)>15, dateadd(day, +1, MovementDateDT ), MovementDateDT ) as MovementDateDT ,  

    
    
     MainEntityType, MainEntityTypeMain, 
    MovementType, 
    MovementTypeName, MovementTime, DairyFarmSiteID, 
    DairyFarmSiteAbbr COLLATE SQL_Latin1_General_CP1_CI_AS  as DairyFarmSiteAbbr, -- dit is het ok
    DairySiteID, DairySiteAbbr, FromToRelationID, FromToCountryNo, 
    TransporterRelationID, 
    TransportNumber, MovementAmount, 
    AmountRelationID, MovementWeight, SlaughterLabel, ProductionTargetType, 
    ProductionTargetTypeName, 
    MovementReasonType, MovementReasonTypeName
FROM            
    dbo.T_Animal_Movements
WHERE  
    -- Bert:: wat zijn dit ? 
    (MovementType NOT IN (117, 853))

