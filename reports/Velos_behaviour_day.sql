SELECT
    cast(date as date) as date,
    cow,
    cast(DATEADD(ss, sum(duration), 0) as time ) as total,
    cast(DATEADD(ss, sum(iif(type=0, duration, 0)), 0) as time) as overig,
    cast(DATEADD(ss, sum(iif(type=1, duration, 0)), 0) as time) as nietactief,
    cast(DATEADD(ss, sum(iif(type=2, duration, 0)), 0) as time) as herkouwen,
    cast(DATEADD(ss, sum(iif(type=3, duration, 0)), 0) as time) as vreten
from
    T_RAW_velos_behaviour
LEFT JOIN
    TVL_Totaal_bedrijf_Proef as ppp on ppp.oornum=cow and cast(date as date )=dat
WHERE
    prfcod='[prfcod]'
GROUP by    
    cast(date as date), cow