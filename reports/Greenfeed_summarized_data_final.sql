SELECT DISTINCT
    T_RAW_Greenfeed_Summarized_Data_final.*
FROM
    T_RAW_Greenfeed_Summarized_Data_final
LEFT JOIN
    (select distinct oornum, cast(dat as date) as dat, prfcod from TVL_Totaal_bedrijf_Proef WHERE prfcod='[prfcod]') as ppp on ppp.oornum=cow and cast(date as date ) =dat
where 
    oornum is not null
