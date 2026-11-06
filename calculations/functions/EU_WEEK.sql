
CREATE FUNCTION [dbo].[EU_WEEK] (@Dat as datetime)
RETURNS int
with SCHEMABINDING
AS
BEGIN
	
	RETURN datepart(ISO_Week, @Dat)

END

