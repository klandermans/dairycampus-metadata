create FUNCTION dbo.Get1440Minutes()
RETURNS TABLE
AS
RETURN
(
    SELECT DateTime
    FROM [dbo].[vw_1440_minutes]
    -- OPTION (MAXRECURSION 1440)
);