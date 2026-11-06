CREATE VIEW [dbo].[VL_Trioliet_Laad_SomPerDat]
AS

SELECT        
    Dat, 
    ROUND(SUM(PrtKgRea), 0) AS SumPrtKgRea
FROM            
    dbo.T_Bedrijf_Voermengsel_Laad
GROUP BY 
    Dat

