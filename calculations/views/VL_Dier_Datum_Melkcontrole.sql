CREATE VIEW [dbo].[VL_Dier_Datum_Melkcontrole]
AS

select 
TVL_Dier_Melkgift_Etmaal_Melkcontrole.*

,[a]
      ,[o]
      ,[Milk_Yield_CRV]
      ,[Milk_Yield]
      
      ,[Fat_Concentration]
      ,[Protein_Concentration]
      ,[Lactose_Concentration]
      ,[SCC]
      ,[Urea_Concentration]

 from (
SELECT        
    D.Dat, MC.DieNum, 
    MC.Dat AS DatCon, 
    MC.DatGldTot, 
    MC.Mlk,
    MC.Vet, 
    MC.Eiw,
    MC.Lac, 
    MC.Ket, 
    MC.Ure, 
    MC.Cel
FROM dbo.T_Datum AS D 
CROSS JOIN dbo.VL_Dier_Melkcontrole AS MC
WHERE (D.Dat BETWEEN MC.Dat AND MC.DatGldTot
))
as TVL_Dier_Melkgift_Etmaal_Melkcontrole 
left join 
    tvl_dier_datum_crv as Q_Milieustallen_MelkcontroleAO_Crv  
ON year(TVL_Dier_Melkgift_Etmaal_Melkcontrole.dat) = year(Q_Milieustallen_MelkcontroleAO_Crv.date) 
    AND DATEPART("WK", TVL_Dier_Melkgift_Etmaal_Melkcontrole.dat)  = DATEPART("WK", Q_Milieustallen_MelkcontroleAO_Crv.date) 
    AND TVL_Dier_Melkgift_Etmaal_Melkcontrole.DieNum = Q_Milieustallen_MelkcontroleAO_Crv.AnimalServerId



 





