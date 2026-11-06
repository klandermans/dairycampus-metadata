CREATE VIEW dbo.VL_DatumVooruit100
AS
SELECT        CAST(Dat AS datetime) AS Dat, dbo.EU_JAAR(Dat) AS Jar, dbo.EU_WEEK(Dat) AS Wek, dbo.DagNam(DATEPART(dw, Dat)) AS WekDag
FROM            dbo.DatumsVooruit(100) AS Dat
