CREATE view [dbo].[VL_totaal_tmr] as 
select *

-- , (select sum([C21-10]+[C21-9]) from tvl_totaal where hok=groep and dat=date) as gea

 from (
    select  *  from ( 
        select
            cast(date as date) as date,
            '' as mixloadername, 
            groep COLLATE DATABASE_DEFAULT  as groep,
            animals as dierenInTmr,
            (select count(distinct oornum) from tvl_dier_datum_stal where dat=cast(date as date) and hok COLLATE DATABASE_DEFAULT = groep COLLATE DATABASE_DEFAULT ) as dierenInCowvision,
            [Display Naam],
            -- 60,61,70,72
            [Omschrijving.1],
            los as los,
            0 as rest,

            sum(kgProd) as kgProd
            ,sum(kgProd*ds) as kgDsVolgensTrioliet
            ,ds
            ,nullif(sum(kgProd*ds),0) / nullif(animals,0) as dsDier
            ,'tmrtracker' as TMR
        from (
            SELECT
                lev.[Batch Datum] as [Date],
                lev.[Batch Tijd],
                lev.[Display Naam.1],
                replace(replace(replace(replace(lev.[Display Naam.1], 'a',''), 'Stl',''), 'St',''),'INNOC','') as groep,
                lad.[Display Naam],
                lad.[Omschrijving.1],
                lev.[Werkel. Gewicht] * pct as kgProd,
                lev.[Werkel. Gewicht] as los,
                lad.ds as ds,
                pct, 
                lev.[Dier Aantal.1] as animals

            FROM (
                SELECT
                    *
                FROM
                    [dbo].[T_Raw_Tmr]
                WHERE
                    [Lading/Levering] = 'Levering'
            ) AS lev

            left join (
                SELECt
                    [T_Raw_Tmr].[Batch Datum],
                    [T_Raw_Tmr].[Batch Tijd],
                    [display naam],
                    [Werkel. Gewicht] ,
                    cast(cast([Werkel. Gewicht] as float)/ nullif(dt,0) as float) as pct,
                    [T_Raw_Tmr].[Droge stof %]*0.01 as ds,
                    [T_Raw_Tmr].[Omschrijving.1]
                FROM
                    [dbo].[T_Raw_Tmr]

                LEFT JOIN (
                    SELECT
                        s.[Batch Datum],
                        s.[Batch Tijd],
                        sum([Werkel. Gewicht]) as dt
                    from
                        [dbo].[T_Raw_Tmr]  as s
                    where
                        s.[Lading/Levering] = 'Lading'
                    group by
                        s.[Batch Datum],
                        s.[Batch Tijd]
                ) as sub on  sub.[Batch Datum] =[T_Raw_Tmr].[Batch Datum]  and sub.[Batch Tijd] =T_Raw_Tmr.[Batch Tijd]

                where [Lading/Levering] = 'Lading'

            ) as lad on lev.[Batch Datum] = lad.[Batch Datum] and lev.[Batch Tijd]=lad.[Batch Tijd]


        ) as herman
        where

        left([Display Naam.1] ,1) = 's'
        
        
        group by [date], groep, [Display Naam], ds,[Omschrijving.1], animals, los
    ) as tmrtracker

    union all

    select * from  (

    

        select  
                cast(loaddate as date) as date
                , 'unknown ' as mixLoaderName 
                , penname as groep
                , mix.numberofanimals as dierenInTmr
                , avg(dierenInCowvision) as dierenInCowvision
                , ingredientname as [display naam]
                , ingredientname as [Omschrijving.1]
                , avg(total) as served
                , 0 as leftover
                , quantity as kgProd
                , avg(ds)*sum(distinct quantity) as kgDsVolgensTMR -- dit is dus niet goed, want hij doet nu een avg ds per ingredient berekend ov.v. b. het totaal 
                , avg(ds)  as dm
                , 0 as dm_dier
                ,'feedlync' as TMR
                
        from 
            T_RAW_Feedlync_LoadsByPenIngredients as ing
        left join (
            select  
                quantity as total,
                drymatterQuantityPerAnimal *  numberofanimals as totalads,
                right(penname,2) as penname, 
                unloadPenId as unloadPenId, 
                loaddate , 
                numberofanimals ,
                drymatterQuantityPerAnimal,
                 (drymatterQuantityPerAnimal *  numberofanimals) / (    quantity-iif(leftOverQuantity>0, leftOverQuantity, 0)) as ds
            from  
                T_RAW_Feedlync_LoadsByPen 
            where quantity>0 
        ) as mix on  mix.unloadPenId=ing.unloadPenId 

        left join  (
            select 
                hok, dat, count(distinct oornum)  as dierenInCowvision
            from 
                TVL_totaal_bedrijf
            group by hok, dat
        ) as totaal on totaal.dat=cast(loaddate as date)  and totaal.hok COLLATE DATABASE_DEFAULT = penname COLLATE DATABASE_DEFAULT

        where 
            loaddate>'2023-10-02T09:26:20.814Z' 
        group by    
               
            cast(loaddate as date), numberofanimals ,ingredientname , penname , quantity




    ) as feedlync


    union all 
    (
        select 
        cast(date as date) as date

        ,mixLoaderName
        ,groep
        , noOfAnimals as dierenInTmr
        ,(select count(distinct oornum) from tvl_dier_datum_stal where dat=cast(date as date)  and hok COLLATE DATABASE_DEFAULT = groep COLLATE DATABASE_DEFAULT ) as dierenInCowvision
        ,feedstuffname as [display naam]
        ,feedstuffname as [Omschrijving.1]
        ,max(quantity) as served
        ,max(leftover) as served
        ,sum(intakeProd) as kgProd
        ,sum(intakedm) as kgDsVolgensTMR
        ,sum(intakedm) / nullif(sum(served),0)  as dm
        ,sum(nullif(intakedm,0)/nullif(noOfAnimals,0)) as dm_dier
        ,'cowconnect' as TMR
    from (
        select  
                mix.date, 
                mix.feedplanname, 
                mixloadername, 
                noOfAnimals as noOfAnimalsInCowconnect,
                groep, 
                noOfAnimals,
                -- cnt as animalsInGroep,
                -- feedsectionname.replace('Groep','') ,
                -- cast(feedsectionname.replace('Groep','') as int),
                los.quantity, 
                los.leftoverquantity, 
                feedstuffname, pct*(los.quantity ) as served, 
                los.leftoverquantity as leftover, 
                pct*(los.quantity-isnull(los.leftoverquantity,0) ) as intakeProd,
                pct*(los.quantity-isnull(los.leftoverquantity,0) )*laad.drymatter * 0.01 as intakeDm
                ,drymatter
        from (
            select distinct *, cast(cast(replace(replace(feedsectionname,'A',''),'Groep','') as int) as varchar) as groep from t_raw_cowconnect_drop  as los
        ) as los 
        left join (
            select 
                distinct 
                laad.externalMixTaskId, 
                feedstuffname,  
                percentageOfLoad, 
                cast(quantity as float)/nullif(total,0)  as pct, 
                iif(feedstuffname='Water',0,drymatter) as drymatter

            from t_raw_cowconnect_load as laad
            left join (
                select distinct
                    externalMixTaskId, 
                    sum(quantity) as total 
                from t_raw_cowconnect_load  as laad
                group by externalMixTaskId) as total on total.externalMixTaskId=laad.externalMixTaskId
        ) as laad on laad.externalMixTaskId=los.externalMixTaskId
        left join (
            select distinct * from t_raw_cowconnect_mix) as mix on mix.id=los.externalMixTaskId
    ) as cowconnect
    group by     
        cast(date as date) 
        ,groep
        ,feedstuffname 
        ,feedstuffname 
        ,noOfAnimals
        ,mixloadername
    )
) as asdf 
