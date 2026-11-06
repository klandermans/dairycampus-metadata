
Create FUNCTION [dbo].[RVDatOK](@RVkDat as datetime) 

RETURNS int

AS
BEGIN
	
	DECLARE @intRVOK as int
	DECLARE @intRVNOK as int
	
	Set @intRVNOK = 0
	
	SELECT @intRVNOK = RVNOK From T_LogboekNOK Where Dat = @RVkDat

	If @intRVNOK = 0 
		Set @intRVOK= 1
	else
		Set @intRVOK= 0

	Return @intRVOK

END
