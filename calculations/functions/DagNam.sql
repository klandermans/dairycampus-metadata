-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[DagNam] (@DagNum as int)

RETURNS varchar(2)
with SCHEMABINDING
AS
BEGIN
	Declare @DagNam as varchar(2)

	If @DagNum = 1 Set @DagNam = 'Zo' 
		Else If @DagNum = 2 Set @DagNam = 'Ma' 
		Else If @DagNum = 3 Set @DagNam = 'Di' 
		Else If @DagNum = 4 Set @DagNam = 'Wo' 
		Else If @DagNum = 5 Set @DagNam = 'Do' 
		Else If @DagNum = 6 Set @DagNam = 'Vr' 
		Else If @DagNum = 7 Set @DagNam = 'Za' 
		Else Set @DagNam = 'XX' 

	Return @DagNam

END

