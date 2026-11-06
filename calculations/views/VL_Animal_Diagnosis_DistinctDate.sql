CREATE VIEW dbo.VL_Animal_Diagnosis_DistinctDate
AS
SELECT DISTINCT AnimalServerID, DiagnosisDateDT, TreatmentPlanTypeName
FROM            dbo.T_Animal_Diagnosis
