CREATE VIEW [dbo].[VL_ControleGewicht_CT]
AS
SELECT        
    PrfCod, 
    BehCod, 
    DieNum, 
    OorNum, 
    OorNumGet, 
    cast(round(AvgO,1) as varchar) as AvgO, 
    cast(round(AvgA,1) as varchar) as AvgA, 
    [-7O], [-7A], [-6O], [-6A], [-5O], [-5A], [-4O], [-4A], [-3O], [-3A], [-2O], [-2A], [-1O], [-1A],
    ROW_NUMBER() OVER (ORDER BY oornum) as RowID 

FROM            (SELECT        PrfCod, BehCod, DieNum, OorNum, OorNumGet, 
    cast(round(AvgO,1) as varchar) as AvgO, 
    cast(round(AvgA,1) as varchar) as AvgA, 
Weight, DagOA
                          FROM            VL_ControleGewicht) AS P PIVOT (max(Weight) FOR DagOA IN ([-7O], [-7A], [-6O], [-6A], [-5O], [-5A], [-4O], [-4A], [-3O], [-3A], [-2O], [-2A], [-1O], 
                         [-1A])) AS pvt

