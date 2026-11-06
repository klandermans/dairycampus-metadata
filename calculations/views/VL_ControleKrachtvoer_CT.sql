CREATE VIEW [dbo].[VL_ControleKrachtvoer_CT]
AS
SELECT        
    PrfCod, BehCod, DieNum, OorNum, OorNumGet, 
    PrcCom, VoeNum, PrtNam, [-7G], 
    [-7R], [-6G], [-6R], [-5G], [-5R], 
    [-4G], [-4R], [-3G], [-3R], [-2G], [-2R], [-1G], [-1R],
        ROW_NUMBER() OVER (ORDER BY oornum) as RowID 

FROM            
    (SELECT        
        PrfCod, BehCod, DieNUm, OorNum, OorNumGet, PrcCom, VoeNum, PrtNam, Kg, Dag
     FROM            
        VL_ControleKrachtvoer) AS P PIVOT (max(Kg) FOR Dag IN ([-7G], [-7R], [-6G], [-6R], [-5G], [-5R], [-4G], [-4R], [-3G], [-3R], [-2G], [-2R], [-1G], [-1R])) AS pvt



where prfcod<>'4400003406'

