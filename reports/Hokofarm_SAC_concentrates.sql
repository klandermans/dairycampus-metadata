SELECT
    DISTINCT
    [date],
    [dateTime],
    [animalserverid],
    [transponder],
    [cow],
    [station],
    [startTime],
    [endTime],
    [totalTime],
    trim([feedTypeA]) as feedTypeA,
    [intakeA],
    [dryMatterA],
    [energyA],
    [proteinA],
    [crudeFiberA],
    [fatA],
    [ashA],
    trim([feedTypeB]) as feedTypeB,
    [intakeB],
    [dryMatterB],
    [energyB],
    [proteinB],
    [crudeFiberB],
    [fatB],
    [ashB],
    trim([feedTypeC]) as feedTypeC,
    [intakeC],
    [dryMatterC],
    [energyC],
    [proteinC],
    [crudeFiberC],
    [fatC],
    [ashC],
    trim([feedTypeD]) as feedTypeD,
    [intakeD],
    [dryMatterD],
    [energyD],
    [proteinD],
    [crudeFiberD],
    [fatD],
    [ashD]
    
FROM 
    VL_Totaal_Bedrijf_Ric_VB WITH (NOLOCK)   
LEFT JOIN 
    TVL_Totaal_Bedrijf_Proef as ppp WITH (NOLOCK)  on ppp.oornum=cow and cast(date as date ) =dat
WHERE  
    prfcod='[prfcod]'  

