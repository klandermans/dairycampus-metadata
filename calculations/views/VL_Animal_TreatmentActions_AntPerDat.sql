CREATE VIEW dbo.VL_Animal_TreatmentActions_AntPerDat
AS
SELECT        AnimalServerID AS DieNum, AnimalDiagnosisID AS DiaID, TreatmentDateDT AS BehDat, COUNT(TreatmentDateDT) AS AntBeh
FROM            dbo.T_Animal_TreatmentActions
GROUP BY AnimalServerID, AnimalDiagnosisID, TreatmentDateDT
