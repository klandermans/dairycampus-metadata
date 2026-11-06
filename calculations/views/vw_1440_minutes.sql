create view [dbo].[vw_1440_minutes] as
WITH RangeCTE AS (
    SELECT 1 AS Number
    UNION ALL
    SELECT Number + 1
    FROM RangeCTE
    WHERE Number < 1440 -- Het eindgetal instellen
)
SELECT dateadd(mi, Number,  FORMAT(GETDATE(), 'yyyy-MM-dd HH:mm')) as datetime
FROM RangeCTE
-- OPTION (MAXRECURSION 1440) 
