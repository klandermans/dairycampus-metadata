create view [dbo].[VL_Totaal_Bedrijf_RIC_RW] 
with schemabinding as

SELECT [date]
      ,[time]
      ,[cow]
      ,[ric]
      ,[troughNumber]
      ,[weight]
  FROM  (
SELECT [date]
      ,[time]
      ,[cow]
      ,[ric]
      ,[troughNumber]
      ,[weight]
  FROM [dbo].[T_RAW_hokofarmRW_apollo]
  union all 
SELECT [date]
      ,[time]
      ,[cow]
      ,[ric]
      ,[troughNumber]
      ,[weight]
  FROM [dbo].[T_RAW_hokofarmRW]  


  ) as asdf
