CREATE VIEW dbo.VL_Proef_Voerverbruik_Trioliet
AS
SELECT        dbo.EU_JAAR(Dat) AS Jar, dbo.EU_WEEK(Dat) AS Wek, PrtNam, SUM(PrtKgRea) AS KgPrd, SUM(KgDSRea) AS KgDS
FROM            dbo.TVL_Trioliet_Laad_DatPrt
GROUP BY dbo.EU_JAAR(Dat), dbo.EU_WEEK(Dat), PrtNam
