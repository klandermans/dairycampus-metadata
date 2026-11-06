CREATE VIEW [dbo].[VL_Datum_Werklijst1]
AS
SELECT        Dat, Jar, Wek, WekDag
FROM            dbo.VL_DatumTerug100
WHERE        Dat > GetDate() - 3
UNION
SELECT        Dat, Jar, Wek, WekDag
FROM            dbo.VL_DatumVooruit100
WHERE        Dat < GetDate() + 14
