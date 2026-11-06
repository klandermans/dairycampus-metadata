SELECT DISTINCT
    animalserverid ,
    VL_Totaal_Bedrijf_Ric_VR.* 
FROM 
    VL_Totaal_Bedrijf_Ric_VR  WITH (NOLOCK)  
LEFT JOIN
    TVL_Totaal_Bedrijf_Proef as ppp WITH (NOLOCK)  on ppp.oornum=cow and cast(date as date ) =dat
WHERE
    prfcod='[prfcod]'  


