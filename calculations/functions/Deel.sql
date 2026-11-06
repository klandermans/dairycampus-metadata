create FUNCTION [dbo].[Deel] (@Teller real, @Noemer Real)
RETURNS real
AS
BEGIN
	Declare @Antwoord real
	
	if @Noemer > 0 Set @Antwoord = @Teller / @Noemer
	else
	Set @Antwoord = 0
	
	RETURN @antwoord

END
