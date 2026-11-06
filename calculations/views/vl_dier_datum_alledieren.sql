CREATE view [dbo].[vl_dier_datum_alledieren]
as
SELECT stal.[Dat]

      ,[Stl]
      ,[Hok]
      ,[LevNum]
      ,[OorNum]

      ,[BegDat]
      ,[EndDat]
      ,[GebDat]
      ,[LftDgn]
      ,[LacNum]
      ,[KlfDat]
      ,[LacDgn]
      ,[InsDat]
      ,[DrgZetDat]
      ,[VrwKlfDat]
      ,[VrwDgn]
      ,[PrdSta]
    
-------- melk
  ,[AntMlkO]
      ,[KgMlkO]
      ,[AntMlkA]
      ,[KgMlkA]
      ,[KgMlkEtm]
      ,[DatCon]
      ,[DatGldTot]
      ,[MlkCon]
      ,[Vet]
      ,[Eiw]
      ,[Lac]
      ,[Ket]
      ,[Ure]
      ,[Cel]
-------- eind melk
-------- begin gewiccht

  ,[AntGewO]
      ,[GewO]
      ,[AntGewA]
      ,[GewA]
-------- eind gewiccht
-------- start kv

        ,[SumVoeGft]
      ,[SumVoeRst]
        ,[SumVoeGft]-[SumVoeRst] as opn
-------- eind kv
-------- start rv


   ,[SumOpnDSTri]
      ,[SumOPnDSGem]
      ,[SumOpnDS]
-------- eind rv



FROM [TVL_Dier_Datum_Stal] as stal
    left join  [TVL_Dier_Melkgift_Etmaal_Melkcontrole] as melk on melk.dat=stal.dat and melk.dienum=stal.dienum
    left join  [TVL_Dier_Gewicht_Etmaal] as gew on gew.dat=stal.dat and gew.dienum=stal.dienum

    left join  [TVL_Dier_Voeropname_KV_Etmaal]  as kv on kv.dat=stal.dat and kv.dienum=stal.dienum
    left join  [TVL_Dier_Voeropname_RV_Etmaal] as rv on rv.dat=stal.dat and rv.dienum=stal.dienum
