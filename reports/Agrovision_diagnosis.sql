select  
    AnimalDiagnosisId, 
    diagnosisdate, 
    cast(animalno as int) as animalno, 
    disorderdesc , 
    diagnosiscategorytypename, 
    DiagnosisLocationLF,  
    DiagnosisLocationLR,
    DiagnosisLocationRF, 
    DiagnosisLocationRR 

from 
    T_Animal_Diagnosis 
LEFT JOIN 
    TVL_totaal_bedrijf_proef as ppp on ppp.animalserverid=T_Animal_diagnosis.AnimalServerId and cast(Diagnosisdate as date ) =dat
WHERE  
    prfcod='[prfcod]'  


