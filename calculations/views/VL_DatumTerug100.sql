CREATE VIEW dbo.VL_DatumTerug100
AS
SELECT        CAST(Dat AS datetime) AS Dat, dbo.EU_JAAR(Dat) AS Jar, dbo.EU_WEEK(Dat) AS Wek, dbo.DagNam(DATEPART(dw, Dat)) AS WekDag
FROM            dbo.DatumsTerug(100) AS Dat
