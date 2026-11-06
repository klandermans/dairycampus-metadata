   CREATE VIEW [dbo].[VL_Totaal_Sub_HokofarmBrok] as 
    -- 2025-08-13 summarized the view to only include the necessary columns and calculations
    -- beetje gek dat je dus de krachtvoeropnamen en tegoeden optelt. maar als een dier van beide systemen gegvreten heeft 
    select 

  
        [date], 
        [cow], 
        sum([HokoRv]) as HokoRV,
        sum(totalIntakeKVA) as HokoBrok1,
        sum(totalIntakeKVB) as HokoBrok2,
        sum(totalIntakeKVC) as HokoBrok3, 
        sum(totalIntakeKVD) as HokoBrok4, 


        sum(AtributedKVA)   as AtributedKVA,
        sum(totalIntakeKVA) as totalIntakeKVA,
        sum(AtributedKVB)   as AtributedKVB,
        sum(totalIntakeKVB) as totalIntakeKVB,
        sum(AtributedKVC)   as AtributedKVC,
        sum(totalIntakeKVC) as totalIntakeKVC,
        sum(AtributedKVD)   as AtributedKVD,
        sum(totalIntakeKVD) as totalIntakeKVD
    from (   
        select 
            cast([date] as date) as [date],
            cast(cow as int) as [cow], 
            0 as HokoRv,
            AtributedKVA,
            totalIntakeKVA,
            AtributedKVB,
            totalIntakeKVB,
            AtributedKVC,
            totalIntakeKVC,
            AtributedKVD,
            totalIntakeKVD    
        from    
            T_Raw_HokofarmCD
        where 
            numberOfVisitsKVStation>0 
        union ALL        
        select 
            cast([date] as date) as [date],
            cast(cow as int) as [cow], 
            0 as HokoRv,
            AtributedKVA,
            totalIntakeKVA,
            AtributedKVB,
            totalIntakeKVB,
            AtributedKVC,
            totalIntakeKVC,
            AtributedKVD,
            totalIntakeKVD    
        from    
            T_RAW_HokofarmCD_apollo        
        where 
            numberOfVisitsKVStation>0 
    ) as CD
 
    group by 
    date, 
    cow
        

