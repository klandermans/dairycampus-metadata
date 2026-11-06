
CREATE VIEW [dbo].[VL_Dier_Datum_Totaal]
AS

SELECT        
    cast(Prf.Dat as date) as Dat,  
    Prf.Jar, 
    Prf.Wek, 
    Prf.WekDag, 
    Prf.PrfCod, 
    Prf.BehCod, 
    Prf.HrhNum, 
    Prf.Blk, 
    Stl.Hok, 
    Prf.DieNum, 
    Prf.LevNum, 
    Prf.OorNum, 
    Prf.OorNumGet, 
    cast(Prf.BegDatPrf as date) as BegDatPrf, 
    cast(Prf.EndDatPrf as date) as EndDatPrf, 
    cast(Prf.GebDat as date) as GebDat, 
    Prf.LftDgn, 
    Prf.LacNum, 
    cast(Prf.KlfDat as date) as KlfDat, 
    Prf.LacDgn, 
    Prf.InsDat, 
    cast(Prf.DrgZetDat as date) as DrgZetDat, 
    cast(Prf.VrwKlfDat as date) as VrwKlfDat, 
    cast(Prf.VlgKlfDat as date) as VlgKlfDat, 
    Prf.VrwDgn, 
    Prf.PrdSta, 
    

    cast(kv.[SAC-1] as float) as [SAC-1] ,
    cast(kv.[SAC-2] as float) as [SAC-2] ,
    cast(kv.[SAC-3] as float) as [SAC-3] ,
    cast(kv.[SAC-4] as float) as [SAC-4] ,
    cast(kv.[C21-9] as float) as [C21-9] ,
    cast(kv.[C21-10] as float) as [C21-10] ,
    cast(kv.[DelPro-13] as float) as [DelPro-13], 

    -- KV.[SAC-1], 
    -- KV.[SAC-2], 
    -- KV.[SAC-3], 
    -- KV.[SAC-4], 
    -- KV.[C21-9], 
    -- KV.[C21-10], 
    -- KV.[DelPro-13], 
    
    RV.SumOpnDSTri AS OpnRV, 
    Gew.GewO, 
    Gew.GewA, 
    Mlk.AntMlkO, 
    Mlk.KgMlkO, 
    Mlk.AntMlkA, 
    Mlk.KgMlkA, 
    MlkCon.MilkQuantityMass AS MlkStd, 
    MlkCon.FatPercentage AS VetStd, MlkCon.ProteinPercentage AS EiwStd, 
    MlkCon.LactosePercentage AS LacStd,
    MlkCon.KetosisCode AS KetStd, MlkCon.Urea AS UreStd, 
    MlkCon.SCCDay AS CelStd, 
    
    MlkAna.Vet AS VetPrf, 
    MlkAna.Eiwit AS EiwPrf, 
    MlkAna.Lactose AS LacPrf, 
    MlkAna.Ureum AS UrePrf, 
    MlkAna.Celgetal AS CelPrf, 

    
    ROUND(Crv.Fat_Concentration,3) AS VetAo, 
    ROUND(Crv.Protein_Concentration,3) AS EiwAo, 
    ROUND(Crv.Lactose_Concentration,3) AS LacAo, 
    ROUND(Crv.Urea_Concentration,1) AS UreAo, 
    ROUND(Crv.SCC,0) AS CelAo, 

    BCS.Sco, 
    ZieBeh.DiaOms, 
    ZieBeh.MedOms, 
    ZieBeh.CurPrev
FROM            
    dbo.TVL_Dier_Datum_Proef    AS Prf 
LEFT OUTER JOIN dbo.TVL_Dier_Score_Conditie  AS BCS ON Prf.Dat = BCS.Dat AND Prf.DieNum = BCS.DieNum 
LEFT OUTER JOIN dbo.TVL_Dier_Melkgift_Etmaal_Melkcontrole AS Mlk ON Prf.DieNum = Mlk.DieNum AND Prf.Dat = Mlk.Dat 
LEFT OUTER JOIN dbo.TVL_Dier_Datum_Crv AS Crv ON Prf.DieNum = Crv.AnimalServerID AND Prf.Dat = Crv.Date 
LEFT OUTER JOIN dbo.T_Animal_MilkSamples AS MlkCon ON Prf.Dat = MlkCon.SampleDateDT AND Prf.DieNum = MlkCon.AnimalServerID 
LEFT OUTER JOIN dbo.TVL_Dier_ZiekteBehandeling AS ZieBeh ON Prf.Dat = ZieBeh.Dat AND Prf.DieNum = ZieBeh.DieNum 
LEFT OUTER JOIN dbo.TVL_Dier_Gewicht_Etmaal AS Gew ON Prf.Dat = Gew.Dat AND Prf.DieNum = Gew.DieNum 
LEFT OUTER JOIN dbo.TVL_Dier_Analyse_Parameter_Week AS MlkAna ON Prf.Dat = MlkAna.Dat AND Prf.DieNum = MlkAna.DieNum 
LEFT OUTER JOIN dbo.TVL_Dier_Voeropname_RV_Etmaal AS RV ON Prf.Dat = RV.Dat AND Prf.DieNum = RV.DieNum
LEFT OUTER JOIN dbo.TVL_Dier_Voeropname_KV1_CT AS KV ON Prf.Dat = KV.Dat AND Prf.DieNum = KV.DieNum 
LEFT OUTER JOIN dbo.TVL_Dier_Datum_Stal AS Stl ON Prf.Dat = Stl.Dat AND Prf.DieNum = Stl.DieNum


