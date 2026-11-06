    CREATE view [dbo].[VL_Totaal_sub_greenfeed_summarized_data] as 


select 
    cow, 
    date, 
    sum(gf_visits) as gf_visits, 
    sum(gf_visits_final) as gf_visits_final
from (
    select 
        cow, 
        cast(date as date) as [date], 
        count(*) as gf_visits, 
        0 as gf_visits_final 
    from 
        T_RAW_greenfeed_summarized_data 
    group by cow, cast(date as date)
    union all
    select 
        cow, 
        cast(date as date) as [date],
        0 as gf_visits, 
        count(*) as gf_visits_final
    from 
        T_RAW_greenfeed_summarized_data_final 
    group by 
        cow, cast(date as date)
) as sub 
where cow >0
group by date, cow
-- order by gf_visits desc 