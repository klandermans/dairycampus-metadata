SELECT 
    AnimalDiagnosisId, 
    treatmentdate, diagnosisdate, 
    cast(animalno as int) as animalno,
    Treatmenttypename, medicineabbr, medicinedesc, MedicineRegistrationCode, Medicinetypename, treatments, QuantityPerTreatment,treatmentperiod, treatmentperiodtypename, unittypename, TreatmentLocationLF,treatmentlocationrf, TreatmentLocationLr,treatmentlocationrr,  waitmilkperiod, WaitMeatPeriod 
FROM 
    T_Animal_TreatmentActions 
LEFT JOIN 
    TVL_totaal_bedrijf_proef as ppp on ppp.animalserverid=T_Animal_TreatmentActions.AnimalServerId and cast(TreatmentDate as date ) =dat
WHERE  
    prfcod='[prfcod]'