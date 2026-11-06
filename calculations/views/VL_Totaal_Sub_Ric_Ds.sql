
CREATE view  [dbo].[VL_Totaal_Sub_Ric_Ds]  
with SCHEMABINDING as 
-- deze view wordt in de ric tabel gebruikt om de ds in de totaal tabel te berekenen
-- het is en view met schemabinding dus wordt sneller??
select 

    cast(date as date) as date,
    groupname ,
    sum(performedproductkgafterdrop) as totaalGeladen, 
    
    sum(iif(ingredientname='water',performedproductkgafterdrop,0)) as waterKg, 
    sum(iif(ingredientname='water',performedproductkgafterdrop,0))/sum(performedproductkgafterdrop)  as waterPct, 

    sum(iif(ingredientname<>'water',performedproductkgafterdrop,0)) as prodKg, 
    sum(iif(ingredientname<>'water',performedproductdryweightkgafterdrop,0)) as dsKg , 
    sum(iif(ingredientname<>'water',performedproductdryweightkgafterdrop,0)) / sum(iif(ingredientname<>'water',performedproductkgafterdrop,0))  as dsPct
    -- , avg(ds) as droogstoofpct
from (
    select 
        date, 
        groupname, 
        performedproductkgafterdrop , 
        ingredientname ,
        performedproducterror ,
        performedproductdryweightkgafterdrop
    FROM dbo.t_raw_trioliet 
        where (not (ingredientname='water' and performedproducterror=performedproductkgafterdrop)) and logsource=0
) as t_raw_trioliet 
-- left join (
--     SELECT 
--             objcod
--         ,[datmon]
--         ,avg([DrgStfGkg]/1000) as ds
--     FROM 
--         [dbo].[T_Droogstoof_WeegLijst]
--     group by 
--         datmon, objcod
-- ) as drgstf on datmon=cast(date as date) and ingredientname=ObjCod



group by 
    cast(date as date), groupname
    
having sum(performedproductkgafterdrop)>0    
-- deze conditie heb ik uit VL_totaal_sub_ric_opn gehaald 15-11-2024 omdat ik niet helemaal wist waarom het daar stond maar daardoor geen voeropnamen zonder trioliet zichtbaar waren
