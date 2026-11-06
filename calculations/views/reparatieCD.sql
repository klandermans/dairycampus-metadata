CREATE view [dbo].[reparatieCD] as 



--- Hokofarm cd reparatie procedure gemaakt door Fedde en Bert
--- deze stappen handmatig uitvoeren en controleren, want 8 november 2023 werkte het.

--- stap 1 maak temporary tabel aan met kruistabel


-- select * into #oud from t_raw_hokofarmcd_apollo where date='2026-07-30' 
-- delete from t_raw_hokofarmcd_apollo where date='2026-07-30' 



-- drop    table    #temp

--           WITH    RankedFeedTypes AS    (
--                     SELECT
--                               cow,
--                               date,
--                               -- feedtype,
--                                                             max(iif(intake>0,feedtype, '')) AS    feedtype,

--                               SUM(iif(intake>0,intake, 0)) AS    sumintake,
                             
--                               SUM(iif(intake>0,duration, 0)) AS    duration,

--                               count(iif(intake>0,1,null)) AS    visits,
                             
--                               ROW_NUMBER() OVER    (PARTITION    BY    cow, date    ORDER    BY    SUM(intake) DESC) AS    rn
--                     FROM
--                               (select    cow, cast(dateadd(s, duration, datetime)     as    date) as    [date] , intake , duration, feedtype from    t_raw_hokofarmvr_apollo ) as    t_raw_hokofarmvr
--                     GROUP    BY
--                               cow,
--                               date,
--                               feedtype
--           )

--           SELECT
--                     date    ,
--                     cow,
                   
--                     max(CASE    WHEN    rn =    1    THEN    visits END) AS    numberOfVisitsRV1,
--                     max(CASE    WHEN    rn =    1    THEN    cast(dateadd(s, (duration), '00:00:00') as    time) END) AS    totalVisitingTimeRv1,
--                     MAX(CASE    WHEN    rn =    1    THEN    feedtype END) AS    feedTypeRV1,
--                     MAX(CASE    WHEN    rn =    1    THEN    sumintake END) AS    totalIntakeRV1,
                   
         
--                     max(CASE    WHEN    rn =    2    THEN    visits END) AS    numberOfVisitsRV2,
--                     max(CASE    WHEN    rn =    2    THEN    cast(dateadd(s, (duration), '00:00:00') as    time) END) AS    totalVisitingTimeRv2,
--                     MAX(CASE    WHEN    rn =    2    THEN    feedtype END) AS    feedTypeRV2,
--                     MAX(CASE    WHEN    rn =    2    THEN    sumintake END) AS    totalIntakeRV2,
                   

--                     max(CASE    WHEN    rn =    3    THEN    visits END) AS    numberOfVisitsRV3,
--                     max(CASE    WHEN    rn =    3    THEN    cast(dateadd(s, (duration), '00:00:00') as    time) END) AS    totalVisitingTimeRv3,
--                     MAX(CASE    WHEN    rn =    3    THEN    feedtype END) AS    feedTypeRV3,                    
--                     MAX(CASE    WHEN    rn =    3    THEN    sumintake END) AS    totalIntakeRV3,
                   
--                     max(CASE    WHEN    rn =    4    THEN    visits END) AS    numberOfVisitsRV4,
--                     max(CASE    WHEN    rn =    4    THEN    cast(dateadd(s, (duration), '00:00:00') as    time) END) AS    totalVisitingTimeRv4,
--                     MAX(CASE    WHEN    rn =    4    THEN    feedtype END) AS    feedTypeRV4,               
--                     MAX(CASE    WHEN    rn =    4    THEN    sumintake END) AS    totalIntakeRV4
                   

--                     into    #temp
--           FROM
--                     RankedFeedTypes
--           WHERE
--                     rn <=    4
--                     and    date    ='2026-07-30'
              

--           GROUP    BY
--                     cow,
--                     date



-- LET OP! Hier wordt de data aan de CD tabel toegevoeg!!


-- --- stap 2 maak     join van temporary en cd


