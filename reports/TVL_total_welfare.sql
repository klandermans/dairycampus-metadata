SELECT    
    OorNum
    , tvl_totaal_welzijnsdagboek.[PrfCod]
    ,tvl_totaal_welzijnsdagboek.[dat]
    ,tvl_totaal_welzijnsdagboek.[animalserverid]
    ,tvl_totaal_welzijnsdagboek.[typ]
    ,tvl_totaal_welzijnsdagboek.[bron]
    , '"' + REPLACE(CONVERT(NVARCHAR(MAX), [description]), '"', '""') + '"' AS [description]
FROM 
    tvl_totaal_welzijnsdagboek  
LEFT JOIN 
    t_animals on t_animals.animalserverid=tvl_totaal_welzijnsdagboek.animalserverid 
LEFT JOIN      
    TVL_Totaal_Bedrijf_Proef  on TVL_Totaal_Bedrijf_Proef.animalserverid=t_animals.animalserverid and cast(TVL_Totaal_Bedrijf_Proef.dat as date ) =tvl_totaal_welzijnsdagboek.dat 
WHERE      
    tvl_totaal_welzijnsdagboek.prfcod='[prfcod]'     and TVL_Totaal_Bedrijf_Proef.prfcod='[prfcod]'