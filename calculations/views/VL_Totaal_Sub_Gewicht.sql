CREATE view VL_Totaal_Sub_Gewicht as 

select 
    d as date, 

    cow, 
    avg(iif(geao is not null, geao, agro) ) as gewo,
    avg(iif(geao is not null, geaa, agra) ) as gewa
from (
    select   
        cast(date as date) as d, 
        cow, 
        max(iif(datepart(hh, date) <12, weight, null)) as geao, 
        max(iif(datepart(hh, date)>=12, weight, null)) as geaa,
        null as agro,
        null as agra
    from 
        t_raw_gea_gewicht
    where [weight]>25
    group by 
        cast(date as date), cow
    union all
    select   
        cast(weighdate as date) as d, 
        animalno, 
        null as geao,
        null as geaa,
        max(iif(datepart(hh, weighdate) <12, weight, null)) as agro, 
        max(iif(datepart(hh, weighdate)>=12, weight, null)) as agra
    from 
        TB_Animal_AnimalWeighings
    where [weight]>25
    group by 
        cast(weighdate as date), animalno    
) as tt 
group by d, cow