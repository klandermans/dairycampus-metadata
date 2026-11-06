
CREATE view [dbo].[VL_totaal_bedrijf_proef] 
as
SELECT        
   
    cast(prf.[Dat] as date) as Dat
    ,prf.[Jar]
    ,prf.[Wek]
    ,prf.[WekDag]
    ,cast(prf.PrfCod as varchar(32) ) as PrfCod
    ,prf.BehCod
    ,0 as BehNam
    ,[HrhNum]
    ,[Blk]
    ,tot.Hok
    ,tot.HokMin1
    ,tot.[LevNum]
    ,tot.OorNum
    ,cast(prf.DieNum  as int) as AnimalServerId
    ,cast([BegDatPrf] as date) as BegDatPrf
    ,cast([EndDatPrf] as date)  as EndDatPrf
    ,tot.[LftDgn]
    ,tot.[GebDat]
    ,tot.[LacNum]
    ,tot.KlfDat
    ,tot.[LacDgn]
    ,tot.InsDat 
    ,tot.DrgZetDat
    ,tot.VrwKlfDat
    ,tot.VlgKlfDat
   
    ,tot.[VrwDgn]
    ,tot.[PrdSta]
   

    ,AtributedKVA ,
    TotalIntakeKVA ,
    AtributedKVB ,
    TotalIntakeKVB ,
    AtributedKVC ,
    TotalIntakeKVC ,
    AtributedKVD ,
    TotalIntakeKVD ,


	[C21-9] ,
	[C21-10] ,

	[KvMlk1],
	[KvMlk2],


    -- ,gea.cfc as GeaBrok --  TODO DIUT MOETEN WE NOGUITZOEKEN
     [DelPro-13]

-- moet eruit 
    
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

    ,bcs

    -- ,tot.[AntMlkO]
    -- ,tot.[KgMlkO]
    -- ,tot.[AntMlkA]
    -- ,tot.[KgMlkA]

    ,AntMlkO
    ,KgMlkO
    ,AntMlkA
    ,KgMlkA

    , KgMlkEtm
    ,AntMlkEtm
    
    ,[MlkStd]
    ,[VetStd]
    ,[EiwStd]
    ,[LacStd]
    ,[KetStd]
    ,[UreStd]
    ,[CelStd]


    --- weekly AO results
    
    , [mpr_dag.Fat_Concentration]
    , [mpr_dag.Protein_Concentration]
    , [mpr_dag.Lactose_Concentration]
    , [mpr_dag.SCC]
    , [mpr_dag.Urea_Concentration]

    , [mpr_week.Fat_Concentration]
    , [mpr_week.Protein_Concentration]
    , [mpr_week.Lactose_Concentration]
    , [mpr_week.SCC]
    , [mpr_week.Urea_Concentration]
    
    , gf_visits
    , gf_cupdrops

FROM            
vl_totaal_sub_dier_datum_proef as prf
left join tvl_totaal_bedrijf as tot on tot.dat=prf.dat and tot.AnimalServerId=prf.dienum
where tot.dat is not null
-- and prfcod='4400003634'
