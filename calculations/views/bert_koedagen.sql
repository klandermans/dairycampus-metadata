create view bert_koedagen as 

select 
    DATEPART(year,dat) as 'jaar', 
    DATEPART(month,dat) as 'maand', 
    prfcod as 'proefcode' , 
    sum(cnt)  as koedagen
from 
(
    SELECT  prfcod, 
            dat,    
            count(distinct dienum) as cnt 
    FROM dbo.TVL_Dier_Datum_Proef 
    GROUP BY prfcod, dat
) as sub 
group by 
    DATEPART(year,dat), 
    DATEPART(month,dat),
    prfcod 
-- order by 
--     jaar desc, maand desc, prfcod asc;
