
CREATE FUNCTION [dbo].[MelkDatOK](@MlkDat as datetime) 

RETURNS int

AS
BEGIN
	
	DECLARE @intMlkOK as int
	DECLARE @intMlkNOK as int
	
	Set @intMlkNOK = 0
	
	SELECT @intMlkNOK = MlkNOK From T_LogboekNOK Where Dat = @MlkDat

	If @intMlkNOK = 0 
		Set @intMlkOK= 1
	else
		Set @intMlkOK= 0

	Return @intMlkOK

END
