SELECT 
    VL_Totaal_TMR.*
FROM 
    VL_Totaal_TMR
LEFT JOIN (
        SELECT DISTINCT 
            dat, hok, prfcod 
        FROM 
            tvl_totaal_bedrijf_proef
        WHERE prfcod='[prfcod]'

) as prf on date = dat and groep = hok
WHERE
hok is not null