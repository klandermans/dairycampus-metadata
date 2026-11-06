
CREATE FUNCTION [dbo].[EU_JAAR] (@Dat as datetime)
RETURNS int
with SCHEMABINDING
AS
BEGIN
	Declare @Jar as int
	Declare @Mnd as int
	Declare @Wek as int
	Declare @Jar2 as int

	Set @Jar = datepart(year, @Dat)
	Set @Mnd = datepart(month, @Dat)
	Set @Wek = datepart(ISO_Week, @Dat)

	Set @Jar2 = @Jar
	If @Mnd = 12 And @Wek = 1 Set @Jar2 = @Jar + 1 
	If @Mnd = 1 And @Wek >= 52 Set @Jar2 = @Jar - 1 

	RETURN @Jar2

END

