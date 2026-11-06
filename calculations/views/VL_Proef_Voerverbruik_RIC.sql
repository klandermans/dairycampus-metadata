CREATE VIEW dbo.VL_Proef_Voerverbruik_RIC
AS
SELECT        dbo.EU_JAAR(Dat) AS Jar, dbo.EU_WEEK(Dat) AS Wek, PrtNam, COUNT(*) AS DieDag, SUM(OpnDS) AS OpnDS
FROM            dbo.TVL_Dier_Voeropname_RV AS OpnRV
WHERE        (PrtNam IS NOT NULL)
GROUP BY dbo.EU_JAAR(Dat), dbo.EU_WEEK(Dat), PrtNam
