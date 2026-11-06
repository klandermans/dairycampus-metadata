CREATE view [dbo].[VL_totaal_sub_ric_opn] 
-- with schemabinding 
as 
SELECT  
    cast(tot.[Date] as date) as Dat
    , tot.cow
    , isnull(rv1.opnProd,0)+isnull(rv2.opnProd,0)+isnull(rv3.opnProd,0)+isnull(rv4.opnProd,0) as 'tot.Prod'
    ,
    ISNULL(((rv1.opnMinWater * rv1.dsPct) / NULLIF(rv1.opnProd, 0)) * rv1.opnProd, 0) +
    ISNULL(((rv2.opnMinWater * rv2.dsPct) / NULLIF(rv2.opnProd, 0)) * rv2.opnProd, 0) +
    ISNULL(((rv3.opnMinWater * rv3.dsPct) / NULLIF(rv3.opnProd, 0)) * rv3.opnProd, 0) +
    ISNULL(((rv4.opnMinWater * rv4.dsPct) / NULLIF(rv4.opnProd, 0)) * rv4.opnProd, 0) AS 'tot.opnDs'


    ,rv1.name as 'rv1.name'
    ,rv1.opnProd as 'rv1.Prod'
    ,rv1.opnMinWater as 'rv1.ProdExclWater'
    ,(rv1.opnMinWater*rv1.dsPct) / rv1.opnProd as 'rv1.ds'
    ,cast(((rv1.opnMinWater*rv1.dsPct) / rv1.opnProd)  * rv1.opnProd as float) AS 'rv1.opnDs'
    ,rv1.ricBez  as 'rv1.ricBez'    
    ,rv1.trbatches  as 'rv1.trBatches'    
    ,rv2.name as 'rv2.name'
    ,rv2.opnProd as 'rv2.Prod'
    ,rv2.opnMinWater as 'rv2.ProdExclWater'
    ,(rv2.opnMinWater*rv2.dsPct) / rv2.opnProd as 'rv2.ds'
    ,cast(((rv2.opnMinWater*rv2.dsPct) / rv2.opnProd)  * rv2.opnProd as float) AS 'rv2.opnDs'
    ,rv2.ricBez  as 'rv2.ricBez'    
    ,rv2.trbatches  as 'rv2.trBatches'    
    ,rv3.name as 'rv3.name'
    ,rv3.opnProd as 'rv3.Prod'
    ,rv3.opnMinWater as 'rv3.ProdExclWater'
    ,(rv3.opnMinWater*rv3.dsPct) / rv3.opnProd as 'rv3.ds'  
    ,cast(((rv3.opnMinWater*rv3.dsPct) / rv3.opnProd)  * rv3.opnProd as float) AS 'rv3.opnDs'
    ,rv3.ricBez  as 'rv3.ricBez'   
    ,rv3.trbatches  as 'rv3.trBatches'    
    ,rv4.name as 'rv4.name'
    ,rv4.opnProd as 'rv4.Prod'
    ,rv4.opnMinWater as 'rv4.ProdExclWater'
    ,(rv4.opnMinWater*rv4.dsPct) / rv4.opnProd as 'rv4.ds'      
    ,cast(((rv4.opnMinWater*rv4.dsPct) / rv4.opnProd)  * rv4.opnProd  as float) AS 'rv4.opnDs'
    ,rv4.ricBez  as 'rv4.ricBez'   
    ,rv4.trbatches  as 'rv4.trBatches'    
from 
 (select distinct date, cow from vl_totaal_bedrijf_ric_cd ) as tot -- deze tabel is alleen gebruikt voor de stallijst. mag dus wel op deze tabel

