CREATE VIEW [dbo].[VL_Trioliet_Laad_SomPerDatMngDS]
AS
    SELECT        
        DS.Jaa, DS.WeeNum, TL.Dat, TL.MngNam, 
        ROUND(SUM(TL.PrtKgRea), 0) AS SumKgReaTot, 
        ROUND(SUM(TL.PrtKgRea * TL.PrtDS / 100), 0) AS SumKgDSReaTot
    FROM            
        dbo.T_Bedrijf_Voermengsel_Laad AS TL 
    LEFT OUTER JOIN
        dbo.VL_Bedrijf_Voerpartij_DS_Gem AS DS ON TL.PrtNam = DS.PrtNam
    WHERE        
        (DATEPART(YY, TL.Dat) = DS.Jaa) AND (DATEPART(ISOWK, TL.Dat) = DS.WeeNum)
    GROUP BY TL.Dat, TL.MngNam, DS.Jaa, DS.WeeNum
