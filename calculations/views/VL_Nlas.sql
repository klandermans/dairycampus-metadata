-- SET ANSI_NULLS ON
-- GO
-- SET QUOTED_IDENTIFIER ON
-- GO
CREATE VIEW [dbo].[VL_Nlas] AS
SELECT T.[id]
      ,T.[cow]
      ,S.Hok
      ,T.[Group] as [group]
	  ,'1 DCO' as Stl
      ,T.[sewio_tagnr]
	  ,S.Dat
      ,T.[datetime_begin]
      ,T.[datetime_end]
      ,T.[note_at_start]
      ,T.[note_at_end]
      ,T.[datetime_entry]
      ,T.[datetime_edit]
      ,T.[datetime_enddate]
	  ,ST.[tag_settings]
      , t.newentry_by_user
      , t.edit_by_user
      , batt
      , removed
  FROM 
  
  [dbo].[T_RAW_Nlas_TagCows] T
  left join  [dbo].[T_RAW_Nlas_Sewiotags] as ST  on  t.sewio_tagnr = ST.sewio_tag 
  left join [dbo].[tvl_totaal_bedrijf] as S on CAST(s.Dat AS DATE) = CAST(T.datetime_begin AS DATE) and  t.COW = S.OorNum
   left join (

        SELECT 
            [sewio_tag] as batt_id     
            , cast(replace(current_value, '%','')  as int) as batt
        FROM [dbo].[T_RAW_Nlas_Sewiotags]
        left join t_raw_nlas_feeds on  T_RAW_Nlas_Sewiotags.sewio_tag=t_raw_nlas_feeds.alias
        left join (select * from T_RAW_Nlas_feeds_Datastreams where d_id ='battery_level') as batt on feed_reference=t_raw_nlas_feeds.id

   ) as ss on batt_id=sewio_tagnr

    -- where
      	  
	--    S.Stl = '1 DCO'
-- 

--  cow=4125
