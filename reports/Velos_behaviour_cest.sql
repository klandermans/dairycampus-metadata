SELECT 
   VL_totaal_velos.* 
FROM
    VL_totaal_velos  WITH (NOLOCK) 
LEFT JOIN      
    TVL_Totaal_Bedrijf_Proef   as ppp WITH (NOLOCK)  on ppp.oornum=cow
    AND dt >= CAST(dat AS DATETIME) 
    AND dt < DATEADD(DAY, 1, CAST(dat AS DATETIME))
WHERE
    prfcod='[prfcod]'

