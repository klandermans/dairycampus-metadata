CREATE VIEW [dbo].[VL_Trioliet_Laad_DS_Gem]
AS
SELECT        
    DATEPART(YY, Dat) AS Jaa, 
    DATEPART(ISOWK, Dat) AS WeeNum, 
    PrtNam, ROUND(AVG(PrtDS), 1) AS DS_Gem_Trioliet
FROM            
    dbo.T_Bedrijf_Voermengsel_Laad
GROUP BY DATEPART(YY, Dat), DATEPART(ISOWK, Dat), PrtNam

