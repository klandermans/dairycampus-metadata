
CREATE VIEW [dbo].[VL_ControleKrachtvoer_Partijen]
AS
/*
 * Deze view wordt gebruikt in het access rapport RL_Controle_Krachtvoer
 */
SELECT        
    PrfCod, 
    BehCod, 
    PrcComCod, 
    KvrNum, 
    SilNum, 
    BegDat, 
    EinDat, 
    PrtNam, 
    Opm
FROM            
    dbo.T_Bedrijf_Procescomputer_Voersilo
WHERE 
    (PrfCod IN (SELECT DISTINCT PrfCod FROM dbo.VL_ControleKrachtvoer))

