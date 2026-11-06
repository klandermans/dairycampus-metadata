CREATE VIEW dbo.VL_Trioliet_Batch_AntPerDatMng
AS
SELECT        Dat, MngNam, OpdID, dbo.UuMm(DatTydPln) AS TydPln, dbo.UuMm(DatTydRea) AS TydRea
FROM            dbo.T_Bedrijf_Voermengsel_Batch
