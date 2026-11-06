CREATE view [dbo].[_dev_opname_per_dag] as 
SELECT  
    d.date, 
    [cow]
    ,d.[ingredientname]
    ,sum(intake) as intake
    ,sum(opn) as opname_controle
    ,avg(dm.dm*0.01) as dm
    ,avg(dm7.dm*0.01) as dm7
    ,avg(dm.dm*0.01)*sum(intake) as opnDs

    ,IIF(avg(dm7.dm*0.01)>0, avg(dm7.dm*0.01), avg(dm.dm*0.01))*sum(intake) as opnDs7

    ,abs(1-(avg(dm.dm*0.01)*sum(intake))/(avg(dm7.dm*0.01)*sum(intake))) as DIFF

FROM 
    [dbo].[_dev_intake_per_bezoek_per_product] as d
left join 
    (
        select 
            date, ingredientname, avg(ScheduledDryWeightContent) as dm from t_raw_trioliet group by date, ingredientname
    )  as dm on dm.ingredientname = d.ingredientname and dm.date = d.date
left join 
    (
        select 
            date, ingredientname, avg(ScheduledDryWeightContent) as dm from t_raw_trioliet group by date, ingredientname
    )  as dm7 on dm7.ingredientname = d.ingredientname and dateadd(dd, 7, dm7.date) = d.date

-- WHERE D.date='2024-04-01' AND COW=1740
where d.ingredientname<>'water'
group by d.date, cow, d.ingredientname
-- order by cow, ingredientname

