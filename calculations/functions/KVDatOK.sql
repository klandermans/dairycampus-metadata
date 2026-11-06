
Create FUNCTION [dbo].[KVDatOK](@KVkDat as datetime) 

RETURNS int

AS
BEGIN
	
	DECLARE @intKVOK as int
	DECLARE @intKVNOK as int
	
	Set @intKVNOK = 0
	
	SELECT @intKVNOK = KVNOK From T_LogboekNOK Where Dat = @KVkDat

	If @intKVNOK = 0 
		Set @intKVOK= 1
	else
		Set @intKVOK= 0

	Return @intKVOK

END
