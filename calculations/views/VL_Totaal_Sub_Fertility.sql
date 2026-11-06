create view VL_Totaal_Sub_Fertility 
as 

 select 
        dat as Dat, 
        mov.animalserverid as AnimalServerId, 
        mov.animalno as OorNum,         
        [state],
        vrwklfdat,
        beg as drachtcontrole,
        DATEDIFF(dd,  dateadd(dd, -280, vrwklfdat) ,dat ) as drachtdgn

    from (
    
  
    select *, 
            LAG(beg ,1) 
            OVER (
                PARTITION BY animalserverid
                ORDER BY beg desc) as [end]
            

    from (

        select            
            animalserverid, 
            animalno, 
            FertilityStateDate as beg, 
            AssumedPregnancyDate as insdat, 
            iif(FertilityStateTypeName='Pregnant', dateadd(dd, 280, AssumedPregnancyDate) , null) as VrwKlfDat, 
            FertilityStateTypeName as [state]
        from T_Animal_FertilityStatus
        union all 
        select 
            t_animal_calvings.animalserverid, 
            t_animal_calvings.animalno, 
            calvingdate as beg, 
            null as insdat,
            null as VrwKlfDat, 
            'Not pregnant' as [state]
        from 
            t_animal_calvings
            left join t_animals on t_animals.animalserverid=t_animal_calvings.animalserverid
            where calvingdate<>birthdate

        union all 
        select 
            animalserverid, 
            animalno, 
            matingdate as beg, 
            matingdate as insdat,
            dateadd(dd, 280, matingdate) as VrwKlfDat, 
            'Inseminated' as [state]
        from 
            t_animal_matings
    ) as asfd        

    ) as mov 
    join dbo.t_animals as a on mov.animalserverid=a.animalserverid
    join dbo.t_datum on dat>=beg and dat<iif([end] is null, dateadd(dd, 280, getdate()), [end]) and dat<iif(a.LastRemovalMovementDate is null, dateadd(dd, 100, getdate()), a.LastRemovalMovementDate)


-- where mov.animalno=7963
-- order by dat desc
