CREATE VIEW dbo.VL_Proef_Voerverbruik
AS
SELECT        'TrioRIC' AS Brn, PrtNam, Jar, Wek, KgPrdLaad, KgDSLaad, DieDag, Round(KgDSOpn, 1) AS KgDSOpn, NULL AS KgPrdOpn, NULL AS PrfCod
FROM            dbo.VL_Proef_Voerverbruik_TrioRIC
UNION
SELECT        'RIC_Proef', PrtNam, Jar, Wek, NULL, NULL, DieDag, Round(OpnDS, 1), NULL, PrfCod
FROM            VL_Proef_Voerverbruik_RICPrf
UNION
SELECT        'KV', PrtNam, Jar, Wek, NULL, NULL, DieDag,  NULL, VoeOpn, PrfCod
FROM            dbo.VL_Proef_VoerVerbruik_KV
