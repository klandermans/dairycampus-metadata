SELECT 
    [date],
    [cow],
    [gate],
    [event],
    [message] 
FROM 
    T_RAW_Gea_Separatie 
LEFT JOIN
    TVL_Totaal_Bedrijf_Proef as ppp on ppp.oornum=cow and cast(date as date ) =dat
WHERE
    prfcod='[prfcod]'