-- insert into t_raw_hokofarmcd_apollo
-- (
-- [date],
-- cow
-- ,[numberOfVisitsRV1]
-- ,[totalVisitingTimeRV1]
-- ,[feedTypeRV1]
-- ,[totalIntakeRV1]
-- ,[numberOfVisitsRV2]
-- ,[totalVisitingTimeRV2]
-- ,[feedTypeRV2]
-- ,[totalIntakeRV2]
-- ,[numberOfVisitsRV3]
-- ,[totalVisitingTimeRV3]
-- ,[feedTypeRV3]
-- ,[totalIntakeRV3]
-- ,[numberOfVisitsRV4]
-- ,[totalVisitingTimeRV4]
-- ,[feedTypeRV4]
-- ,[totalIntakeRV4]
-- ,numberOfVisitsKVStation
-- ,totalVisitingTimeKvStation
-- ,[feedTypeKVA]
-- ,[totalIntakeKVA]
-- ,[feedTypeKVB]
-- ,[totalIntakeKVB]
-- ,[feedTypeKVC]
-- ,[totalIntakeKVC]
-- ,[feedTypeKVD]
-- ,[totalIntakeKVD] 
-- )  
-- select cast(t.dat as date) as [date],
-- oornum as cow
-- ,[numberOfVisitsRV1]
-- ,[totalVisitingTimeRV1]
-- ,[feedTypeRV1]
-- ,[totalIntakeRV1]
-- ,[numberOfVisitsRV2]
-- ,[totalVisitingTimeRV2]
-- ,[feedTypeRV2]
-- ,[totalIntakeRV2]
-- ,[numberOfVisitsRV3]
-- ,[totalVisitingTimeRV3]
-- ,[feedTypeRV3]
-- ,[totalIntakeRV3]
-- ,[numberOfVisitsRV4]
-- ,[totalVisitingTimeRV4]
-- ,[feedTypeRV4]
-- ,[totalIntakeRV4]
-- ,numberOfVisitsKVStation
-- ,totalVisitingTimeKvStation
-- ,vb.[feedTypeKVA]
-- ,vb.[totalIntakeKVA]
-- ,vb.[feedTypeKVB]
-- ,vb.[totalIntakeKVB]
-- ,vb.[feedTypeKVC]
-- ,vb.[totalIntakeKVC]
-- ,vb.[feedTypeKVD]
-- ,vb.[totalIntakeKVD]

--     from tvl_totaal_bedrijf as t
--     left join (
--           select     [date]
--           ,[cow]
--           , COUNT(*) AS numberOfVisitsKVStation
--           , cast(dateadd(s, sum(totalTime), '00:00:00') as time) as 'totalVisitingTimeKvStation'

--           ,MAX(iif([intakea]>0,feedtypea, '0'))     AS [feedTypeKVA]
--           ,sum([intakea]) AS [totalIntakeKVA]
--           -- ,MAX([feedtypeb]) AS [feedTypeKVB]
--           ,MAX(iif([intakeb]>0,feedtypeb, '0'))     AS [feedTypeKVB]
--           ,sum([intakeb]) AS [totalIntakeKVB]

--           ,MAX(iif([intakec]>0,feedtypec, '0'))     AS [feedTypeKVC]
--           -- ,MAX([feedTypeC])     AS [feedTypeKVC]
--           ,sum([intakec]) AS [totalIntakeKVC]
--           -- ,MAX([feedTypeD]) AS [feedTypeKVD]
--           ,MAX(iif([intaked]>0,feedtypec, '0'))     AS [feedTypeKVD]

--           ,sum([intaked]) AS [totalIntakeKVD]

--           from t_raw_hokofarmvb_apollo
--           GROUP BY DATE, COW
-- ) as vb on vb.date=t.dat and vb.cow=t.oornum
-- left join #temp on #temp.cow=t.oornum and #temp.date=t.dat     

-- where dat='2026-07-30'     and hok <>'sikk'
-- and ( numberOfVisitsKVStation>0 or totalIntakeRV1>0)

-- -- delete from t_raw_hokofarmcd_apollo where date='2026-07-30' 

-- delete from #oud where cow in (select cow from t_raw_hokofarmcd_apollo where date='2026-07-30' )
-- insert into t_raw_hokofarmcd_apollo select * from #oud

select 'bekijk de broncde en vvoer de stappen uit'  as doc  from t_raw_hokofarmcd_apollo
