SELECT DISTINCT
    VL_Totaal_Bedrijf_Ric_RW.* 
FROM 
    VL_Totaal_Bedrijf_Ric_RW WITH (NOLOCK) 
LEFT JOIN 
        (select distinct 
            oornum, 
            dat, 
            prfcod 
        from 
            TVL_Totaal_Bedrijf_Proef  WITH (NOLOCK)
        WHERE  
            prfcod='[prfcod]' ) as ppp  
on ppp.oornum=cow and cast(date as date) =dat

WHERE prfcod is not null