CREATE VIEW [dbo].[VL_Dier_Voeropname_KV_OUD]
AS
SELECT        F.AnimalServerID AS DieNum, F.FeedStartPeriodDateDT AS Dat, F.ProcessComputerAbbr AS PrcCom, F.ProcessComputerFeedID AS VoeNum, 
                         F.QuantityProgrammed AS VoeGft, F.QuantityRemainFeed AS VoeRst, P.PrtNam, P.PrfCod, P.BehCod
FROM            dbo.TB_Animal_Feedings AS F INNER JOIN
                         dbo.VL_Proef_Voerpartij AS P ON F.ProcessComputerFeedID = P.KvrNum AND F.ProcessComputerAbbr = P.PrcComCod COLLATE Latin1_General_CI_AS AND 
                         F.AnimalServerID = P.DieNum
WHERE        (F.FeedStartPeriodDateDT BETWEEN P.BegDat AND ISNULL(P.EinDat, DATEADD(day, 2, GETDATE()))) AND (F.QuantityProgrammed > 0)
UNION
SELECT        F.AnimalServerID AS DieNum, F.FeedStartPeriodDateDT AS Dat, F.ProcessComputerAbbr AS PrcCom, F.ProcessComputerFeedID AS VoeNum, 
                         F.QuantityProgrammed AS VoeGft, F.QuantityRemainFeed AS VoeRst, Null, Null, Null
FROM            dbo.TB_Animal_Feedings AS F 
WHERE         (F.QuantityProgrammed > 0)


