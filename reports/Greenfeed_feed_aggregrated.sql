SELECT
    cast(g.date as date) as date,
    rfidTag,
    greenfeed,
    cast(count(*) as int) as cupdrops ,
    cow
from
    T_RAW_Greenfeed_Feed_data as g
LEFT JOIN 
    (select distinct prfcod, dat, oornum from tvl_totaal_bedrijf_proef) as ppp on ppp.oornum=cow and cast(g.date as date ) =dat
WHERE
    prfcod='[prfcod]'
group by
    rfidTag, greenfeed, cast(g.date as date) , cow
