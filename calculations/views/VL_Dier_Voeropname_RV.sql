CREATE VIEW [dbo].[VL_Dier_Voeropname_RV]
AS


SELECT        
    Opn.DieNum, 
    Opn.Dat, Opn.MngNamRic, 
    Opn.MngNam, 
    Prt.PrtNam, 
    Opn.Opn AS OpnRuw, 
    Prt.KgDSPerKgRea AS KgDSPerKgRuw, 
                         
    Opn.Opn * Prt.KgDSPerKgRea AS OpnDSTri, 
    -- ROUND(Opn.Opn * Prt.KgDSPerKgRea, 3) AS OpnDSTri, bert weggehaald
    Prt.KgDSGemPerKgRea AS KgDSGemPerKgRuw, 
    ROUND(Opn.Opn * Prt.KgDSGemPerKgRea, 3) AS OpnDSGem, 
    Opn.Opn * ISNULL(Prt.KgDSGemPerKgRea, Prt.KgDSPerKgRea) AS OpnDS, 
    -- ROUND(Opn.Opn * ISNULL(Prt.KgDSGemPerKgRea, Prt.KgDSPerKgRea), 3) AS OpnDS,  bert weggehaald
    Prt.PrtDS_Gem, 
    Prt.PrtDS

FROM 
    T_Dier_Voeropname_Mengsel AS Opn 
INNER JOIN 
    /* dit is waar de drogestof magie happens */
    VL_Trioliet_Laad_SomPerDatPrt AS Prt ON Opn.Dat = Prt.Dat AND Opn.MngNam = Prt.MngNam




