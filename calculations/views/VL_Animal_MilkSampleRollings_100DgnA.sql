CREATE VIEW dbo.VL_Animal_MilkSampleRollings_100DgnA
AS
SELECT        AnimalServerID, LactationNo, LactationDays, ABS(LactationDays - 100) AS Lac100Dgn
FROM            dbo.T_Animal_MilkSampleRollings
WHERE        (LactationDays BETWEEN 70 AND 130)
