CREATE VIEW [dbo].[VL_AnimalCalvings_Last]
-- with schemabinding

AS
SELECT        
    T_Animal_Calvings.CalvingID, 
    T_Animal_Calvings.AnimalID, 
    T_Animal_Calvings.AnimalServerID, 
    T_Animal_Calvings.AnimalNo, 
    T_Animal_Calvings.SortAnimalNo, 
    T_Animal_Calvings.DryOffDate, 
    T_Animal_Calvings.DryOffDateDT,
    T_Animal_Calvings.CalvingDate, 
    T_Animal_Calvings.CalvingDateDT, 
    T_Animal_Calvings.CalvingType, 
    T_Animal_Calvings.CalvingTypeName, 
    T_Animal_Calvings.ProcessComputerCalvingDate, 
    T_Animal_Calvings.LactationNo,
    T_Animal_Calvings.CalvingProcessAbbr, 
    T_Animal_Calvings.CalvingProcessType, 
    T_Animal_Calvings.CalvingProcessTypeName, 
    T_Animal_Calvings.MilkDeliveryDateTime, 
    T_Animal_Calvings.EventCommentAbbr, 
    T_Animal_Calvings.AfterBirthType, 
    T_Animal_Calvings.AfterBirthTypeName, 
    T_Animal_Calvings.ConceptionDate, 
    T_Animal_Calvings.ConceptionDateDT,
    T_Animal_Calvings.FertilizationMatingID, 
    T_Animal_Calvings.FertilizationMatingDate,
    T_Animal_Calvings.FertilizationMatingDateDT,
    T_Animal_Calvings.FertilizationPregnancyFertilityStatusID, 
    T_Animal_Calvings.FertilizationPregnancyFertilityStateDate, 
    T_Animal_Calvings.FertilizationPregnancyFertilityStateDateDT, 
    T_Animal_Calvings.LactationFertilityStateType, 
    T_Animal_Calvings.LactationFertilityStateTypeName, 
    T_Animal_Calvings.LactationFertilityStateDate, 
    T_Animal_Calvings.LactationFertilityStateDateDT, 
    T_Animal_Calvings.LastHeatEventsDate, 
    T_Animal_Calvings.LastHeatEventsDateDT, 
    T_Animal_Calvings.CalvingInterval, 
    T_Animal_Calvings.HasMatingWithFlushing, 
    T_Animal_Calvings.HasMatingWithEmbryoImplant, 
    T_Animal_Calvings.ExpectedDryOffDate, 
    T_Animal_Calvings.ExpectedCalvingDate, 
    T_Animal_Calvings.ExpectedDryOffDateDT, 
    T_Animal_Calvings.ExpectedCalvingDateDT
FROM            
(
        select  t_animal_calvings.* from t_animal_calvings 
        left join t_animals on t_animal_calvings.animalserverid=t_animals.animalserverid 
        where calvingdate<>birthdate
    ) as T_Animal_Calvings
INNER JOIN
    VL_AnimalCalvings_Last_Sub ON T_Animal_Calvings.AnimalServerID = VL_AnimalCalvings_Last_Sub.AnimalServerID AND 
    T_Animal_Calvings.LactationNo = VL_AnimalCalvings_Last_Sub.MaxLactationNo



