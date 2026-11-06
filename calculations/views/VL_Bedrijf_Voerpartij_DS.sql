CREATE VIEW [dbo].[VL_Bedrijf_Voerpartij_DS]
AS
SELECT        
    PrtNam, 
    DATEPART(YY, DatMa) AS Jaa, 
    DATEPART(ISOWK, DatMa) AS WeeNum, 
    DatMa, 
    DS_Ma, 
    DS_Di, 
    DS_Wo, 
    DS_Do, 
    DS_Vr, 
    DS_Za, 
    DS_Zo, 
    AccIns, 
    AccUpd, 
                         
    DatIns, 
    DatUpd, 
    RowID, 
    dbo.WeekGemiddelde_DS(PrtNam, DatMa) AS DS_Gem
FROM            
    dbo.T_Bedrijf_Voerpartij_DS

