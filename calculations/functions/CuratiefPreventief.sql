-- =============================================
-- Author:		Hans
-- Create date: 12-3-18
-- Description:	Plaatst de gebruikte medicijnen per diagnoseID en per datum in een string
-- =============================================
create FUNCTION [dbo].[CuratiefPreventief](@DieNum as int, @DiaDat as date)

RETURNS varchar(500)
AS
BEGIN
	
	DECLARE @CurOmsTot as varchar(500)
	DECLARE @CurOms as varchar(100)

	Declare Cursor_Cur Cursor Local Fast_Forward For 
		Select TreatmentPlanTypeName From T_Animal_Diagnosis Where AnimalServerID = @DieNum And DiagnosisDateDT = @DiaDat 

	Set @CurOmsTot = ''
	Open Cursor_Cur
	Fetch Next From Cursor_Cur INTO @CurOms
	While @@Fetch_Status = 0
		Begin
			Set @CurOmsTot = @CurOmsTot + '[' + @CurOms + '] '
			Fetch Next From Cursor_Cur INTO @CurOms
		End

	Return @CurOmsTot

END

