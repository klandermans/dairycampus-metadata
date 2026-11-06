CREATE VIEW [dbo].[VL_Trioliet_Laad_SomDatPrt]
AS
/* waarom wordt de drogestof hier al afgerond?*/
SELECT        
    Dat, MngNam, OpdID, 
    ROUND(SUM(PrtDS * PrtKgRea / 100), 1) AS SumKgDS, 
    ROUND(SUM(PrtDS * PrtKgPln / 100), 1) AS SumKgDSPln
FROM            
    dbo.T_Bedrijf_Voermengsel_Laad
GROUP BY Dat, MngNam, OpdID



