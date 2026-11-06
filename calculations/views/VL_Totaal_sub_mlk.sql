-- SET ANSI_NULLS ON
-- GO
-- SET QUOTED_IDENTIFIER ON
-- GO
CREATE view  [dbo].[VL_Totaal_sub_mlk] as 
select 
    imdat, 
    cow, 
    sum(kgmlko) as kgmlko,
    sum(kgmlka) as kgmlka,
    sum(antmlko) as antmlko,
    sum(antmlka) as antmlka,
    sum(kgmlketm) as kgmlketm,
    sum(kgetmGea) as kgetmGea,
    sum(kgmlkrobot) as kgmlkrobot,
    avg(cfc) as cfc

from (
    select 
        cast(imdat as date) as imdat,
        cow, 
        cast(sum(iif(datepart(hh, imdat) < 12, imwt * 0.01,0)) as decimal(10,2)) as kgmlko,
        cast(sum(iif(datepart(hh, imdat) > 12, imwt * 0.01,0)) as decimal(10,2)) as kgmlka,
        sum(iif(datepart(hh, imdat) < 12, 1,0)) as antmlko,
        sum(iif(datepart(hh, imdat) > 12, 1,0)) as antmlka,        
        cast(sum(imwt * 0.01) as decimal(10,2)) as kgmlketm, 
        cast(sum(imwt * 0.01) as decimal(10,2)) as kgetmGea, 
        cast(0 as decimal(10,2)) as kgmlkrobot ,
        sum(cast(cfc as real)) as cfc
    FROM 
        dbo.T_RAW_gea_milk 
    where 
        imwt>0 and imstall<>0
    group by 
        cast(imdat as date) ,  cow
    union ALL
    select 
        cast(milkingdatedt as date)   as imdat,
        animalno as cow, 
        sum(iif(datepart(hh, cast(milkingtime as datetime)) < 12, cast(milkquantitymass as decimal(10,2)) ,0)) as kgmlko,
        sum(iif(datepart(hh, cast(milkingtime as datetime)) > 12, cast(milkquantitymass as decimal(10,2)) ,0)) as kgmlka,
        sum(iif(datepart(hh, cast(milkingtime as datetime)) < 12, 1,0)) as antmlko,
        sum(iif(datepart(hh, cast(milkingtime as datetime)) > 12, 1,0)) as antmlka,        
        sum(cast(milkquantitymass as decimal(10,2))) as kgmlketm, 
        0 as kgetmGea, 
        sum(cast(milkquantitymass as decimal(10,2))) as kgmlkrobot,
        0 as cfc
    FROM 
        dbo.tb_animal_milkings 
    where 
        milkingplace=0 and MilkQuantityMass>0
    group by 
        milkingdatedt,  animalno

) as mlktot

-- where cow =1040 and kgmlketm <0

group by imdat, cow
