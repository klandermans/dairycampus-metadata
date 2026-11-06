-- =============================================
-- Author:		Hans van den Heuvel
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
/*	VlgNum	ParPrc					Per		IndGrp	GebCod	Mom
	1		IedDag					Dag		Grp		
	2		IedWek					Wek		Grp		
	3		BegPrf_DagIndNa			Dag		Ind		BegPrf	Na
	4		BegPrf_WekIndNa			Wek		Ind		BegPrf	Na
	5		BegPrf_DagGrpNa			Dag		Grp		BegPrf	Na
	6		BegPrf_WekGrpNa			Wek		Grp		BegPrf	Na
	7		GebKlf_DagIndNa			Dag		Ind		GebKlf	Na
	8		GebKlf_WekIndNa			Wek		Ind		GebKlf	Na
	9		AfkKoe_DagIndVor		Dag		Ind		AfkKoe	Vor
	10		AfkKoe_DagIndNa			Dag		Ind		AfkKoe	Na
	11		AfkKoe_WekIndVor		Wek		Ind		AfkKoe	Vor
	12		AfkKoe_WekIndNa			Wek		Ind		AfkKoe	Na
*/


CREATE PROCEDURE [dbo].[SP_Werklijst1]
	@ParPrc as varchar(20),
	@PrfCod as varchar(20),
	@VlgNum as int,
	@ActTxt as varchar(100),
	@IndGrp as varchar(20), 
	@OngMin as varchar(20), 
	@AntDgnWkn as int, 
	@GebPerMom as varchar(20), 
	@WekDag as varchar(20),
	@OpLst as int
	