left join (
    -- deze moet nog nagekkeken worden, het enige nadeel wat ik kan verzinnen is dat een groupname wijziging halverwege de dag niet handig uitpakt
      select 
       t_raw_hokofarmcd.date as [date], 
        cast(t_raw_hokofarmcd.cow as int) as cow, 
        feedTypeRv1 as name, 
        -- raw_trioliet.groupname ,
        try_convert( float,totalIntakeRV1) as opnProd,
        try_convert( float,totalIntakeRV1) as opnIncWater,  
        
        -- sum(cast(totalIntakeRV1*(1-waterPct) as real)) Ik as opnMinWater,
        (sum(totaalgeladen)-sum(waterkg))/sum(totaalgeladen) * try_convert( float,totalIntakeRV1)  as opnMinWater,
        
        count(distinct filename) as trBatches, 
        count(distinct vr.startTime) as ricBez,
        sum(dsKg)/sum(prodKg) as dsPct,
        sum(dsKg)/sum(prodKg)* ((cast(sum(totaalgeladen) as real) -cast(sum(waterkg)as real)) / cast(sum(totaalgeladen) as real) * sum(intake))  as opnDsVR

    from (
        select 
            cast(date as date) as date, cast(cow as int) as cow,  try_convert( float,totalIntakeRV1)  as totalIntakeRV1 , feedTypeRv1 
        from 
            dbo.vl_totaal_bedrijf_ric_cd
        where 
             try_convert( float,totalIntakeRV1)  >0
    ) as t_raw_hokofarmcd
    
    LEFT JOIN  
        dbo.vl_totaal_bedrijf_ric_vr

        as vr  ON  t_raw_hokofarmcd.cow=vr.COW AND t_raw_hokofarmcd.date=vr.date and feedTypeRv1=vr.feedType
    
    LEFT JOIN (
        select distinct  
            cast(date as date) as date, subgroupnr, groupname , filename 
        from  dbo.t_raw_trioliet 
    )  as raw_trioliet on  raw_trioliet.date=vr.date AND  raw_trioliet.groupname  = feedTypeRv1
    
    left join dbo.VL_Totaal_Sub_Ric_Ds as ds on cast(ds.date as date)=vr.date  and ds.groupname=raw_trioliet.groupname 
    group by  t_raw_hokofarmcd.date, t_raw_hokofarmcd.cow,feedTypeRv1, totalIntakeRV1
    -- having sum(totaalgeladen)>0

) as rv1 on  rv1.date=tot.date  and rv1.cow=tot.cow 
left join (

    -- deze moet nog nagekkeken worden, het enige nadeel wat ik kan verzinnen is dat een groupname wijziging halverwege de dag niet handig uitpakt
      select 
       t_raw_hokofarmcd.date as [date], 
        cast(t_raw_hokofarmcd.cow as int) as cow, 
        feedTypeRv2 as name, 
        -- raw_trioliet.groupname ,
        try_convert( float,totalIntakeRV2) as opnProd,
        try_convert( float,totalIntakeRV2) as opnIncWater,  
        
        -- sum(cast(totalIntakeRV2*(1-waterPct) as real)) as opnMinWater,
        (sum(totaalgeladen)-sum(waterkg))/sum(totaalgeladen) * totalIntakeRV2 as opnMinWater,        
        
        count(distinct filename) as trBatches, 
        count(distinct vr.startTime) as ricBez,
        sum(dsKg)/sum(prodKg) as dsPct,
        sum(dsKg)/sum(prodKg)* ((cast(sum(totaalgeladen) as real) -cast(sum(waterkg)as real)) / cast(sum(totaalgeladen) as real) * sum(intake))  as opnDsVR

    from (
        select 
            cast(date as date) as date, cast(cow as int) as cow,  try_convert( float,totalIntakeRV2)  as totalIntakeRV2 , feedTypeRv2 
        from 
            dbo.vl_totaal_bedrijf_ric_cd
        where 
            try_convert( float,totalIntakeRV2)  >0
    ) as t_raw_hokofarmcd
    
    LEFT JOIN  
                dbo.vl_totaal_bedrijf_ric_vr as vr  ON  t_raw_hokofarmcd.cow=vr.COW AND t_raw_hokofarmcd.date=vr.date and feedTypeRv2=vr.feedType
    
    LEFT JOIN (
        select distinct  
            cast(date as date) as date, subgroupnr, groupname , filename 
        from  dbo.t_raw_trioliet 
    )  as raw_trioliet on  raw_trioliet.date=vr.date AND  raw_trioliet.groupname  = feedTypeRv2
    
    left join dbo.VL_Totaal_Sub_Ric_Ds as ds on cast(ds.date as date)=vr.date  and ds.groupname=raw_trioliet.groupname 
    group by  t_raw_hokofarmcd.date, t_raw_hokofarmcd.cow,feedTypeRv2, totalIntakeRV2
-- having sum(totaalgeladen)>0
) as rv2 on  rv2.date=tot.date and rv2.cow=tot.cow
left join (

    -- deze moet nog nagekkeken worden, het enige nadeel wat ik kan verzinnen is dat een groupname wijziging halverwege de dag niet handig uitpakt
    select 
       t_raw_hokofarmcd.date as [date], 
        cast(t_raw_hokofarmcd.cow as int) as cow, 
        feedTypeRv3 as name, 
        -- raw_trioliet.groupname ,
        try_convert( float,totalIntakeRV3)  as opnProd,
        try_convert( float,totalIntakeRV3)  as opnIncWater,  
        
        -- sum(cast(totalIntakeRV3*(1-waterPct) as real)) as opnMinWater,
        (sum(totaalgeladen)-sum(waterkg))/sum(totaalgeladen) * totalIntakeRV3 as opnMinWater,
        count(distinct filename) as trBatches, 
        count(distinct vr.startTime) as ricBez,
        sum(dsKg)/sum(prodKg) as dsPct,
        sum(dsKg)/sum(prodKg)* ((cast(sum(totaalgeladen) as real) -cast(sum(waterkg)as real)) / cast(sum(totaalgeladen) as real) * sum(intake))  as opnDsVR

    from (
        select 
            cast(date as date) as date, cast(cow as int) as cow,  try_convert( float,totalIntakeRV3)   as totalIntakeRV3 , feedTypeRv3 
        from 
            dbo.vl_totaal_bedrijf_ric_cd
        where 
            try_convert( float,totalIntakeRV3)  >0

    ) as t_raw_hokofarmcd
    
    LEFT JOIN  
        dbo.vl_totaal_bedrijf_ric_vr as vr  ON  t_raw_hokofarmcd.cow=vr.COW AND t_raw_hokofarmcd.date=vr.date and feedTypeRv3=vr.feedType
    
    LEFT JOIN (
        select distinct  
            cast(date as date) as date, subgroupnr, groupname , filename 
        from  dbo.t_raw_trioliet 
    )  as raw_trioliet on raw_trioliet.date=vr.date AND  raw_trioliet.groupname  = feedTypeRv3
    
    left join dbo.VL_Totaal_Sub_Ric_Ds as ds on cast(ds.date as date)=vr.date  and ds.groupname=raw_trioliet.groupname 
    group by  t_raw_hokofarmcd.date, t_raw_hokofarmcd.cow,feedTypeRv3, totalIntakeRV3
-- having sum(totaalgeladen)>0


) as rv3 on  rv3.date=tot.date and rv3.cow=tot.cow
left join (

    -- deze moet nog nagekkeken worden, het enige nadeel wat ik kan verzinnen is dat een groupname wijziging halverwege de dag niet handig uitpakt
       select 
        t_raw_hokofarmcd.date as [date], 
        cast(t_raw_hokofarmcd.cow as int) as cow, 
        feedTypeRv4 as name, 
        -- raw_trioliet.groupname ,
        try_convert( float,totalIntakeRV4)  as opnProd,
        try_convert( float,totalIntakeRV4) as opnIncWater,  
        
        -- sum(cast(totalIntakeRV4*(1-waterPct) as real)) as opnMinWater,
        (sum(totaalgeladen)-sum(waterkg))/sum(totaalgeladen) * totalIntakeRV4 as opnMinWater,
        
        count(distinct filename)    as trBatches, 
        count(distinct vr.startTime) as ricBez,
        sum(dsKg)/sum(prodKg)       as dsPct,
        sum(dsKg)/sum(prodKg)* ((cast(sum(totaalgeladen) as real) -cast(sum(waterkg)as real)) / cast(sum(totaalgeladen) as real) * sum(intake))  as opnDsVR

    from (
        select 
            cast(date as date) as date, cast(cow as int) as cow,  try_convert( float,totalIntakeRV4)  as totalIntakeRV4 , feedTypeRv4 
        from 
            dbo.vl_totaal_bedrijf_ric_cd
        where
            try_convert( float,totalIntakeRV4)  > 0
            
    ) as t_raw_hokofarmcd
    
    LEFT JOIN  
        dbo.vl_totaal_bedrijf_ric_vr as vr  ON  t_raw_hokofarmcd.cow=vr.COW AND t_raw_hokofarmcd.date=vr.date and feedTypeRv4=vr.feedType
    
    LEFT JOIN (
        select distinct  
            cast(date as date) as date, subgroupnr, groupname , filename 
        from  dbo.t_raw_trioliet 
    )  as raw_trioliet on raw_trioliet.date=vr.date AND  raw_trioliet.groupname  = feedTypeRv4
    
    left join dbo.VL_Totaal_Sub_Ric_Ds as ds on cast(ds.date as date)=vr.date  and ds.groupname=raw_trioliet.groupname 
    group by  t_raw_hokofarmcd.date, t_raw_hokofarmcd.cow,feedTypeRv4, totalIntakeRV4
-- having sum(totaalgeladen)>0
) as rv4 on  rv4.date=tot.date and rv4.cow=tot.cow


