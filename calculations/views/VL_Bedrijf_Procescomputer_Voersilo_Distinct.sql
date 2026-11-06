CREATE VIEW dbo.VL_Bedrijf_Procescomputer_Voersilo_Distinct
AS
SELECT DISTINCT PrfCod, BehCod, PrcComCod, KvrNum, BegDat, PrtNam, EinDat
FROM            dbo.T_Bedrijf_Procescomputer_Voersilo
