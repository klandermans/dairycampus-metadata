-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION [dbo].[DatumsVooruit]
(@Cnt as int)
RETURNS TABLE 
AS
RETURN 
(
WITH cte AS (
	SELECT GetDate() AS myDate
    UNION ALL
    SELECT DATEADD(day,1,myDate) as myDate
    FROM cte
    WHERE DATEADD(day,1,myDate) <=  Dateadd(day, (@Cnt-1), GetDate())
)
SELECT cast(myDate as date) as Dat
FROM cte
)