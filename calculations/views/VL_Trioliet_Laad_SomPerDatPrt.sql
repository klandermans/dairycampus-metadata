CREATE VIEW [dbo].[VL_Trioliet_Laad_SomPerDatPrt]
AS
SELECT        
    DS.Jaa, DS.WeeNum, TL.Dat, TL.MngNam, TL.PrtNam, 
    ROUND(SUM(TL.PrtKgRea), 2) AS SumKgRea, TLTot.SumKgReaTot, 
    ROUND(AVG(TL.PrtDS), 1) AS PrtDS, 
                            
    ROUND(SUM(TL.PrtKgRea * TL.PrtDS / 100), 2) AS SumKgDSRea, 
    ROUND(dbo.Deel(SUM(TL.PrtKgRea * TL.PrtDS / 100), 
    TLTot.SumKgReaTot), 3) AS KgDSPerKgRea, 
    TLTot.SumKgDSReaTot, 
    ROUND(dbo.Deel(SUM(TL.PrtKgRea * TL.PrtDS), TLTot.SumKgDSReaTot), 1) AS SumKgDSReaPct, 
    DS.DS_Gem AS PrtDS_Gem, 
    ROUND(SUM(TL.PrtKgRea * DS.DS_Gem / 1000), 0) AS SumKgDSGemRea, 
    ROUND(dbo.Deel(SUM(TL.PrtKgRea * DS.DS_Gem / 1000), TLTot.SumKgReaTot), 3)  AS KgDSGemPerKgRea
FROM            
    dbo.T_Bedrijf_Voermengsel_Laad AS TL 
LEFT OUTER JOIN
    dbo.VL_Trioliet_Laad_SomPerDatMngDS AS TLTot ON TL.MngNam = TLTot.MngNam AND TL.Dat = TLTot.Dat 
LEFT OUTER JOIN
    dbo.VL_Bedrijf_Voerpartij_DS_Gem AS DS ON TL.PrtNam = DS.PrtNam
WHERE        
    (DATEPART(YY, TL.Dat) = DS.Jaa) AND (DATEPART(ISOWK, TL.Dat) = DS.WeeNum)
GROUP BY TL.Dat, TL.MngNam, TL.PrtNam, DS.DS_Gem, TLTot.SumKgReaTot, TLTot.SumKgDSReaTot, DS.Jaa, DS.WeeNum

