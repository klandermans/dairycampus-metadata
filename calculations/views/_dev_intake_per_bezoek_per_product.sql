CREATE view [dbo].[_dev_intake_per_bezoek_per_product] as     
select 
    cow,  
    station,  
    vr.date, 
    cast(vr.datetime+cast(starttime as datetime) as datetime) as [datetime],   
    ingredientname, 
    intake as opn, 
    [percentage] ,
    [percentage] * cast(intake as real) as intake

from 
    t_raw_hokofarmvr as vr 
left join 
    _dev_ingredient_per_bak_per_batch_dag as tr on cast(vr.datetime+cast(starttime as datetime) as datetime)=cast(tr.date+cast(starttime as datetime) as datetime)  and vr.station=tr.ric
where 
  intake>0 and ingredientname is not null
    -- and cow=89 and vr.date='2024-01-02'
    -- and starttime='03:10:18.000'
    -- order by starttime
-- select sum(intake), count(distinct starttime) from t_raw_hokofarmvr where 
--   cow=89 and date='2024-01-02'
