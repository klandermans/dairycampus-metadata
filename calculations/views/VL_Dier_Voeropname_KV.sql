CREATE VIEW [VL_Dier_Voeropname_KV]
AS
SELECT  
    F.AnimalServerID AS DieNum, 
    F.FeedStartPeriodDateDT AS Dat, 
    F.ProcessComputerAbbr AS PrcCom, 
    F.ProcessComputerFeedID AS VoeNum, 
    F.QuantityProgrammed AS VoeGft, 
    F.QuantityRemainFeed AS VoeRst, 
    P.PrtNam, 
    P.PrfCod, 
    P.BehCod
FROM            
    TB_Animal_Feedings AS F 
LEFT OUTER JOIN VL_Proef_Voerpartij_Datum AS P ON F.ProcessComputerFeedID = P.KvrNum 
    AND F.ProcessComputerAbbr = P.PrcComCod COLLATE Latin1_General_CI_AS 
    AND F.AnimalServerID = P.DieNum 
    AND F.FeedStartPeriodDateDT = P.Dat
WHERE        
    (F.QuantityProgrammed > 0)




