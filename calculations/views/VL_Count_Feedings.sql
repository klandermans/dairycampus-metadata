CREATE VIEW dbo.VL_Count_Feedings
AS
SELECT        TOP (100) PERCENT FeedStartPeriodDateDT, COUNT(ProcessComputerAnimalFeedID) AS FeedCnt
FROM            dbo.T_Animal_Feedings
GROUP BY FeedStartPeriodDateDT
ORDER BY FeedStartPeriodDateDT DESC
