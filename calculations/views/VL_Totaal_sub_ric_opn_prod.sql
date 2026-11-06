CREATE VIEW [dbo].[VL_Totaal_sub_ric_opn_prod] as 

-- deze wrap om de where aan het eind over alle unions te kunnen doen
select *    
from (
    select * 
    from (
    
  
 SELECT  
        cast(tot.[Date] as date) as Dat
        ,rv.cow
        ,rv.name as 'groupName'
        ,rv.opnProd as TotOpnDag
        ,rv.dsPct as dsPctBatchDag
        ,cast(((rv.opnMinWater*rv.dsPct) / rv.opnProd)  * rv.opnProd as float) AS TotOpnDs
        ,ingredientname
        ,pct as PctIngredient      
        ,rv.opnProd*pct*0.01 as OpnKgProd 
        ,cast(((rv.opnMinWater*rv.dsPct) / rv.opnProd)  * rv.opnProd as float) * pct*0.01 as OpnDsProd
        ,dstrio as dsInTrio
    from 
        VL_Totaal_Bedrijf_Ric_CD as tot
    left join (
        -- deze moet nog nagekkeken worden, het enige nadeel wat ik kan verzinnen is dat een groupname wijziging halverwege de dag niet handig uitpakt
        select 
            cast(t_raw_hokofarmcd.date as date) as [date], 
            cast(t_raw_hokofarmcd.cow as int) as cow, 
            feedTyperv1 as name, 
            -- raw_trioliet.groupname ,
            try_convert( float,totalIntakerv1) as opnProd,
            try_convert( float,totalIntakerv1) as opnIncWater,  
            
            -- sum(cast(totalIntakerv1*(1-waterPct) as real)) Ik as opnMinWater,
            (sum(totaalgeladen)-sum(waterkg))/sum(totaalgeladen) * try_convert( float,totalIntakerv1)  as opnMinWater,     
            count(distinct filename) as trBatches, 
            count(distinct vr.datetime) as ricBez,
            sum(dsKg)/sum(prodKg) as dsPct,
            sum(dsKg)/sum(prodKg)* ((cast(sum(totaalgeladen) as real) -cast(sum(waterkg)as real)) / cast(sum(totaalgeladen) as real) * sum(intake))  as opnDsVR

        from (
            select 
                cast(date as date) as date, cast(cow as int) as cow,  try_convert( float,totalIntakerv1)  as totalIntakerv1 , feedTyperv1 
            from 
                dbo.vl_totaal_bedrijf_ric_cd
            where 
                try_convert( float,totalIntakerv1)  >0
        ) as t_raw_hokofarmcd
        
        LEFT JOIN  
            dbo.vl_totaal_bedrijf_ric_vr

            as vr  ON  t_raw_hokofarmcd.cow=vr.COW AND t_raw_hokofarmcd.date=CAST(VR.DATE AS DATE) and feedTyperv1=vr.feedType
        
        LEFT JOIN (
            select distinct  
                cast(date as date) as date, subgroupnr, groupname , filename 
            from  dbo.t_raw_trioliet 
        )  as raw_trioliet on  raw_trioliet.date=cast(vr.date as date) AND  raw_trioliet.groupname  = feedTyperv1
        
        left join 
            dbo.VL_Totaal_Sub_Ric_Ds as ds on cast(ds.date as date)=cast(vr.date as date)  and ds.groupname=raw_trioliet.groupname 
        group by  
            t_raw_hokofarmcd.date, t_raw_hokofarmcd.cow,feedTyperv1, totalIntakerv1
    ) as rv on  rv.date=tot.date  and rv.cow=tot.cow 
    left join 
        VL_Totaal_Sub_Ric_Ds_PCT on rv.date=VL_Totaal_Sub_Ric_Ds_PCT.date and rv.name=VL_Totaal_Sub_Ric_Ds_PCT.groupname


    ) as sub1


    union all 


    select * from 
    (
    SELECT  
        cast(tot.[Date] as date) as Dat
        ,rv.cow
        ,rv.name as 'groupName'
        ,rv.opnProd as TotOpnDag
        ,rv.dsPct as dsPctBatchDag
        ,cast(((rv.opnMinWater*rv.dsPct) / rv.opnProd)  * rv.opnProd as float) AS TotOpnDs
        ,ingredientname
        ,pct as PctIngredient      
        ,rv.opnProd*pct as OpnKgProd 
        ,cast(((rv.opnMinWater*rv.dsPct) / rv.opnProd)  * rv.opnProd as float) * pct*0.01 as OpnDsProd
        ,dstrio as dsInTrio
        from 
            dbo.t_raw_hokofarmcd as tot
        left join (
            -- deze moet nog nagekkeken worden, het enige nadeel wat ik kan verzinnen is dat een groupname wijziging halverwege de dag niet handig uitpakt
            select 
                cast(t_raw_hokofarmcd.date as date) as [date], 
                cast(t_raw_hokofarmcd.cow as int) as cow, 
                feedTypeRv2 as name, 
                -- raw_trioliet.groupname ,
                try_convert( float,totalIntakeRV2) as opnProd,
                try_convert( float,totalIntakeRV2) as opnIncWater,  
                
                -- sum(cast(totalIntakeRV1*(1-waterPct) as real)) Ik as opnMinWater,
                (sum(totaalgeladen)-sum(waterkg))/sum(totaalgeladen) * try_convert( float,totalIntakeRV2)  as opnMinWater,     
                count(distinct filename) as trBatches, 
                count(distinct vr.datetime) as ricBez,
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
                dbo.vl_totaal_bedrijf_ric_vr

                as vr  ON  t_raw_hokofarmcd.cow=vr.COW AND t_raw_hokofarmcd.date=CAST(VR.DATE AS DATE) and feedTypeRv2=vr.feedType
            
            LEFT JOIN (
                select distinct  
                    cast(date as date) as date, subgroupnr, groupname , filename 
                from  dbo.t_raw_trioliet 
            )  as raw_trioliet on  raw_trioliet.date=cast(vr.date as date) AND  raw_trioliet.groupname  = feedTypeRv2
            
            left join dbo.VL_Totaal_Sub_Ric_Ds as ds on cast(ds.date as date)=cast(vr.date as date)  and ds.groupname=raw_trioliet.groupname 
            group by  t_raw_hokofarmcd.date, t_raw_hokofarmcd.cow,feedTypeRv2, totalIntakeRV2
        ) as rv on  rv.date=tot.date  and rv.cow=tot.cow 
        left join VL_Totaal_Sub_Ric_Ds_PCT on rv.date=VL_Totaal_Sub_Ric_Ds_PCT.date and rv.name=VL_Totaal_Sub_Ric_Ds_PCT.groupname
    ) as sub2




    union all 
    select * from 
    (
        SELECT  
            cast(tot.[Date] as date) as Dat
            ,rv.cow
            ,rv.name as 'groupName'
            ,rv.opnProd as TotOpnDag
            ,rv.dsPct as dsPctBatchDag
            ,cast(((rv.opnMinWater*rv.dsPct) / rv.opnProd)  * rv.opnProd as float) AS TotOpnDs
            ,ingredientname
            ,pct as PctIngredient      
            ,rv.opnProd*pct as OpnKgProd 
            ,cast(((rv.opnMinWater*rv.dsPct) / rv.opnProd)  * rv.opnProd as float) * pct*0.01 as OpnDsProd
            ,dstrio as dsInTrio
                
        from 
            dbo.VL_Totaal_Bedrijf_Ric_CD as tot
        left join (
            -- deze moet nog nagekkeken worden, het enige nadeel wat ik kan verzinnen is dat een groupname wijziging halverwege de dag niet handig uitpakt
            select 
                cast(t_raw_hokofarmcd.date as date) as [date], 
                cast(t_raw_hokofarmcd.cow as int) as cow, 
                feedTyperv3 as name, 
                -- raw_trioliet.groupname ,
                try_convert( float,totalIntakerv3) as opnProd,
                try_convert( float,totalIntakerv3) as opnIncWater,  
                
                -- sum(cast(totalIntakerv3*(1-waterPct) as real)) Ik as opnMinWater,
                (sum(totaalgeladen)-sum(waterkg))/sum(totaalgeladen) * try_convert( float,totalIntakeRV3)  as opnMinWater,     
                count(distinct filename) as trBatches, 
                count(distinct vr.datetime) as ricBez,
                sum(dsKg)/sum(prodKg) as dsPct,
                sum(dsKg)/sum(prodKg)* ((cast(sum(totaalgeladen) as real) -cast(sum(waterkg)as real)) / cast(sum(totaalgeladen) as real) * sum(intake))  as opnDsVR

            from (
                select 
                    cast(date as date) as date, cast(cow as int) as cow,  try_convert( float,totalIntakerv3)  as totalIntakerv3 , feedTyperv3 
                from 
                    dbo.vl_totaal_bedrijf_ric_cd
                where 
                    try_convert( float,totalIntakeRV3)  >0
            ) as t_raw_hokofarmcd
            
            LEFT JOIN  
                dbo.vl_totaal_bedrijf_ric_vr

                as vr  ON  t_raw_hokofarmcd.cow=vr.COW AND t_raw_hokofarmcd.date=CAST(VR.DATE AS DATE) and feedTypeRv3=vr.feedType
            
            LEFT JOIN (
                select distinct  
                    cast(date as date) as date, subgroupnr, groupname , filename 
                from  dbo.t_raw_trioliet 
            )  as raw_trioliet on  raw_trioliet.date=cast(vr.date as date) AND  raw_trioliet.groupname  = feedTypeRv3
            
            left join 
                dbo.VL_Totaal_Sub_Ric_Ds as ds on cast(ds.date as date)=cast(vr.date as date)  and ds.groupname=raw_trioliet.groupname 
            group by  
                t_raw_hokofarmcd.date, t_raw_hokofarmcd.cow,feedTypeRv3, totalIntakeRV3
        ) as rv on  rv.date=tot.date  and rv.cow=tot.cow 
        left join 
            VL_Totaal_Sub_Ric_Ds_PCT on rv.date=VL_Totaal_Sub_Ric_Ds_PCT.date and rv.name=VL_Totaal_Sub_Ric_Ds_PCT.groupname
    ) as sub3

    union all 
    select * from 
    (

        SELECT  
            cast(tot.[Date] as date) as Dat
            ,rv.cow
            ,rv.name as 'groupName'
            ,rv.opnProd as TotOpnDag
            ,rv.dsPct as dsPctBatchDag
            ,cast(((rv.opnMinWater*rv.dsPct) / rv.opnProd)  * rv.opnProd as float) AS TotOpnDs
            ,ingredientname
            ,pct as PctIngredient      
            ,rv.opnProd*pct as OpnKgProd 
            ,cast(((rv.opnMinWater*rv.dsPct) / rv.opnProd)  * rv.opnProd as float) * pct*0.01 as OpnDsProd
            ,dstrio as dsInTrio
        from 
            dbo.t_raw_hokofarmcd as tot
        left join (
            -- deze moet nog nagekkeken worden, het enige nadeel wat ik kan verzinnen is dat een groupname wijziging halverwege de dag niet handig uitpakt
            select 
                cast(t_raw_hokofarmcd.date as date) as [date], 
                cast(t_raw_hokofarmcd.cow as int) as cow, 
                feedTyperv4 as name, 
                -- raw_trioliet.groupname ,
                try_convert( float,totalIntakerv4) as opnProd,
                try_convert( float,totalIntakerv4) as opnIncWater,  
                
                -- sum(cast(totalIntakerv4*(1-waterPct) as real)) Ik as opnMinWater,
                (sum(totaalgeladen)-sum(waterkg))/sum(totaalgeladen) * try_convert( float,totalIntakerv4)  as opnMinWater,     
                count(distinct filename) as trBatches, 
                count(distinct vr.datetime) as ricBez,
                sum(dsKg)/sum(prodKg) as dsPct,
                sum(dsKg)/sum(prodKg)* ((cast(sum(totaalgeladen) as real) -cast(sum(waterkg)as real)) / cast(sum(totaalgeladen) as real) * sum(intake))  as opnDsVR

            from (
                select 
                    cast(date as date) as date, cast(cow as int) as cow,  try_convert( float,totalIntakerv4)  as totalIntakerv4 , feedTyperv4 
                from 
                    dbo.vl_totaal_bedrijf_ric_cd
                where 
                    try_convert( float,totalIntakerv4)  >0
            ) as t_raw_hokofarmcd
            
            LEFT JOIN  
                dbo.vl_totaal_bedrijf_ric_vr

                as vr  ON  t_raw_hokofarmcd.cow=vr.COW AND t_raw_hokofarmcd.date=CAST(VR.DATE AS DATE) and feedTyperv4=vr.feedType
            
            LEFT JOIN (
                select distinct  
                    cast(date as date) as date, subgroupnr, groupname , filename 
                from  dbo.t_raw_trioliet 
            )  as raw_trioliet on  raw_trioliet.date=cast(vr.date as date) AND  raw_trioliet.groupname  = feedTyperv4
            
            left join 
                dbo.VL_Totaal_Sub_Ric_Ds as ds on cast(ds.date as date)=cast(vr.date as date)  and ds.groupname=raw_trioliet.groupname 
            group by  
                t_raw_hokofarmcd.date, t_raw_hokofarmcd.cow,feedTyperv4, totalIntakerv4
        ) as rv on  rv.date=tot.date  and rv.cow=tot.cow 
        left join 
            VL_Totaal_Sub_Ric_Ds_PCT on rv.date=VL_Totaal_Sub_Ric_Ds_PCT.date and rv.name=VL_Totaal_Sub_Ric_Ds_PCT.groupname

    ) as sub4
) as total

