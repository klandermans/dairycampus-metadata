
CREATE FUNCTION [dbo].[UuMm] (@DatTyd as Datetime)

RETURNS varchar(5)
AS
BEGIN
	Declare @Tijd as varchar(5)
	Declare @hh as int
	Declare @mm as int

	Set @hh = DATEPART(hh, @DatTyd)
	Set @mm = DATEPART(mi, @DatTyd)

	Set @Tijd = Format(@hh,'00') + ':' + Format(@mm,'00')

	RETURN @Tijd

END
