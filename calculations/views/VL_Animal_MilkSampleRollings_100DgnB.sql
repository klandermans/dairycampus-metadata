CREATE VIEW dbo.VL_Animal_MilkSampleRollings_100DgnB
AS
SELECT        AnimalServerID, LactationNo, MIN(LactationDays) AS MinLactationDays
FROM            dbo.VL_Animal_MilkSampleRollings_100DgnA AS TA
WHERE        (Lac100Dgn =
                             (SELECT        MIN(ABS(Lac100Dgn)) AS Expr1
                               FROM            dbo.VL_Animal_MilkSampleRollings_100DgnA AS TB
                               WHERE        (TA.AnimalServerID = AnimalServerID) AND (TA.LactationNo = LactationNo)
                               GROUP BY AnimalServerID, LactationNo))
GROUP BY AnimalServerID, LactationNo
