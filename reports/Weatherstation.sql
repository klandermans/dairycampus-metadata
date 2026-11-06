SELECT
    T_RAW_weerstation.*
FROM
    t_proef
left join 
    T_RAW_weerstation on [timestamp]>=begdat and [timestamp]<=iif(enddat is null, getdate(), enddat)  
WHERE 
    prfcod='[prfcod]'
          
