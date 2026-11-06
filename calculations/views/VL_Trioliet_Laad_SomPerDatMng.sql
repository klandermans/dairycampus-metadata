CREATE VIEW dbo.VL_Trioliet_Laad_SomPerDatMng
AS
SELECT        Dat, OpdID, MngNam, ROUND(SUM(PrtKgRea), 0) AS SumPrtKgRea
FROM            dbo.T_Bedrijf_Voermengsel_Laad
GROUP BY Dat, MngNam, OpdID
