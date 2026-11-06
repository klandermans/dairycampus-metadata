Create FUNCTION [dbo].[ZitInProeven](@DieNum int) 

RETURNS varchar(250)
AS
BEGIN

	Declare @PrfCod as varchar(50)
	Declare @PrfCods as varchar(250)

	Declare Cursor_Proef Cursor Local Fast_Forward For 
		Select PrfCod From V_Proef_Dier_Hans Where DieNum = @DieNum Order By PrfCod

	Set @PrfCods = ''
	Open Cursor_Proef
	Fetch Next From Cursor_Proef INTO @PrfCod
	While @@Fetch_Status = 0
		Begin
			Set @PrfCods = @PrfCods + '[' + @PrfCod + '] '
			Fetch Next From Cursor_Proef INTO @PrfCod
		End

	Return @PrfCods

END
