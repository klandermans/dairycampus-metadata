
CREATE view [dbo].[VL_Totaal_koenders] as 
select datetime, hok, 
avg(temp) as temp,


 avg(rhi) as rhi, meetsysteem
from 
(
    select distinct 
        datetime, 
        hok, 
        [value]-40 as temp, 
        null as rhi, 
        T_Raw_Koenders_mV_sensors.meetsysteem
    from 
        T_Raw_Koenders_mV_sensors 
    left join 
        T_Raw_Koenders_mV_sensors_keys on T_Raw_Koenders_mV_sensors.[index]=T_Raw_Koenders_mV_sensors_keys.[index] 
    and T_Raw_Koenders_mV_sensors.field=T_Raw_Koenders_mV_sensors_keys.field
    where [type]='temp'
        and hok is not null
        and [value] > 0
        and [value] < 80
    union all 
    select distinct 
        datetime, 
        hok, null as temp, 
        [value] as rhi, 
        T_Raw_Koenders_mV_sensors.meetsysteem
    from 
        T_Raw_Koenders_mV_sensors 
    left join 
        T_Raw_Koenders_mV_sensors_keys on T_Raw_Koenders_mV_sensors.[index]=T_Raw_Koenders_mV_sensors_keys.[index] 
    and T_Raw_Koenders_mV_sensors.field=T_Raw_Koenders_mV_sensors_keys.field
    where [type]='rhi' and [value] > 0  and [value] < 100 and hok is not null
    
) as tot
-- where 
    -- datetime='2025-09-15 15:45:00.000'
where hok<>'62'
group by 
    hok, 
    datetime, 
    meetsysteem
-- order by datetime desc


-- select * from T_Raw_Koenders_mV_sensors_keys
-- select 
--     k.datetime, 
--     hok,  
--     k.temp, 
--     temperature_150 
-- from vl_totaal_koenders as k 
-- left join (

-- select     
--     DATEADD(
--         MINUTE,
--         DATEDIFF(MINUTE, 0, timestamp) / 15 * 15,
--         0
--     ) AS tt, * from t_raw_weerstation 

-- ) as w  on cast(k.datetime as datetime)=tt
-- where hok='62'
-- order by k.datetime desc


