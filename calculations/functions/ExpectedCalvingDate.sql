
CREATE FUNCTION ExpectedCalvingDate (@MatingDate as Datetime, @FertilityStatus as varchar(20))

RETURNS DateTime
AS
BEGIN
	
	DECLARE @ExpCalDat as datetime
	
	If @FertilityStatus = 'Pregnant' 
		Set @ExpCalDat = @MatingDate + 270
	else
		Set @ExpCalDat = NULL

	RETURN  @ExpCalDat 

END
