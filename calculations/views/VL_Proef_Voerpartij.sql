CREATE VIEW [dbo].[VL_Proef_Voerpartij]
AS
SELECT DISTINCT 
    P.PrfCod, 
    P.BehCod, 
    P.DieNum, 
    PV.PrcComCod, 
    PV.KvrNum, 
    PV.PrtNam, 
    iif(P.BegDat > PV.BegDat, P.BegDat, PV.BegDat) AS BegDat, 
    iif(P.EndDat IS NOT NULL AND PV.EinDat IS NULL OR P.EndDat < PV.EinDat, P.EndDat, PV.EinDat) AS EinDat
FROM            
    dbo.T_Proef_Dier AS P 
LEFT OUTER JOIN
    dbo.T_Bedrijf_Procescomputer_Voersilo AS PV ON P.PrfCod = PV.PrfCod AND P.BehCod = PV.BehCod

