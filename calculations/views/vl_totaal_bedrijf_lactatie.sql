-- SET ANSI_NULLS ON
-- GO
-- SET QUOTED_IDENTIFIER ON
-- GO
CREATE VIEW [dbo].[VL_totaal_bedrijf_lactatie]
as

    select * from vl_totaal_sub_lactatie
    -- select  
    --     cast(dat as date) as Dat,
    --     cal.animalserverid, 

    --     iif(calvingdate=birthdate, 0, lactationno) as LacNum
    --     , datediff(dd,  calvingdate, dat) as LacDgn
    --     , datediff(dd,  BirthDate, dat) as LftDgn
    --     , DryOffDate as DrgZetDat
    --     , calvingdate as KlfDat
    --     , FertilizationMatingDate
    --     , ExpectedCalvingDate as VrwKlfDat
    --     , ExpectedDryOffDate as VrwDrgDat
    --     , '' as VlgKlfDat
    --     , iif(datediff(dd,  calvingdate, dat) > 0, 'Melk', iif(iif(calvingdate=birthdate, 0, lactationno)>0, 'Droog', 'Pink' )) as PrdSta


    --     from dbo.T_Animal_Calvings as cal
    --         join dbo.t_animals as a on a.animalserverid=cal.animalserverid
    --         join dbo.t_datum on cast(dat as date) >= cast(calvingdate as date)
    --         and cast(dat as date)<= cast(iif(LastRemovalMovementDate is null, iif(ExpectedDryOffDate is not null, ExpectedDryOffDate, '2040-01-01'), LastRemovalMovementDate) as date)
            
    --     where a.BirthDate<>calvingdate 
    --     and dat<getdate()

        
        



-- union all
-- SELECT  
--     dat, 
--     s.animalserverid, 

--     -- Verhoog lactatienummer als de datum na de verwachte kalfdatum ligt
--     IIF(dat > cal.ExpectedCalvingDate, cal.lactationno + 1, cal.lactationno) as lacnum,    

--     iif(calvingtype<>355,  datediff(dd,  iif(cal.ExpectedCalvingDate<=dat, ExpectedCalvingDate, calvingdate), dat), null)  as LacDgn,


--     LftDgn,
--     [GebDat],

--     -- Droogzetdatum: gebruik verwachte droogzetdatum indien in de toekomst
--     IIF(dat > cal.ExpectedCalvingDate, cal.ExpectedDryOffDate, cal.DryOffDate) as DrgZetDat, 

--     -- Kalfdatum: gebruik verwachte kalfdatum indien in de toekomst
--     IIF(dat > cal.ExpectedCalvingDate, cal.ExpectedCalvingDate, cal.calvingdate) as KlfDat, 

--     -- Mating Date leeglaten indien datum na verwachte kalfdatum ligt
--     IIF(dat > cal.ExpectedCalvingDate, NULL, cal.FertilizationMatingDate) as FertilizationMatingDate,

--     -- Verwachte Kalfdatum leeglaten indien datum na verwachte kalfdatum ligt
--     IIF(dat > cal.ExpectedCalvingDate, NULL, cal.ExpectedCalvingDate) as VrwKlfDat,

--     -- Verwachte Droogzetdatum leeglaten indien datum na verwachte kalfdatum ligt
--     IIF(dat > cal.ExpectedCalvingDate, NULL, cal.ExpectedDryOffDate) as VrwDrgDat,

--     -- Volgende kalfdatum leeglaten indien datum na verwachte kalfdatum ligt
--     IIF(dat > cal.ExpectedCalvingDate, NULL, VlgKlfDat) as VlgKlfDat,

--     -- Productiestatus aanpassen aan verwachte droogzetdatum
--     IIF(dat > cal.ExpectedCalvingDate, 
--         IIF(cal.ExpectedDryOffDate < dat, 'Melk', 'Droog'),
--         IIF(cal.DryOffDate > dat AND cal.lactationno > 0, 'Melk', IIF(calvingtype = 355, 'Pink', 'Droog'))) as PrdSta

-- FROM vl_totaal_sub_stal as s
-- LEFT JOIN   
-- ( 
--     SELECT *, LEAD(calvingdate) OVER (PARTITION BY animalserverid ORDER BY calvingdate) AS vlgKlfDat 
--     FROM t_animal_calvings
-- ) as cal 
--     ON s.animalserverid = cal.animalserverid 
--     AND cal.CalvingDate <= dat 
--     AND (dat < vlgKlfDat OR vlgKlfDat IS NULL)
-- WHERE dat > GETDATE()




