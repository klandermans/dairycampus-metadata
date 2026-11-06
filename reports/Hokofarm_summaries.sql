SELECT DISTINCT 
    animalserverid, 
    VL_Totaal_Bedrijf_Ric_CD.* 
FROM 
    VL_Totaal_Bedrijf_Ric_CD   
LEFT JOIN 
    TVL_Totaal_Bedrijf_Proef as ppp on ppp.oornum=cow and cast(date as date ) =dat
WHERE  
    prfcod='[prfcod]'  

