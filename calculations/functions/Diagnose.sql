-- =============================================
-- Author:		Hans
-- Create date: 12-3-18
-- Description:	Plaatst de gebruikte medicijnen per diagnoseID en per datum in een string
-- =============================================
CREATE FUNCTION [dbo].[Diagnose](@DieNum as int, @DiaDat as date)

RETURNS varchar(500)
AS
BEGIN
	
	DECLARE @DiaOmsTot as varchar(500)
	DECLARE @DiaOms as varchar(100)

	Declare Cursor_Dia Cursor Local Fast_Forward For 
		Select DisorderDesc From T_Animal_Diagnosis Where AnimalServerID = @DieNum And DiagnosisDateDT = @DiaDat 

	Set @DiaOmsTot = ''
	Open Cursor_Dia
	Fetch Next From Cursor_Dia INTO @DiaOms
	While @@Fetch_Status = 0
		Begin
			Set @DiaOmsTot = @DiaOmsTot + '[' + @DiaOms + '] '
			Fetch Next From Cursor_Dia INTO @DiaOms
		End

	Return @DiaOmsTot

END
