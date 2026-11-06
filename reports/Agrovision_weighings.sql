SELECT 
    cast(weighdatedt as datetime) as 'datetime', 
    cast(animalno as int) as animalno, [weight] as 'weight'   
FROM 
    TB_Animal_AnimalWeighings   
LEFT JOIN 
    TVL_totaal_bedrijf_proef as ppp on ppp.animalserverid=TB_Animal_AnimalWeighings.AnimalServerId and cast(WeighDate as date)=dat
WHERE  
    prfcod='[prfcod]'


