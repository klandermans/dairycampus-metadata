CREATE view   VL_totaal_sub_drogestof_nieuwe_methode as 
SELECT 
    vr.date, 
    starttime, 
    cow, intake, 
    ingredientname, 
    round(ratio_prod * intake,2) as intakeprod
    , round(iif(IngredientName<>'water',ratio_prod * intake *ds,0 ),2) as OpnDSTrioliet
    , round(iif(IngredientName<>'water',ratio_prod * intake *dsds,0 ) ,2)as OpnDroogstoof
    , round(iif(IngredientName<>'water',ratio_prod * intake *week_avg,0 ) ,2)as OpnDroogstoofweek
    , round(ds,2) as ds_trio
    , round(dsds,2) as ds_droogstoof
    , round(week_avg,2) as ds_droogstoofWeek
FROM 
    T_RAW_HOKOFARMVR as vr
left join (
    SELECT 
        date, 
        GroupName,
        ingredientname, 
        sum(PerformedProductKgAfterDrop) as tot_prod,
        sum(PerformedProductKgAfterDrop) / SUM(sum(PerformedProductKgAfterDrop)) OVER(PARTITION BY [DATE],GroupName) as ratio_prod,
        sum(PerformedProductDryWeightKgAfterDrop) / SUM(sum(PerformedProductDryWeightKgAfterDrop)) OVER(PARTITION BY [DATE],GroupName) as ratioDS,
        sum(ScheduledDryWeightKg) / sum(ScheduledProductKg) AS DS
    FROM 
        [dbo].[T_RAW_Trioliet]
    where 
        PerformedProductKgAfterDrop > 0 
    group by  date, ingredientname,GroupName
) as mengsel on vr.date=mengsel.date and vr.feedtype=groupname
left join (
SELECT 
    objcod,
    datmon,
    daily_avg as dsds,
    AVG(daily_avg) OVER (PARTITION BY objcod ORDER BY datmon ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) AS week_avg
FROM 
    (    SELECT 
        objcod,
        datmon,
        AVG(CAST(drggew-blkgew AS FLOAT) / CAST(vrsgew-blkgew AS FLOAT)) AS daily_avg
    FROM 
        t_droogstoof_weeglijst
    WHERE 
        objcod IS NOT NULL 
        AND drggew > 0
    GROUP BY 
        objcod, datmon
    ) AS daily_avg
) as droostf on datmon=dateadd(dd, -0, vr.date) and IngredientName=objcod
-- where vr.date = '2024-02-01' and cow=1716




-- SELECT 
--     objcod,
--     datmon,
--     AVG(CAST(drggew AS FLOAT) / CAST(vrsgew AS FLOAT)) OVER (PARTITION BY objcod, datmon ORDER BY datmon) AS dsds,
--     AVG(CAST(drggew AS FLOAT) / CAST(vrsgew AS FLOAT)) OVER (PARTITION BY objcod ORDER BY datmon ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) AS week_avg
-- FROM 
--     t_droogstoof_weeglijst
-- WHERE 
--     objcod IS NOT NULL 
--     AND drggew > 0



