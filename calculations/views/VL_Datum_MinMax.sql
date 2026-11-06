CREATE VIEW [dbo].[VL_Datum_MinMax]
AS
SELECT        MIN(Dat) AS MinDat, MAX(Dat) AS MaxDat
FROM            dbo.T_Datum
