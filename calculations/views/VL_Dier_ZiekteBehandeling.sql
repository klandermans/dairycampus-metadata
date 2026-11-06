CREATE VIEW [dbo].[VL_Dier_ZiekteBehandeling]
AS
SELECT        
    AnimalServerID AS DieNum, DiagnosisDateDT AS Dat, 
    dbo.Diagnose(AnimalServerID, DiagnosisDateDT) AS DiaOms, 
    dbo.Medicijnen(AnimalServerID, DiagnosisDateDT) AS MedOms, 
    dbo.CuratiefPreventief(AnimalServerID, DiagnosisDateDT) AS CurPrev
FROM            
    dbo.VL_Animal_Diagnosis_DistinctDate

