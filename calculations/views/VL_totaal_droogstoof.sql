CREATE view [dbo].[VL_totaal_droogstoof] as 
SELECT 
    --   prfcod
      [PrjCod]
      ,[DatSes]
      ,[VlgNum]
      ,[DatMon]
      ,[ObjCod]
      ,[ObjCodNum]
      ,[BlkNum]
      ,[BlkGew]
      ,[BlkDat]
      ,[VrsGew]
      ,[VrsDat]
      ,[VrsTyd]
      ,[DrgGew]
      ,[DrgDat]
      ,[DrgTyd]
      ,[DrgStfGkg]

FROM [dbo].[T_Droogstoof_WeegLijst]

-- right join (
--     select 
--         distinct
--         feedtyperv1, 
--         datepart(ww, date) as ww,
--         year(date) as yy, 
--         prfcod
--     from 
--         T_RAW_HokofarmCD 
--     left join  
--         tvl_dier_datum_proef on oornum=cow and date=dat



-- ) as sub on objcod=feedTypeRV1  and  datepart(ww, datses)= ww and  yy =  year(datses)






