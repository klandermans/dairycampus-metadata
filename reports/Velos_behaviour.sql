SELECT
    [date], 
    cow, 
    [type],  
    duration
FROM
    T_RAW_velos_behaviour
LEFT JOIN
    TVL_Totaal_Bedrijf_Proef as ppp on ppp.oornum=cow and cast(date as date )=dat
WHERE
    prfcod='[prfcod]'

