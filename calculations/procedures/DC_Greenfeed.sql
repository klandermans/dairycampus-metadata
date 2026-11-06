
CREATE procedure  [dbo].[DC_Greenfeed] AS

drop table if EXISTS #transponder
-- SELECT DISTINCT cast(respiso as varchar) as transponder, COW, cast(imdat as date) as date into #transponder FROM T_RAW_gea_milk




select 
    distinct 
    cast(transponder as bigint) as transponder,
    cow, [date]
into #transponder 
from (
    select DISTINCT cast(transponder as varchar) as transponder, COW, cast(date as date) as date 
    from t_raw_hokofarmvb
    union all 
    select DISTINCT cast(transponder as varchar) as transponder, COW, cast(date as date) as date 
    from t_raw_hokofarmvr
    union all
    select DISTINCT cast(transponder as varchar) as transponder, COW, cast(date as date) as date 
    from t_raw_hokofarmvb_apollo
    union all 
    select DISTINCT cast(transponder as varchar) as transponder, COW, cast(date as date) as date 
    from t_raw_hokofarmvr_apollo    
    union all 
    SELECT DISTINCT cast(cast(respiso as varchar) as bigint) as transponder, COW, cast(imdat as date) as date  
    FROM T_RAW_gea_milk 
    where respiso not like '%NL%'
    union all 
    SELECT DISTINCT cast(replace(cast(respiso as varchar),'NL ' ,'') as bigint) as transponder, COW, cast(imdat as date) as date  
    FROM T_RAW_gea_milk 
    where respiso  like '%NL%'   
) as asdf


drop table IF EXISTS  #interval
select 
    cow, 
    transponder, 
    min(date) as mindate, max(date) as maxdate 
    into #interval 
from #transponder 
group  by cow, transponder

update T_RAW_Greenfeed_Summarized_Data
set cow = 
(
    select max(cow) from #interval as asdf
    where  
        cast([rfid] as varchar) =cast([transponder] as varchar) and date>=mindate and date <=maxdate
) 
where [user] = 'dairycampus' and (cow=0 or cow is null)

update T_RAW_Greenfeed_Summarized_Data_final
set cow = 
(
    select max(cow) from #interval as asdf
    where  
    cast([rfid] as varchar) =cast([transponder] as varchar) and date>=mindate and date <=maxdate
) 
where [user] = 'dairycampus' and (cow=0 or cow is null)



update T_RAW_Greenfeed_feed_data
SET cow = 
(
    SELECT
        max(cow) 
    FROM #interval as asdf
    WHERE  
        cast([RFIDtag] as varchar) =cast([transponder] as varchar) and date>=mindate and date <=maxdate
) 
where [user] = 'dairycampus' and (cow=0 or cow is null)

update T_RAW_Greenfeed_RFID_data
set cow = 
(
    select 
        max(cow) 
    from 
        #interval as asdf
    where  
        cast([RFIDtag] as varchar) =cast([transponder] as varchar) and date>=mindate and date <=maxdate
        
) 
where [user] = 'dairycampus' and (cow=0 or cow is null)

