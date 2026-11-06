CREATE VIEW [dbo].[VL_Dier_Voeropname_KV_Etmaal]
AS
SELECT        
    Dat, DieNum, SUM(VoeGft) AS SumVoeGft, 
    SUM(VoeRst) AS SumVoeRst
FROM            
    dbo.TVL_Dier_Voeropname_KV
GROUP BY Dat, DieNum


