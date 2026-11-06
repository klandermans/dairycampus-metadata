CREATE VIEW [dbo].[VL_Dier_Voeropname_KV1]
AS
SELECT        
    AnimalServerID AS DieNum, 
    FeedStartPeriodDateDT AS Dat, 
    ProcessComputerAbbr + '-' + CAST(ProcessComputerFeedID AS varchar(4)) AS VoeNum, 
    ISNULL(QuantityProgrammed, 0) - ISNULL(QuantityRemainFeed, 0) AS Opn
FROM            
    dbo.TB_Animal_Feedings
