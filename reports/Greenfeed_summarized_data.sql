SELECT DISTINCT
   T_RAW_Greenfeed_Summarized_Data.*
FROM
    T_RAW_Greenfeed_Summarized_Data
LEFT JOIN
    TVL_Totaal_Bedrijf_Proef as ppp on ppp.oornum=cow and cast(date as date ) =dat
WHERE
    prfcod='[prfcod]'
