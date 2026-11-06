CREATE VIEW dbo.VL_Trioliet_Los_SomPerDat
AS
SELECT        Dat, ROUND(SUM(MngKgRea), 0) AS SumMngKgRea, COUNT(Bak) AS CntBak
FROM            dbo.T_Bedrijf_Voermengsel_Los
GROUP BY Dat
