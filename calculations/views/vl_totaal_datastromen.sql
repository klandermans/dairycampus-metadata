CREATE view [dbo].[VL_totaal_datastromen] as 
select 
    dat, 
    iif(gea_milk is null, 'X','') as gea_milk, 
    
    iif(gf_feed is null, 'X','') as gf_feed, 
    iif(gf_visit is null, 'X','') as gf_visit, 
    iif(gf_rfid is null, 'X','') as gf_rfid,
    iif(velos is null, 'X','') as velos        
    
from (
    select dat from t_datum where dat<getdate()  
) as t_datum
left join (
    select cast(date as date) as gfdat, count(*) as gf_feed from t_raw_greenfeed_feed_data group by cast(date as date)
) as gff on gfdat=dat
left join (
    select cast(date as date) as gfvdat, count(*) as gf_visit from t_raw_greenfeed_summarized_data group by cast(date as date)
) as gffv on gfvdat=dat
left join (
    select cast(date as date) as gfrdat, count(*) as gf_rfid from t_raw_greenfeed_rfid_data group by cast(date as date)
) as gfrfv on gfrdat=dat
left join (
    select cast(imdat as date) as geamilkdat, count(*) as gea_milk from t_raw_gea_milk group by cast(imdat as date)
) as geamilk on geamilkdat=dat

left join (
    select cast(date as date) as velosdate, count(*) as velos from T_Raw_velos_behaviour group by cast(date as date)
) as velosss on velosdate=dat



