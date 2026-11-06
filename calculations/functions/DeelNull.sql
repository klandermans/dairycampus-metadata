create FUNCTION [dbo].[DeelNull] (@Teller real, @Noemer Real)
RETURNS real
AS
BEGIN
	Declare @Antwoord real
	
	if @Noemer > 0 Set @Antwoord = @Teller / @Noemer
	else
	Set @Antwoord = Null
	
	RETURN @antwoord

END

