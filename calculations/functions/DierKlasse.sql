-- =============================================
-- Author:		Hans van den heuvel
-- Create date: 
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[DierKlasse] (@LacNum as int, @LacDgn as int)

RETURNS varchar(20)
AS
BEGIN
	-- Declare the return variable here
	DECLARE @KlsCod varchar(20)

	-- Add the T-SQL statements to compute the return value here
	SELECT @KlsCod = KlsCod From TC_Plan_DierKlasse Where @LacNum Between LacNumVan And LacNumTot And @LacDgn Between DgnVan And DgnTot

	if @KlsCod is null Set @KlsCod = 0

	RETURN @KlsCod

END
