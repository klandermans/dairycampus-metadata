CREATE VIEW [dbo].[VL_Dier_Datum_Proef_Week]
AS
-- TODO: deze query stond in 2020 nog steds als een bende, wordt deze nog gebruikt?
SELECT        
    Jar, 
    Wek, 
    PrfCod, 
    BehCod, 
    HrhNum, 
    Blk, 
    DieNum, 
    OorNumGet, 
    AVG(LacDgn) AS LacDgn
FROM            
    dbo.VL_Dier_Datum_Proef
GROUP BY 
    Jar, 
    Wek, 
    PrfCod, 
    BehCod, 
    HrhNum, 
    Blk, 
    DieNum, 
    OorNumGet

