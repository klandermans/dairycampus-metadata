-- =============================================
-- Author:		Hans
-- Create date: 9-10-17
-- Description:	Plaatst de gebruikte medicijnen per diagnoseID en per datum in een string
-- =============================================
CREATE FUNCTION [dbo].[Medicijnen](@DieNum as int, @BehDat as date)

RETURNS varchar(500)
AS
BEGIN
	
	DECLARE @MedOmsTot as varchar(500)
	DECLARE @MedOms as varchar(100)

	Declare Cursor_Med Cursor Local Fast_Forward For 
		Select MedicineDesc From T_Animal_TreatmentActions Where AnimalServerID = @DieNum And TreatmentDateDT = @BehDat 

	Set @MedOmsTot = ''
	Open Cursor_Med
	Fetch Next From Cursor_Med INTO @MedOms
	While @@Fetch_Status = 0
		Begin
			Set @MedOmsTot = @MedOmsTot + '[' + @MedOms + '] '
			Fetch Next From Cursor_Med INTO @MedOms
		End

	Return @MedOmsTot

END
