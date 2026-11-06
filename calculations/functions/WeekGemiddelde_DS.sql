-- =============================================
-- Author:		hans van den Heuvel
-- Create date: 17-feb-2016
-- Description:	Functie berekend DS-weekgemiddelde 
-- Eenheid g/kg
-- Type int
-- =============================================
CREATE FUNCTION [dbo].[WeekGemiddelde_DS](@PrtNam as varchar(20), @DatMa as date) 

RETURNS real
AS
BEGIN
	
	Declare @DS_Sum as real
	Declare @DS_Cnt as int
	Declare @DS_Avg as real
	Declare @DS_Ma as int
	Declare @DS_Di as int
	Declare @DS_Wo as int
	Declare @DS_Do as int
	Declare @DS_Vr as int
	Declare @DS_Za as int
	Declare @DS_Zo as int

	
	Select @DS_Ma = DS_Ma, @DS_Di = DS_Di, @DS_Wo = DS_Wo, @DS_Do = DS_Do, @DS_Vr = DS_Vr, @DS_Za = DS_Za, @DS_Zo = DS_Zo 
	From T_Bedrijf_Voerpartij_DS
	Where PrtNam = @PrtNam
	And DatMa = @DatMa

	Set @DS_Sum = 0
	Set @DS_Cnt = 0

	If @DS_Ma > 0 
		Begin
			Set @DS_Sum = @DS_Sum + @DS_Ma
			Set @DS_Cnt = @DS_Cnt + 1
		End

	If @DS_Di > 0 
		Begin
			Set @DS_Sum = @DS_Sum + @DS_Di
			Set @DS_Cnt = @DS_Cnt + 1
		End

	If @DS_Wo > 0 
		Begin
			Set @DS_Sum = @DS_Sum + @DS_Wo
			Set @DS_Cnt = @DS_Cnt + 1
		End

	If @DS_Do > 0 
		Begin
			Set @DS_Sum = @DS_Sum + @DS_Do
			Set @DS_Cnt = @DS_Cnt + 1
		End

	If @DS_Vr > 0 
		Begin
			Set @DS_Sum = @DS_Sum + @DS_Vr
			Set @DS_Cnt = @DS_Cnt + 1
		End

	If @DS_Za > 0 
		Begin
			Set @DS_Sum = @DS_Sum + @DS_Za
			Set @DS_Cnt = @DS_Cnt + 1
		End

	If @DS_Zo > 0 
		Begin
			Set @DS_Sum = @DS_Sum + @DS_Zo
			Set @DS_Cnt = @DS_Cnt + 1
		End

	If @DS_Cnt > 0 
		Set @DS_Avg = @DS_Sum / @DS_Cnt
	Else
		Set @DS_Avg=NULL
	

	RETURN round(@DS_Avg,0)

END

