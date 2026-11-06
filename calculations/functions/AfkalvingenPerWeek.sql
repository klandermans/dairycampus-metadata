-- =============================================
-- Author:		Hans van den Heuvel
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION AfkalvingenPerWeek()

RETURNS real
AS
BEGIN
	
	DECLARE @AfkWek real

	SELECT @AfkWek = (isnull(AntMlkKoe,0)*7.0)/isnull(TKT,999999) From TC_Plan_Instelling 

	RETURN @AfkWek

END
