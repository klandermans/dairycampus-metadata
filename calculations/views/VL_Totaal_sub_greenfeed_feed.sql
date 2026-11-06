
    CREATE VIEW VL_Totaal_sub_greenfeed_feed as 
    select cow, cast(date as date) as [date], count(*) as gf_cupdrops 
    from T_RAW_greenfeed_feed_data group by cow, cast(date as date)