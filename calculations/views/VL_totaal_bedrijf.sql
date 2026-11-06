CREATE view [dbo].[VL_totaal_bedrijf] as 

-- besproken met fedde 9 juni 2026
-- VrwDgn eruit
-- C21 kv eruit

--  besproken 30-10-2026 
-- bcs was gejoined op een datetime


SELECT  

    s.Dat
    ,s.[Jar]
    ,s.[Wek]
    ,s.[WekDag]
    -- ,tot.PrfCod
    -- ,tot.BehCod
    -- ,beh.BehNam
    -- ,[HrhNum]
    -- ,[Blk]
    ,hok as Hok
    ,HokMin1
    ,s.LevNum
    ,cast([OorNum] as int) as OorNum
    ,CAST(s.AnimalServerId  AS INT)AnimalServerId
    -- ,cast([BegDatPrf] as date ) as BegDatPrf
    -- ,cast([EndDatPrf] as date )  as EndDatPrf
    ,cast(s.[GebDat] as date) as GebDat
    ,s.[LftDgn]
    ,l.[LacNum]
    ,l.KlfDat
    ,l.[LacDgn]
    --   ,cast([InsDat] as date) as InsDat
    , (
        select max(matingdate) 
        from dbo.t_animal_matings  as m
        where s.AnimalserverId=m.animalserverid and matingdate<=VrwKlfDat and matingdate>dateadd(mm, -9, s.dat)
    ) as InsDat -- LETOP ! TODO:: Inseminatie moet altijd groter zijn dan de laatste calving
    --- dit heeeft bert met fedde gecontroleerd 4 sept 2023
    , cast(DrgZetDat as date) as DrgZetDat
    , cast(VrwKlfDat as date) as VrwKlfDat
    , cast(VlgKlfDat as date) as VlgKlfDat
    
    ,'??' as [VrwDgn] -- nog niet geimplementeerd
    , iif(l.[PrdSta] is null, 'Droog', [PrdSta]) as PrdSta
    -- -- ,[SAC-1]
    -- , HokoBrok1
    -- -- ,[SAC-2]
    -- , HokoBrok2
    -- -- ,[SAC-3]
    -- , HokoBrok3
    -- -- ,[SAC-4]
    -- , HokoBrok4

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
    -- ,gea.cfc as GeaBrok --  TODO DIUT MOETEN WE NOGUITZOEKEN
    ,[DelPro-13]

-- moet eruit 
    -- ,[OpnRV] as OpnRvDsHans -- in de calpis dataset staat de nieuwere water moet er nog uit
    
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
  

    ,[GewO]
    ,[GewA]

    ,bcs.bcs as bcs

    -- ,IIF(gea.[AntMlkO]>0 , gea.[AntMlkO], OUDMELK.AntMlkO) as AntMlkO
    -- ,IIF(gea.[KgMlkO]>0  ,gea.[KgMlkO]  , OUDMELK.KgMlkO)  as KgMlkO
    -- ,IIF(gea.[AntMlkA]>0 ,gea.[AntMlkA] , OUDMELK.AntMlkA) as AntMlkA
    -- ,IIF(gea.[KgMlkA]>0  ,gea.[KgMlkA]  , OUDMELK.KgMlkA)  as KgMlkA


    ,AntMlkO
    ,KgMlkO
    ,AntMlkA
    ,KgMlkA
    ,KgMlkEtm
    ,AntMlkO + AntMlka as AntMlkEtm



    ,MlkCon.MilkQuantityMass AS MlkStd
    ,MlkCon.FatPercentage as  [VetStd]
    ,MlkCon.ProteinPercentage as [EiwStd]
    ,MlkCon.LactosePercentage as  [LacStd]
    ,MlkCon.KetosisCode as  [KetStd]
    ,MlkCon.Urea as  [UreStd]
    ,MlkCon.SCCDay as [CelStd]


    --- weekly AO results
    
    , mpr_dag.Fat_Concentration as 'mpr_dag.Fat_Concentration'
    , mpr_dag.Protein_Concentration as 'mpr_dag.Protein_Concentration'
    , mpr_dag.Lactose_Concentration as 'mpr_dag.Lactose_Concentration'
    , mpr_dag.SCC as 'mpr_dag.SCC'
    , mpr_dag.Urea_Concentration as 'mpr_dag.Urea_Concentration' 

    , mpr_week.Fat_Concentration as 'mpr_week.Fat_Concentration'
    , mpr_week.Protein_Concentration as 'mpr_week.Protein_Concentration'
    , mpr_week.Lactose_Concentration as 'mpr_week.Lactose_Concentration'
    , mpr_week.SCC as 'mpr_week.SCC'
    , mpr_week.Urea_Concentration as 'mpr_week.Urea_Concentration '
    , gf_visits
    , gf_cupdrops


from  
    dbo.tvl_totaal_sub_stal as s  
left join  
    dbo.tvl_totaal_sub_lactatie as l on cast(l.dat as date)=cast(s.dat as date) and l.animalserverid=s.animalserverid
lEFT JOIN 
    dbo.VL_totaal_sub_gewicht AS Gew ON s.Dat = Gew.Date AND s.oornum = Gew.cow 
LEFT JOIN 
    dbo.T_Animal_MilkSamples AS MlkCon ON s.Dat = MlkCon.SampleDateDT AND s.AnimalServerID = MlkCon.AnimalServerID 
LEFT JOIN 
    TVL_Totaal_sub_kv AS KV ON s.Dat = KV.Dat AND s.AnimalServerID = KV.DieNum -- deze is voor delpro en gea 
left join 
    t_raw_gea_krachtvoer as geakv on geakv.date=s.Dat and geakv.cow=s.OorNum
left join (
        select distinct * 
        from dbo.T_RAW_crv_melkdata) as mpr_dag  on mpr_dag.AnimalServerId=s.AnimalServerId and s.dat=cast(mpr_dag.milking_begin_datetime as date)
left join 
    dbo.VL_Dier_Datum_Crv as mpr_week on datepart(ISO_WEEK, mpr_week.date) = datepart(ISO_WEEK, s.dat) and year(mpr_week.date) = year(s.dat) and mpr_week.animalserverid=s.AnimalServerId
left join 
    TVL_Totaal_sub_mlk as gea on gea.cow=s.oornum and gea.imdat = s.dat
-- left join 
--     TVL_Dier_Melkgift_Etmaal_Melkcontrole as OUDMELK on OUDMELK.Dat = s.Dat and OUDMELK.DieNum = s.AnimalServerId
left join 
    TVL_Totaal_Sub_HokofarmBrok as hokofarm  on hokofarm.cow=s.oornum and hokofarm.date = s.dat
left join 
    TVL_totaal_sub_ric_opn as ric on ric.cow=s.oornum and ric.dat=s.dat
left join (
    select 
        cast(date as date) as [date], 
        cow, 
        avg(bcs) as bcs 
    from 
        t_raw_laval_bcs_raw 
    where   
        bcs>0
    group by 
        cast(date as date), cow
) as bcs on bcs.cow=oornum and bcs.date=s.dat
left join 
    TVL_Totaal_SUB_greenfeed_summarized_data as gfv on gfv.cow=oornum and gfv.date = s.dat 
left join 
    TVL_Totaal_sub_greenfeed_feed as gff on gff.cow=oornum and gff.date = s.dat 


