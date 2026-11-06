-- SET ANSI_NULLS ON
-- GO
-- SET QUOTED_IDENTIFIER ON
-- GO
-- -- -- SET ANSI_NULLS ON
-- -- -- GO
-- -- -- SET QUOTED_IDENTIFIER ON
-- -- -- GO
-- -- -- -- verbeterde stal query gebaseerd op het idee van HVDH
-- -- -- -- 2023-10-16 hierbij is rekening gehouden met dieren die na 15:00 uur verplaatst worden, die verhuizing wordt dan de volgende dag geteld
CREATE VIEW [dbo].[VL_Totaal_sub_stal]
as
 select 
    distinct
        dat as Dat, 
        datepart(yy, dat) as Jar,
        datepart(ww, dat) as Wek,
        DATEPART(dw, Dat) AS WekDag, 

        birthdate as GebDat,
        datediff(dd, birthdate, dat) as LftDgn,
        mov.animalserverid as AnimalServerId, 
        mov.animalno as OorNum, 
        a.RegistrationId as LevNum, 
        
        hok as Hok,


        iif(LAG(hok ,1)  OVER (  PARTITION BY mov.animalserverid  ORDER BY dat asc) <>hok , LAG(hok ,1)  OVER (  PARTITION BY mov.animalserverid  ORDER BY dat asc) , '' ) as [HokMin1],


        stl as Stl,
        beg as BegDat, 

        [end] as enddat
    from (
        select            
            animalserverid, 
            animalno, 
            DairyFarmSiteAbbr as hok, 
            DairyFarmSiteAbbr as stl, 
            movementdate as beg, 
            LAG(movementdate ,1) 
            OVER (
                PARTITION BY animalserverid
                ORDER BY movementid desc) as [end]
        from (
            select 
                animalserverid,     
                animalno, DairyFarmSiteAbbr,
                iif(datepart( HH, movementtime)>15, dateadd(dd, 1, movementdate), movementdate) as movementdate, 
                movementid , 
                movementtime
            from 
                dbo.t_animal_movements 
            where 
                dairysiteid is not null
        ) as t_animal_movements 

    ) as mov 

    join (
            select 
                birthdate,
                 animalserverid, 
                 animalno,  
                 registrationid , 
                 LastRemovalMovementDate
            from 
                dbo.t_animals 
            where 
                birthdate is not null
    )  as a on mov.animalserverid=a.animalserverid
    
    join 
        dbo.t_datum on dat>=beg and dat<iif([end] is null, dateadd(dd, 100, getdate()), [end]) and dat<=iif(a.LastRemovalMovementDate is null, dateadd(dd, 100, getdate()), a.LastRemovalMovementDate)
    
    where 
        mov.animalserverid is not null
        and dat is not null 
        and hok is not null



-- and mov.animalserverid=13712
-- controle of de stal query geen dubbele rijen oplevert, belangrijk als er iets wordt aangepzst
-- select dat,  animalserverid  , count(*) from vl_totaal_sub_stal  group by dat, animalserverid having count(*)>1 order by dat desc
-- select * from t_animal_movements where animalserverid=13712 and movementdate in ('2022-05-22', '2022-05-23','2022-05-24', '2022-05-25'   )
-- select * from vl_totaal_sub_stal where  oornum=4191  and  dat in ('2022-05-22', '2022-05-23','2022-05-24', '2022-05-25'   )


-- GO

