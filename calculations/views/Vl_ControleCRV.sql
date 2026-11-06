CREATE view [dbo].[Vl_ControleCRV] as
-- door wie wordt dit gebruikt?

SELECT 
    
    [Animal_Number_Short] as cow
    
    , cast(max(iif(datepart(wk, [Date]) = datepart( wk, dateadd(dd, -7, getdate())), date ,null)) as date) as 'Date-1w'
    , cast(max(iif(datepart(wk, [Date]) = datepart( wk, dateadd(dd, -14, getdate())), date ,null)) as date) as 'Date-2w'
    , cast(max(iif(datepart(wk, [Date]) = datepart( wk, dateadd(dd, -21, getdate())), date ,null)) as date) as 'Date-3w'
    , cast(max(iif(datepart(wk, [Date]) = datepart( wk, dateadd(dd, -28, getdate())), date ,null)) as date) as 'Date-4w'
    , cast(max(iif(datepart(wk, [Date]) = datepart( wk, dateadd(dd, -35, getdate())), date ,null)) as date) as 'Date-5w'

    , round(max(iif(datepart(wk, [Date]) = datepart( wk, dateadd(dd, -7 ,getdate())), Fat_Concentration ,0)),1) as 'Fat-1w'
    , round(max(iif(datepart(wk, [Date]) = datepart( wk, dateadd(dd, -14, getdate())), Fat_Concentration ,0)),1) as 'Fat-2w'
    , round(max(iif(datepart(wk, [Date]) = datepart( wk, dateadd(dd, -21, getdate())), Fat_Concentration ,0)),1) as 'Fat-3w'
    , round(max(iif(datepart(wk, [Date]) = datepart( wk, dateadd(dd, -28, getdate())), Fat_Concentration ,0)),1) as 'Fat-4w'
    , round(max(iif(datepart(wk, [Date]) = datepart( wk, dateadd(dd, -35, getdate())), Fat_Concentration ,0)),1) as 'Fat-5w'

    , round(max(iif(datepart(wk, [Date]) = datepart( wk, dateadd(dd, -7,  getdate())), Protein_Concentration ,0)),1) as 'Protein-1w'

    , round(max(iif(datepart(wk, [Date]) = datepart( wk, dateadd(dd, -14,  getdate())), Protein_Concentration ,0)),1) as 'Protein-2w'
    , round(max(iif(datepart(wk, [Date]) = datepart( wk, dateadd(dd, -21, getdate())), Protein_Concentration ,0)),1) as 'Protein-3w'
    , round(max(iif(datepart(wk, [Date]) = datepart( wk, dateadd(dd, -28, getdate())), Protein_Concentration ,0)),1) as 'Protein-4w'
    , round(max(iif(datepart(wk, [Date]) = datepart( wk, dateadd(dd, -35, getdate())), Protein_Concentration ,0)),1) as 'Protein-5w'

    , round(max(iif(datepart(wk, [Date]) = datepart( wk, dateadd(dd, -7,  getdate())), Lactose_Concentration ,0)),1) as 'Lactose-1w'
    , round(max(iif(datepart(wk, [Date]) = datepart( wk, dateadd(dd, -14,  getdate())), Lactose_Concentration ,0)),1) as 'Lactose-2w'
    , round(max(iif(datepart(wk, [Date]) = datepart( wk, dateadd(dd, -21, getdate())), Lactose_Concentration ,0)),1)as 'Lactose-3w'
    , round(max(iif(datepart(wk, [Date]) = datepart( wk, dateadd(dd, -28, getdate())), Lactose_Concentration ,0)),1) as 'Lactose-4w'
    , round(max(iif(datepart(wk, [Date]) = datepart( wk, dateadd(dd, -35, getdate())), Lactose_Concentration ,0)),1) as 'Lactose-5w'

    , round(max(iif(datepart(wk, [Date]) = datepart( wk, dateadd(dd, -7, getdate())), scc ,0)),0) as 'SCC-1w'
    , round(max(iif(datepart(wk, [Date]) = datepart( wk, dateadd(dd, -14, getdate())), scc ,0)),0) as 'SCC-2w'
    , round(max(iif(datepart(wk, [Date]) = datepart( wk, dateadd(dd, -21, getdate())), scc ,0)),0) as 'SCC-3w'
    , round(max(iif(datepart(wk, [Date]) = datepart( wk, dateadd(dd, -28, getdate())), scc ,0)),0) as 'SCC-4w'
    , round(max(iif(datepart(wk, [Date]) = datepart( wk, dateadd(dd, -35, getdate())), scc ,0)),0) as 'SCC-5w'

    , round(max(iif(datepart(wk, [Date]) = datepart( wk, dateadd(dd, -7, getdate())), Urea_Concentration ,0)),1) as 'Urea-1w'
    , round(max(iif(datepart(wk, [Date]) = datepart( wk, dateadd(dd, -14, getdate())), Urea_Concentration ,0)),1) as 'Urea-2w'
    , round(max(iif(datepart(wk, [Date]) = datepart( wk, dateadd(dd, -21, getdate())), Urea_Concentration ,0)),1) as 'Urea-3w'
    , round(max(iif(datepart(wk, [Date]) = datepart( wk, dateadd(dd, -28, getdate())), Urea_Concentration ,0)),1) as 'Urea-4w'
    , round(max(iif(datepart(wk, [Date]) = datepart( wk, dateadd(dd, -235, getdate())), Urea_Concentration ,0)),1) as 'Urea-5w'

  FROM [VL_Dier_Datum_Crv]
  where date > dateadd(dd, -40, getdate())
  group by   [Animal_Number]
      ,[Animal_Number_Short]
      

