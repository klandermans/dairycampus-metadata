CREATE VIEW [dbo].[VL_Totaal_sub_lactatie]
as
SELECT  

    dat, 
    s.animalserverid, 
    cal.lactationno as lacnum,    
    iif(calvingtype<>355, datediff(dd,  (cal.calvingdate), dat), null)  as LacDgn,
     LftDgn,
    [GebDat],
    (cal.DryOffDate) as DrgZetDat,
    cal.calvingdate as KlfDat, 
    (cal.FertilizationMatingDate) as FertilizationMatingDate,
    (cal.ExpectedCalvingDate) as VrwKlfDat,
    (cal.ExpectedDryOffDate) as VrwDrgDat,    
    VlgKlfDat  ,

    iif((dryoffdate is null or dryoffdate > dat) and (cal.lactationno) > 0, 'Melk', iif(calvingtype=355, 'Pink','Droog')) as PrdSta



from tvl_totaal_sub_stal as s
left join ( 
    select 
        * , LEAD(calvingdate) OVER (PARTITION BY animalserverid ORDER BY calvingdate) AS vlgKlfDat 
    from 
        t_animal_calvings
)
as cal on s.animalserverid=cal.animalserverid and CalvingDate<=dat and (dat<vlgKlfDat or vlgKlfDat is null)

union all
SELECT  
    dat, 
    s.animalserverid, 

    -- Verhoog lactatienummer als de datum na de verwachte kalfdatum ligt
    IIF(dat > cal.ExpectedCalvingDate, cal.lactationno + 1, cal.lactationno) as lacnum,    

    iif(calvingtype<>355,  datediff(dd,  iif(cal.ExpectedCalvingDate<=dat, ExpectedCalvingDate, calvingdate), dat), null)  as LacDgn,


    LftDgn,
    [GebDat],

    -- Droogzetdatum: gebruik verwachte droogzetdatum indien in de toekomst
    IIF(dat > cal.ExpectedCalvingDate, cal.ExpectedDryOffDate, cal.DryOffDate) as DrgZetDat, 

    -- Kalfdatum: gebruik verwachte kalfdatum indien in de toekomst
    IIF(dat > cal.ExpectedCalvingDate, cal.ExpectedCalvingDate, cal.calvingdate) as KlfDat, 

    -- Mating Date leeglaten indien datum na verwachte kalfdatum ligt
    IIF(dat > cal.ExpectedCalvingDate, NULL, cal.FertilizationMatingDate) as FertilizationMatingDate,

    -- Verwachte Kalfdatum leeglaten indien datum na verwachte kalfdatum ligt
    IIF(dat > cal.ExpectedCalvingDate, NULL, cal.ExpectedCalvingDate) as VrwKlfDat,

    -- Verwachte Droogzetdatum leeglaten indien datum na verwachte kalfdatum ligt
    IIF(dat > cal.ExpectedCalvingDate, NULL, cal.ExpectedDryOffDate) as VrwDrgDat,

    -- Volgende kalfdatum leeglaten indien datum na verwachte kalfdatum ligt
    IIF(dat > cal.ExpectedCalvingDate, NULL, VlgKlfDat) as VlgKlfDat,

    -- Productiestatus aanpassen aan verwachte droogzetdatum
    IIF(dat > cal.ExpectedCalvingDate, 
        IIF(cal.ExpectedDryOffDate < dat, 'Melk', 'Droog'),
        IIF(cal.DryOffDate > dat AND cal.lactationno > 0, 'Melk', IIF(calvingtype = 355, 'Pink', 'Droog'))) as PrdSta

FROM tvl_totaal_sub_stal as s
LEFT JOIN   
( 
    SELECT *, LEAD(calvingdate) OVER (PARTITION BY animalserverid ORDER BY calvingdate) AS vlgKlfDat 
    FROM t_animal_calvings
) as cal 
    ON s.animalserverid = cal.animalserverid 
    AND cal.CalvingDate <= dat 
    AND (dat < vlgKlfDat OR vlgKlfDat IS NULL)
WHERE dat > GETDATE()