AS
BEGIN
	
	--Declare @MinDat as datetime
	Declare @DgnMin as int
	Declare @DgnMax as int
	Declare @GebPerMomOms as varchar(50) 

	SET NOCOUNT ON;

	Select @GebPerMomOms = WanOms From TC_Proef_Werklijst_Wanneer Where WanCod = @GebPerMom

	if @ParPrc = 'IedDag' 
		Begin
			Insert Into T_Proef_Werklijst_Actie (PrfCod, VlgNum, Dat, Jar, Wek, WekDag, ActTxt, GebPerMom, OpLst, InsDat)  
				Select @PrfCod, @VlgNum, Dat, Jar, Wek, WekDag, @ActTxt, @GebPerMomOms, @OpLst, GetDate()
				From VL_Proef_Datum_Werklijst
				Where PrfCod = @PrfCod
		End

	Else If @ParPrc = 'IedWek' 
		Begin
			Insert Into T_Proef_Werklijst_Actie (PrfCod, VlgNum, Dat, Jar, Wek, WekDag, ActTxt, GebPerMom, OpLst, InsDat)  
				Select @PrfCod, @VlgNum, Dat, Jar, Wek, WekDag, @ActTxt, @GebPerMomOms, @OpLst, GetDate()
				From VL_Proef_Datum_Werklijst
				Where WekDag = @WekDag
				And PrfCod = @PrfCod

		End

	Else If @ParPrc = 'BegPrf_DagIndNa' 
		Begin
			Insert Into T_Proef_Werklijst_Actie (PrfCod, VlgNum, Dat, Jar, Wek, WekDag, ActTxt, GebPerMom, DieNum, OorNum, OorNumGet, OpLst, Hok, InsDat)  
				Select @PrfCod, @VlgNum, Dat, Jar, Wek, WekDag, @ActTxt, cast(@AntDgnWkn as varchar(5)) + ' ' + @GebPerMomOms, DieNum, OorNum, OorNumGet, @OpLst, Hok, GetDate()
				From VL_Dier_Datum_Werklijst
				Where Dat = dateadd(day,@AntDgnWkn,BegDatPrf)
				And PrfCod = @PrfCod
		End
	
	Else If @ParPrc = 'BegPrf_WekIndNa' 
		Begin
			If @OngMin = 'Min' 
				Set @DgnMin = @AntDgnWkn * 7 
			Else 
				Set @DgnMin = @AntDgnWkn * 7 - 3

			Insert Into T_Proef_Werklijst_Actie (PrfCod, VlgNum, Dat, Jar, Wek, WekDag, ActTxt, GebPerMom, DieNum, OorNum, OorNumGet, AntDgnWknRea, OpLst, Hok, InsDat)  
				Select @PrfCod, @VlgNum, Dat, Jar, Wek, WekDag, @ActTxt, cast(@AntDgnWkn as varchar(5)) + ' ' + @GebPerMomOms, DieNum, OorNum, OorNumGet, DateDiff(day,BegDatPrf,Dat) , @OpLst, Hok, GetDate()
				From VL_Dier_Datum_Werklijst as QRY
				Where Dat = (	Select Min(Dat) 
								From VL_Dier_Datum_Werklijst 
								Where PrfCod = QRY.PrfCod
								And DieNum = QRY.DieNum
								And WekDag = @WekDag
								And Dat Between DateAdd(day,@DgnMin,BegDatPrf) And DateAdd(day,@DgnMin+6,BegDatPrf)
								And PrfCod = @PrfCod)
		End
	
	Else If @ParPrc = 'BegPrf_DagGrpNa' 
		Begin
			Insert Into T_Proef_Werklijst_Actie (PrfCod, VlgNum, Dat, Jar, Wek, WekDag, ActTxt, GebPerMom, OpLst, InsDat)  
				Select @PrfCod, @VlgNum, Dat, Jar, Wek, WekDag, @ActTxt, cast(@AntDgnWkn as varchar(4)) + ' ' + @GebPerMomOms, @OpLst, GetDate()
				From VL_Proef_Datum_Werklijst as QRY
				Where PrfCod = @PrfCod
				And Dat = DateAdd(day,@AntDgnWkn,BegDat)
		End
	
   	Else If @ParPrc = 'BegPrf_WekGrpNa' 
		Begin
			If @OngMin = 'Min' 
				Set @DgnMin = @AntDgnWkn * 7 
			Else 
				Set @DgnMin = @AntDgnWkn * 7 - 3

			Insert Into T_Proef_Werklijst_Actie (PrfCod, VlgNum, Dat, Jar, Wek, WekDag, ActTxt, GebPerMom, AntDgnWknRea, OpLst, InsDat)  
				Select @PrfCod, @VlgNum, Dat, Jar, Wek, WekDag, @ActTxt, cast(@AntDgnWkn as varchar(5)) + ' ' + @GebPerMomOms, DateDiff(day,BegDat,Dat) , @OpLst, GetDate()
				From VL_Proef_Datum_Werklijst as QRY
				Where Dat = (	Select Min(Dat) 
								From VL_Proef_Datum_Werklijst 
								Where PrfCod = QRY.PrfCod
								And WekDag = @WekDag
								And Dat Between DateAdd(day,@DgnMin,BegDat) And DateAdd(day,@DgnMin+6,BegDat)
								And PrfCod = @PrfCod)
		End
 

		Else If @ParPrc = 'GebKlf_DagIndNa' 
		Begin
			Insert Into T_Proef_Werklijst_Actie (PrfCod, VlgNum, Dat, Jar, Wek, WekDag, ActTxt, GebPerMom, DieNum, OorNum, OorNumGet, OpLst, Hok, InsDat)  
				Select @PrfCod, @VlgNum, Dat, Jar, Wek, WekDag, @ActTxt, cast(@AntDgnWkn as varchar(5)) + ' ' +  @GebPerMomOms, DieNum, OorNum, OorNumGet, @OpLst, Hok, GetDate()
				From VL_Dier_Datum_Werklijst
				Where Dat = dateadd(day,@AntDgnWkn,GebDat)
				And PrfCod = @PrfCod
		End
	
	Else If @ParPrc = 'GebKlf_WekIndNa' 
		Begin
			If @OngMin = 'Min' 
				Set @DgnMin = @AntDgnWkn * 7 
			Else 
				Set @DgnMin = @AntDgnWkn * 7 - 3

			Insert Into T_Proef_Werklijst_Actie (PrfCod, VlgNum, Dat, Jar, Wek, WekDag, ActTxt, GebPerMom, DieNum, OorNum, OorNumGet, AntDgnWknRea, OpLst, Hok, InsDat)  
				Select @PrfCod, @VlgNum, Dat, Jar, Wek, WekDag, @ActTxt, cast(@AntDgnWkn as varchar(5)) + ' ' + @GebPerMomOms, DieNum, OorNum, OorNumGet, DateDiff(day,GebDat,Dat) , @OpLst, Hok, GetDate()
				From VL_Dier_Datum_Werklijst as QRY
				Where Dat = (	Select Min(Dat) 
								From VL_Dier_Datum_Werklijst 
								Where PrfCod = QRY.PrfCod
								And DieNum = QRY.DieNum
								And WekDag = @WekDag
								And Dat Between DateAdd(day,@DgnMin,GebDat) And DateAdd(day,@DgnMin+6,GebDat)
								And PrfCod = @PrfCod)
		End

		Else If @ParPrc = 'AfkKoe_DagIndVor' 
		Begin
			Insert Into T_Proef_Werklijst_Actie (PrfCod, VlgNum, Dat, Jar, Wek, WekDag, ActTxt, GebPerMom, DieNum, OorNum, OorNumGet, OpLst, Hok, InsDat)  
				Select @PrfCod, @VlgNum, Dat, Jar, Wek, WekDag, @ActTxt, cast(@AntDgnWkn as varchar(5)) + ' ' +  @GebPerMomOms, DieNum, OorNum, OorNumGet, @OpLst, Hok, GetDate()
				From VL_Dier_Datum_Werklijst
				Where Dat = dateadd(day,-@AntDgnWkn,VrwKlfDat)
				And PrfCod = @PrfCod
		End

		Else If @ParPrc = 'AfkKoe_DagIndNa' 
		Begin
			Insert Into T_Proef_Werklijst_Actie (PrfCod, VlgNum, Dat, Jar, Wek, WekDag, ActTxt, GebPerMom, DieNum, OorNum, OorNumGet, OpLst, Hok, InsDat)  
				Select @PrfCod, @VlgNum, Dat, Jar, Wek, WekDag, @ActTxt, cast(@AntDgnWkn as varchar(5)) + ' ' +  @GebPerMomOms, DieNum, OorNum, OorNumGet, @OpLst, Hok, GetDate()
				From VL_Dier_Datum_Werklijst
				Where Dat = dateadd(day,@AntDgnWkn,KlfDat)
				And PrfCod = @PrfCod
		End


	Else If @ParPrc = 'AfkKoe_WekIndVor' 
		Begin
			If @OngMin = 'Min' 
				Set @DgnMin = @AntDgnWkn * 7 
			Else 
				Set @DgnMin = @AntDgnWkn * 7 - 3

			Insert Into T_Proef_Werklijst_Actie (PrfCod, VlgNum, Dat, Jar, Wek, WekDag, ActTxt, GebPerMom, DieNum, OorNum, OorNumGet, AntDgnWknRea, OpLst, Hok, InsDat)  
				Select @PrfCod, @VlgNum, Dat, Jar, Wek, WekDag, @ActTxt, cast(@AntDgnWkn as varchar(5)) + ' ' + @GebPerMomOms, DieNum, OorNum, OorNumGet, DateDiff(day,VrwKlfDat,Dat) , @OpLst, Hok, GetDate()
				From VL_Dier_Datum_Werklijst as QRY
				Where Dat = (	Select Min(Dat) 
								From VL_Dier_Datum_Werklijst 
								Where PrfCod = QRY.PrfCod
								And DieNum = QRY.DieNum
								And WekDag = @WekDag
								And Dat Between DateAdd(day,-@DgnMin-6,VrwKlfDat) And DateAdd(day,-@DgnMin,VrwKlfDat)
								And PrfCod = @PrfCod)
		End

	Else If @ParPrc = 'AfkKoe_WekIndNa' 
		Begin
			If @OngMin = 'Min' 
				Set @DgnMin = @AntDgnWkn * 7 
			Else 
				Set @DgnMin = @AntDgnWkn * 7 - 3

			Insert Into T_Proef_Werklijst_Actie (PrfCod, VlgNum, Dat, Jar, Wek, WekDag, ActTxt, GebPerMom, DieNum, OorNum, OorNumGet, AntDgnWknRea, OpLst, Hok, InsDat)  
				Select @PrfCod, @VlgNum, Dat, Jar, Wek, WekDag, @ActTxt, cast(@AntDgnWkn as varchar(5)) + ' ' + @GebPerMomOms, DieNum, OorNum, OorNumGet, DateDiff(day,KlfDat,Dat) , @OpLst, Hok, GetDate()
				From VL_Dier_Datum_Werklijst as QRY
				Where Dat = (	Select Min(Dat) 
								From VL_Dier_Datum_Werklijst 
								Where PrfCod = QRY.PrfCod
								And DieNum = QRY.DieNum
								And WekDag = @WekDag
								And Dat Between DateAdd(day,@DgnMin,KlfDat) And DateAdd(day,@DgnMin+6,KlfDat)
								And PrfCod = @PrfCod)
		End
		
END

