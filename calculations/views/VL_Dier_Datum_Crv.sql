-- SET ANSI_NULLS ON
-- GO
-- SET QUOTED_IDENTIFIER ON
-- GO
-- -- SET ANSI_NULLS ON
-- -- GO
-- -- SET QUOTED_IDENTIFIER ON
-- -- GO
-- -- -- SET ANSI_NULLS ON
-- -- -- GO
-- -- -- SET QUOTED_IDENTIFIER ON
-- -- -- GO
CREATE  view [dbo].[VL_Dier_Datum_Crv]  with schemabinding as 


-- /**
--  * View om de dag melkcontrole af te maken. 
--  * Bert Klandermans 1 okt 2019
--  */ 

SELECT 

     T_RAW_crv.AnimalServerId
    ,T_RAW_crv.Animal_Number
    ,T_RAW_crv.Animal_Number_Short
    ,[Date]
    ,min(milking_begin_datetime) as a
    ,max(milking_begin_datetime) as o
    ,sum(Milk_Yield) as Milk_Yield_CRV
    ,sum(Gea_Yield) as Milk_Yield
    -- ,iif( sum(Gea_Yield)* sum(Milk_Yield)>0 , sum(Gea_Yield)/sum(Milk_Yield),0) as discrepancy
    ,count(distinct milking_begin_datetime) as dates
    ,nullif((count(nullif(Fat_Concentration,0))-1) * sum(Fat_Concentration*iif(Gea_Yield>0, Gea_Yield, Milk_Yield))/sum(iif(Gea_Yield>0, Gea_Yield, Milk_Yield)),0) as Fat_Concentration
    ,nullif((count(nullif(Protein_Concentration,0))-1) * sum(Protein_Concentration*iif(Gea_Yield>0, Gea_Yield, Milk_Yield))/sum(iif(Gea_Yield>0, Gea_Yield, Milk_Yield)),0) as Protein_Concentration
    ,nullif((count(nullif(Lactose_Concentration,0))-1) * sum(Lactose_Concentration*iif(Gea_Yield>0, Gea_Yield, Milk_Yield))/sum(iif(Gea_Yield>0, Gea_Yield, Milk_Yield)),0) as Lactose_Concentration
    ,nullif((count(nullif(SCC,0))-1) * sum(SCC*iif(Gea_Yield>0, Gea_Yield, Milk_Yield))/sum(iif(Gea_Yield>0, Gea_Yield, Milk_Yield)),0) as SCC
    ,nullif((count(nullif(Urea_Concentration,0))-1) * sum(Urea_Concentration*iif(Gea_Yield>0, Gea_Yield, Milk_Yield))/sum(iif(Gea_Yield>0, Gea_Yield, Milk_Yield)),0) as Urea_Concentration
    ,nullif((count(nullif(ACETONE_24H,0))-1) * sum(ACETONE_24H*iif(Gea_Yield>0, Gea_Yield, Milk_Yield))/sum(iif(Gea_Yield>0, Gea_Yield, Milk_Yield)),0) as ACETONE_24H
    ,nullif((count(nullif(BHBZ_24H,0))-1) * sum(BHBZ_24H*iif(Gea_Yield>0, Gea_Yield, Milk_Yield))/sum(iif(Gea_Yield>0, Gea_Yield, Milk_Yield)),0) as BHBZ_24H


FROM dbo.[T_RAW_crv_melkdata]  as  T_RAW_crv

where
 iif(Gea_Yield>0, Gea_Yield, Milk_Yield) >0
GROUP BY 
    T_RAW_crv.AnimalServerId, date,  T_RAW_crv.Animal_Number, T_RAW_crv.Animal_Number_Short
HAVING count(milking_begin_datetime) > 1








