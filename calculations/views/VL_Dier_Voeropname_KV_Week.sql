CREATE VIEW [dbo].[VL_Dier_Voeropname_KV_Week]
AS
SELECT        
    DieNum, DATEPART(YY, Dat) AS Jaa, 
    DATEPART(ISOWK, Dat) AS WeeNum, 
    ROUND(AVG(SumVoeGft), 2) AS VoeGft, 
    ROUND(AVG(SumVoeRst), 2) AS VoeRst
FROM            
    dbo.VL_Dier_Voeropname_KV_Etmaal
WHERE       
    (dbo.KVDatOK(Dat) = 1)
GROUP BY 
    DieNum, DATEPART(YY, Dat), DATEPART(ISOWK, Dat)

