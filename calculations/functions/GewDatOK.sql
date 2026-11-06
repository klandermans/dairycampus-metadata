
create FUNCTION [dbo].[GewDatOK](@GewkDat as datetime) 

RETURNS int

AS
BEGIN
	
	DECLARE @intGewOK as int
	DECLARE @intGewNOK as int
	
	Set @intGewNOK = 0
	
	SELECT @intGewNOK = GewNOK From T_LogboekNOK Where Dat = @GewkDat

	If @intGewNOK = 0 
		Set @intGewOK= 1
	else
		Set @intGewOK= 0

	Return @intGewOK

END
