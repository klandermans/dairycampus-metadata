CREATE VIEW [dbo].[VL_Bedrijf_Voerpartij_DS_Gem]
AS
/**
 * In deze view worden de drogestof gehaltes omgerekend naar weegemiddelden.
 **/
SELECT        
    dbo.VL_Trioliet_Laad_DS_Gem.PrtNam, 
    dbo.VL_Trioliet_Laad_DS_Gem.Jaa, 
    dbo.VL_Trioliet_Laad_DS_Gem.WeeNum, 
    -- bert 2020 die scalar functies moeten eriut. dit vertraagde de query 1000x
    -- dbo.WeekGemiddelde_DS(dbo.T_Bedrijf_Voerpartij_DS.PrtNam, dbo.T_Bedrijf_Voerpartij_DS.DatMa) AS DS_Gem, 
    round(
    cast(ds_ma+ds_di+ds_wo+ds_do+ds_vr+ds_za+ds_zo as float) / cast(iif(ds_ma>1,1,0) + iif(ds_di>1,1,0) + iif(ds_wo>1,1,0) + iif(ds_do>1,1,0) + iif(ds_vr>1,1,0) + iif(ds_za>1,1,0) + iif(ds_zo>1,1,0) as float)
    ,0) as DS_Gem,
    ROUND(dbo.VL_Trioliet_Laad_DS_Gem.DS_Gem_Trioliet * 10, 0) AS DS_Gem_Trioliet
FROM            
    dbo.T_Bedrijf_Voerpartij_DS 
RIGHT OUTER JOIN
    dbo.VL_Trioliet_Laad_DS_Gem ON dbo.T_Bedrijf_Voerpartij_DS.PrtNam = dbo.VL_Trioliet_Laad_DS_Gem.PrtNam 
    AND DATEPART(YY, dbo.T_Bedrijf_Voerpartij_DS.DatMa) = dbo.VL_Trioliet_Laad_DS_Gem.Jaa 
    AND DATEPART(ISOWK, dbo.T_Bedrijf_Voerpartij_DS.DatMa) = dbo.VL_Trioliet_Laad_DS_Gem.WeeNum

