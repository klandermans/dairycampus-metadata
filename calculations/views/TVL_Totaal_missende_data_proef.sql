-- SET ANSI_NULLS ON
-- GO
-- SET QUOTED_IDENTIFIER ON
-- GO

create view [dbo].[TVL_Totaal_missende_data_proef] as 
-- GO

SELECT
    CAST (tot.dat AS DATE) as date,
    cast(tot.oornum as int) as oornum, 
    iif(prfcod is null, '', prfcod) as prfcod, 
    hok  as hok, 
    prdsta, 
    behcod, 
    iif(lacnum>0 and prdsta='Melk' and (kgmlko is null or kgmlko=0), 'X','') as kgmlko,
    iif(lacnum>0 and prdsta='Melk' and (kgmlka is null or kgmlka=0), 'X','') as kgmlka,
    iif(lacnum>0 and hok<>'10' and hok<>'50' and hok<>'51' and gewo is null AND tot.dat not between  '2020-07-21' AND '2020-09-08', 'X','')  as gewo,
    iif(lacnum>0 and hok<>'10' and hok<>'50' and hok<>'51' and gewa is null AND tot.dat not between  '2020-07-21' AND '2020-09-08', 'X','')  as gewa,


    -- iif(lacnum>0 and hok<>10 and hok<>50 and hok<>51 and (gewgeao is null or gewgeao=0) AND tot.dat not between  '2020-07-21' AND '2020-09-08', 'X','')  as gew_gea_o,
    IIF(gewgeao>1, gewgeao, '') AS gewgeao,
    -- iif(lacnum>0 and hok<>10 and hok<>50 and hok<>51 and (gewgeao is null or gewgeao=0) AND tot.dat not between  '2020-07-21' AND '2020-09-08', 'X','')  as gew_gea_o,

    -- iif(lacnum>0 and hok<>10 and hok<>50 and hok<>51 and (gewgeaa is null or gewgeaa=0) AND tot.dat not between  '2020-07-21' AND '2020-09-08', 'X','')  as gew_gea_a,
    IIF(gewgeaa<>0, gewgeaa, '') AS gewgeaa,

    iif(left(hok,1)='3' and (intake is null or intake=0) , 'X','') as opnrv,
    iif( prdsta = 'Melk'  and tegoed>0 and rest=tegoed and hok<>'34' and hok<>'51', 'X','') as opnkv,
    iif(lacnum>0 and hok<>'10' and hok<>'50' and hok<>'51' and prdsta='Melk'  , 'X','')    as bcs,    
    iif(velos_behaviour.cnt>50000 and prdsta='Melk'  , '', 'X')    as velos,    

    concat(concat(DisorderDesc,' ',MedicineDesc) 
      ,(
        select 
            distinct  concat('takovergang: ',cast(max(MovementDateDT) as date)) as mvdt
        FROM 
            t_animal_movements
        where 
            MainEntityTypeMain='movementsupply' and  Animalno=oornum and MovementDateDT>dateadd(dd, -7, cast(getdate() as date))
        group by animalserverid
        having max(MovementDateDT) is not null
      )) as bijzonderheden 
    -- concat('<a href="https://dairycampus.azurewebsites.net/?cow=',tot.oornum,'&date=',CAST(tot.dat AS DATE),'" target=_blank>Feedback</a>')
from (
    select distinct dat, oornum, dienum, lacnum, hok as hok, prdsta  , lacdgn
    from tvl_dier_datum_stal
    where hok<>'LH' and hok<>'lh' 
)  as tot
left join (
    select distinct 
        dat, dienum, kgmlka, kgmlko 
    from TVL_Dier_Melkgift_Etmaal_Melkcontrole

) as mlk on tot.dat=mlk.dat and tot.dienum=mlk.dienum
left join (
    select distinct 
        dat, dienum, gewo, gewa 
    from 
        TVL_Dier_Gewicht_Etmaal
    where 
        dat not between  '2020-07-21' AND '2020-09-08'

) as gew on tot.dat=gew.dat and tot.dienum=gew.dienum

left join (
    
    select cast(date as date) as datt
        , cow
        , sum(iif(datepart(hh, date)  < 12 ,[weight],null)) as gewgeao
        , sum(iif(datepart(hh, date)  > 12 ,[weight],null)) as gewgeaa
    from T_RAW_Gea_Gewicht
    group by cast(date as date), cow

) as gewgea on tot.dat=gewgea.datt and tot.oornum=gewgea.cow

left join (
    select distinct 
        dat, dienum, prfcod , behcod
    from tvl_dier_datum_proef

) as prf on tot.dat=prf.dat and tot.dienum=prf.dienum

left join (
    select  animalno, feedstartperioddate, 
        sum(iif( processcomputerid=1 or processcomputerid=3 or QuantityRemainFeed<>quantityprogrammed, quantityprogrammed,0)) as tegoed, 
        sum(iif( processcomputerid=1 or processcomputerid=3 or QuantityRemainFeed<>quantityprogrammed, quantityprogrammed,0))-sum(quantityprogrammed-QuantityRemainFeed)  as rest 
    from  t_animal_feedings group by feedstartperioddate, animalno)  as  feed on FeedStartPeriodDate=tot.dat and feed.animalno=tot.oornum
left join (
    select  cow, cast(date as date) as date, sum(intake)  as intake 
    from t_RAW_HokofarmVR group by cow, cast(date as date))  as  rv on rv.date=tot.dat and rv.cow=tot.oornum
left join (
    select distinct 
        cow, date, round(bcs ,1) as bcs
    from 
        T_RAW_Laval_BCS
    where date not between '2020-07-01' AND  '2020-09-01'
) as bcs on bcs.cow=tot.oornum and cast(bcs.date as date)=cast(tot.dat as date)
left join 
    T_Animal_TreatmentActions as treat on treat.animalno=tot.oornum and treat.treatmentdate=tot.dat
left join 
    T_Animal_Diagnosis as dia on dia.animalno=tot.oornum and dia.diagnosisdate=tot.dat
left join (
    select 
        cast(date as date) as date, 
        cow, 
        sum(duration) as cnt 
    from t_raw_velos_behaviour
    group by cast(date as date), cow
) as velos_behaviour
on velos_behaviour.cow=tot.oornum and velos_behaviour.date=tot.dat
where (
      lacdgn>0  and lacnum>0 and hok<>'10' and prdsta='Melk' and (kgmlko is null or kgmlko = 0)
    or lacdgn>0 and lacnum>0 and hok<>'10' and prdsta='Melk' and (kgmlka is null or kgmlka = 0)
    or lacdgn>0 and lacnum>0 and hok<>'10' and prdsta='Melk' and (gewa is null and gewo is NULL)
    or (velos_behaviour.cnt is null or velos_behaviour.cnt<50000)  
    or left(hok,1)='3' and (intake is null or intake=0)  and behcod <> 'wei'
    or prdsta = 'Melk' and tegoed>0 and rest=tegoed and hok<>'34'
    -- or lacdgn>0 and lacnum>0 and hok<>10 and hok<>50 and hok<>51 and prdsta='Melk' AND bcs is null
)
and len(hok) < 3
and tot.dienum in (
    select animalserverid 
    from t_animals where isonfarm=1
)











-- order by  cast(tot.oornum as int)
