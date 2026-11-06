SELECT DISTINCT
   T_RAW_Greenfeed_RFID_data.*
FROM
    T_RAW_Greenfeed_RFID_data
LEFT JOIN
    TVL_Totaal_Bedrijf_Proef as ppp on ppp.oornum=cow and cast(date as date ) =dat
WHERE
    prfcod='[prfcod]'
