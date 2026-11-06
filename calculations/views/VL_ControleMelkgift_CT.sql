CREATE VIEW [dbo].[VL_ControleMelkgift_CT]
AS
/*
 * Deze views worden gebruikt in de stal als controleliojst
 */
SELECT        
    PrfCod, 
    BehCod,     
    DieNum, 
    OorNum, OorNumGet, 
    round(AvgO,1)  as AvgO, 
    round(AvgA,1) as AvgA, 
    [-7O], 
    [-7A], 
    [-6O], 
    [-6A], 
    [-5O], 
    [-5A], 
    [-4O], 
    [-4A], 
    [-3O], 
    [-3A], 
    [-2O],
    [-2A], 
    [-1O], 
    [-1A],
    ROW_NUMBER() OVER (ORDER BY oornum) as RowID 
FROM            
    (SELECT        
        PrfCod, BehCod, DieNum, OorNum, OorNumGet, 
    round(AvgO,1)  as AvgO, 
    round(AvgA,1)  as AvgA, 
        MilkQuantityMass, DagOA
    FROM            
        VL_ControleMelkgift) AS P PIVOT (max(MilkQuantityMass) FOR DagOA 
    IN ([-7O], [-7A], [-6O], [-6A], [-5O], [-5A], [-4O], [-4A], [-3O], [-3A], [-2O], [-2A], [-1O], 
                         [-1A])) AS pvt

where prfcod<>'4400003406'



