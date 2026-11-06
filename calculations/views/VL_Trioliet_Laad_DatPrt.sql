CREATE VIEW [dbo].[VL_Trioliet_Laad_DatPrt]
AS
SELECT        
    L.Dat, L.MngNam, L.OpdID, L.PrtNam, 
    
    ROUND(L.PrtDS, 2) AS PrtDS, 
    ROUND(L.PrtKgRea, 2) AS PrtKgRea, 
    
    ROUND(L.PrtDS * L.PrtKgRea / 100, 2) AS KgDSRea, 
    ROUND(L.PrtDS * L.PrtKgPln / 100, 2) AS KgDSPln, 
    
    iif(S.SumKgDS > 0,  
        ROUND(L.PrtDS * L.PrtKgRea / 100 / S.SumKgDS * 100, 2),0
    ) AS PctDSRea, 
    
    iif(S.SumKgDS > 0, 
        ROUND(L.PrtDS * L.PrtKgPln / 100 / S.SumKgDSPln * 100, 2),0
    ) AS PctDSPln, 
    --    dit is een taaie!
    Round(
            iif(S.SumKgDS > 0 AND S.SumKgDSPln > 0 AND L.PrtDS > 0 AND L.PrtKgPln > 0, 
                ((L.PrtDS * L.PrtKgRea / 100 / S.SumKgDS * 100) - (L.PrtDS * L.PrtKgPln / 100 / S.SumKgDSPln * 100)) / (L.PrtDS * L.PrtKgPln / 100 / S.SumKgDSPln * 100), 0
            ) * 100
    , 0) AS PctDSVrs

FROM dbo.T_Bedrijf_Voermengsel_Laad AS L 
INNER JOIN dbo.VL_Trioliet_Laad_SomDatPrt AS S ON L.Dat = S.Dat AND L.MngNam = S.MngNam AND L.OpdID = S.OpdID

