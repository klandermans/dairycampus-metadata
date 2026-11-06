CREATE VIEW dbo.VL_Trioliet_Batch_AntPerDat
AS
SELECT        Dat, COUNT(OpdID) AS CntBat
FROM            dbo.T_Bedrijf_Voermengsel_Batch
GROUP BY Dat