-- SELECT  
--     dat, 
--     s.animalserverid, 
--     cal.lactationno as lacnum,    
--     iif(calvingtype<>355, datediff(dd,  (cal.calvingdate), dat), null)  as LacDgn,
--      LftDgn,
--      [GebDat],
--     (cal.DryOffDate) as DrgZetDat,
--     cal.calvingdate as KlfDat, 
--     (cal.FertilizationMatingDate) as FertilizationMatingDate,
--     (cal.ExpectedCalvingDate) as VrwKlfDat,
--     (cal.ExpectedDryOffDate) as VrwDrgDat,    
--     VlgKlfDat  ,

--     iif(dryoffdate is null and (cal.lactationno) > 0, 'Melk', iif(calvingtype=355, 'Pink','Droog')) as PrdSta



-- from vl_totaal_sub_stal as s
-- left join   
-- ( select * , LEAD(calvingdate) OVER (PARTITION BY animalserverid ORDER BY calvingdate) AS vlgKlfDat 
--     from t_animal_calvings
-- )
-- as cal on s.animalserverid=cal.animalserverid and CalvingDate<=dat and (dat<vlgKlfDat or vlgKlfDat is null)

-- union all
-- SELECT  
--     dat, 
--     s.animalserverid, 

--     -- Verhoog lactatienummer als de datum na de verwachte kalfdatum ligt
--     IIF(dat > cal.ExpectedCalvingDate, cal.lactationno + 1, cal.lactationno) as lacnum,    

--     iif(calvingtype<>355,  datediff(dd,  iif(cal.ExpectedCalvingDate<=dat, ExpectedCalvingDate, calvingdate), dat), null)  as LacDgn,


--     LftDgn,
--     [GebDat],

--     -- Droogzetdatum: gebruik verwachte droogzetdatum indien in de toekomst
--     IIF(dat > cal.ExpectedCalvingDate, cal.ExpectedDryOffDate, cal.DryOffDate) as DrgZetDat, 

--     -- Kalfdatum: gebruik verwachte kalfdatum indien in de toekomst
--     IIF(dat > cal.ExpectedCalvingDate, cal.ExpectedCalvingDate, cal.calvingdate) as KlfDat, 

--     -- Mating Date leeglaten indien datum na verwachte kalfdatum ligt
--     IIF(dat > cal.ExpectedCalvingDate, NULL, cal.FertilizationMatingDate) as FertilizationMatingDate,

--     -- Verwachte Kalfdatum leeglaten indien datum na verwachte kalfdatum ligt
--     IIF(dat > cal.ExpectedCalvingDate, NULL, cal.ExpectedCalvingDate) as VrwKlfDat,

--     -- Verwachte Droogzetdatum leeglaten indien datum na verwachte kalfdatum ligt
--     IIF(dat > cal.ExpectedCalvingDate, NULL, cal.ExpectedDryOffDate) as VrwDrgDat,

--     -- Volgende kalfdatum leeglaten indien datum na verwachte kalfdatum ligt
--     IIF(dat > cal.ExpectedCalvingDate, NULL, VlgKlfDat) as VlgKlfDat,

--     -- Productiestatus aanpassen aan verwachte droogzetdatum
--     IIF(dat > cal.ExpectedCalvingDate, 
--         IIF(cal.ExpectedDryOffDate < dat, 'Melk', 'Droog'),
--         IIF(cal.DryOffDate > dat AND cal.lactationno > 0, 'Melk', IIF(calvingtype = 355, 'Pink', 'Droog'))) as PrdSta

-- FROM vl_totaal_sub_stal as s
-- LEFT JOIN   
-- ( 
--     SELECT *, LEAD(calvingdate) OVER (PARTITION BY animalserverid ORDER BY calvingdate) AS vlgKlfDat 
--     FROM t_animal_calvings
-- ) as cal 
--     ON s.animalserverid = cal.animalserverid 
--     AND cal.CalvingDate <= dat 
--     AND (dat < vlgKlfDat OR vlgKlfDat IS NULL)
-- WHERE dat > GETDATE()


-- GO
