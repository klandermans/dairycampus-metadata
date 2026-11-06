SELECT DISTINCT
   T_RAW_Greenfeed_Feed_data.*
FROM
    T_RAW_Greenfeed_Feed_data WITH (NOLOCK) 
left join
    tvl_totaal_bedrijf_proef as ppp WITH (NOLOCK)  on ppp.oornum=cow and cast(date as date ) =dat
where
    prfcod='[prfcod]'
