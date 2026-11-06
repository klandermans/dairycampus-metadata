CREATE VIEW dbo.VL_Proef_VoerVerbruik_KV
AS
SELECT        dbo.EU_JAAR(Dat) AS Jar, dbo.EU_WEEK(Dat) AS Wek, PrtNam, PrfCod, COUNT(*) AS DieDag, CAST(SUM(VoeGft - VoeRst) AS float) AS VoeOpn
FROM            dbo.TVL_Dier_Voeropname_KV
WHERE        (PrfCod IS NOT NULL)
GROUP BY dbo.EU_JAAR(Dat), dbo.EU_WEEK(Dat), PrtNam, PrfCod
