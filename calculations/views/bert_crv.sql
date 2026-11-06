-- 

CREATE view bert_crv as 

SELECT  
 1-abs(nullif(SumOpnDS,0)/nullif([tot.opnDs],0)) as asdf ,
    s.Dat

    ,hok as Hok
    ,HokMin1

    ,cast([OorNum] as int) as OorNum

   
    ,AtributedKVA
    ,TotalIntakeKVA
    ,AtributedKVB
    ,TotalIntakeKVB
    ,AtributedKVC
    ,TotalIntakeKVC
    ,AtributedKVD
    ,TotalIntakeKVD

    , round(CAST(geakv.cons1 AS float)*0.001,3) as [C21-9]
    , round(CAST(geakv.cons2 AS float)*0.001,3)  as [C21-10]
    , CAST(geakv.cons1 AS INT) as KvMlk1
    , CAST(geakv.cons2 AS INT) as KvMlk2
    ,[DelPro-13]
    ,[SumOpnDS] as OpnRvDsHans -- in de calpis dataset staat de nieuwere water moet er nog uit
    ,[tot.opnDs] as OpnDsNew

    ,[tot.Prod]
    ,[tot.opnDs]
    ,[rv1.name]
   ,[rv1.Prod]
      ,[rv1.ProdExclWater]
      ,[rv1.ds]
      ,[rv1.opnDs]
      ,[rv1.ricBez]
      ,[rv1.trBatches]
      ,[rv2.name]
      ,[rv2.Prod]
      ,[rv2.ProdExclWater]
      ,[rv2.ds]
      ,[rv2.opnDs]
      ,[rv2.ricBez]
      ,[rv2.trBatches]
      ,[rv3.name]
      ,[rv3.Prod]
      ,[rv3.ProdExclWater]
      ,[rv3.ds]
      ,[rv3.opnDs]
      ,[rv3.ricBez]
      ,[rv3.trBatches]
      ,[rv4.name]
      ,[rv4.Prod]
      ,[rv4.ProdExclWater]
      ,[rv4.ds]
      ,[rv4.opnDs]
      ,[rv4.ricBez]
      ,[rv4.trBatches]
  

    , gf_visits
    , gf_cupdrops


from  
    dbo.tvl_totaal_sub_stal as s  
LEFT JOIN 
    TVL_Totaal_sub_kv AS KV ON s.Dat = KV.Dat AND s.AnimalServerID = KV.DieNum -- deze is voor delpro en gea 
left join 
    t_raw_gea_krachtvoer as geakv on geakv.date=s.Dat and geakv.cow=s.OorNum
left join (
        select distinct * 
        from dbo.T_RAW_crv_melkdata) as mpr_dag  on mpr_dag.AnimalServerId=s.AnimalServerId and s.dat=cast(mpr_dag.milking_begin_datetime as date)
left join 
    TVL_Totaal_Sub_HokofarmBrok as hokofarm  on hokofarm.cow=s.oornum and hokofarm.date = s.dat
left join 
    TVL_totaal_sub_ric_opn as ric on ric.cow=s.oornum and ric.dat=s.dat
left join 
    TVL_Totaal_SUB_greenfeed_summarized_data as gfv on gfv.cow=oornum and gfv.date = s.dat 
left join 
    TVL_Totaal_sub_greenfeed_feed as gff on gff.cow=oornum and gff.date = s.dat 
left join TVL_Dier_Voeropname_RV_Etmaal as opn on opn.dat=s.dat and s.animalserverid=opn.dienum


where left(hok,1)='3' and s.dat<'2023-01-01'

and (nullif(SumOpnDS,0)/nullif([tot.opnDs],0) < 0.7) or (nullif(SumOpnDS,0)/nullif([tot.opnDs],0) > 1.3)


