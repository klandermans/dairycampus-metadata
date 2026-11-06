select 
    ppp.[AnimalServerID]
    ,[AnimalNo] as OorNum
    ,[SortAnimalNo]
    ,cast([BreedType] AS VARCHAR(32)) as BreedType
    ,cast([BreedTypeName] AS VARCHAR(32)) as BreedTypeName
    ,cast([BreedPercentage] AS VARCHAR(32)) as BreedPercentage
    
FROM T_Animal_AnimalBreedCompositions  
LEFT JOIN 
    ( select distinct animalserverid , prfcod from TVL_totaal_bedrijf_proef ) as ppp on ppp.animalserverid=T_Animal_AnimalBreedCompositions.AnimalServerId 
WHERE  
    prfcod='[prfcod]'  



