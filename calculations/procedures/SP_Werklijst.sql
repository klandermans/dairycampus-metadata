-- =============================================
-- Author:		Hans van den Heuvel
-- Create date: 
-- Description:	Verwerken werklijst 
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

CREATE PROCEDURE [dbo].[SP_Werklijst]
	
AS
BEGIN

	SET NOCOUNT ON;

	Declare @PrfCod as varchar(20)
	Declare @BegDatPrf as datetime
	Declare @VlgNum as int
	Declare @ActTxt as varchar(100)
	Declare	@IndGrp as varchar(20)
	Declare @OngMin as varchar(20)
	Declare @AntDgnWkn as int
	Declare @GebPerMom as varchar(20)
	Declare @WekDag as varchar(20)
	Declare @OpLst as int
	Declare @ParPrc as varchar(20)

	Declare curWerklijst Cursor For 
		Select PrfCod, VlgNum, ActTxt, IndGrp, OngMin, AntDgnWkn, GebPerMom, WekDag, OpLst
		From T_Proef_Werklijst 
		Where PrfCod In (Select PrfCod From T_Proef Where (EndDat Is Null Or EndDat > GetDate()))
		Order By PrfCod, VlgNum

	Open curWerklijst
	Fetch Next From curWerklijst Into @PrfCod, @VlgNum, @ActTxt, @IndGrp, @OngMin, @AntDgnWkn, @GebPerMom, @WekDag, @OpLst

	Truncate Table T_Proef_Werklijst_Actie

	While @@Fetch_Status = 0
	Begin
		if @GebPerMom = 'IedDag' Set @ParPrc = 'IedDag'
		Else If @GebPerMom = 'IedWek' Set @ParPrc = 'IedWek'
		Else If @GebPerMom = 'DgnNaBegPrf' And @IndGrp = 'Ind' Set @ParPrc = 'BegPrf_DagIndNa'
		Else If @GebPerMom = 'WknNaBegPrf' And @IndGrp = 'Ind' Set @ParPrc = 'BegPrf_WekIndNa'
		Else If @GebPerMom = 'DgnNaBegPrf' And @IndGrp = 'Grp' Set @ParPrc = 'BegPrf_DagGrpNa'
		Else If @GebPerMom = 'WknNaBegPrf' And @IndGrp = 'Grp' Set @ParPrc = 'BegPrf_WekGrpNa'
		Else If @GebPerMom = 'DgnNaGeb' Set @ParPrc = 'GebKlf_DagIndNa'
		Else If @GebPerMom = 'WknNaGeb' Set @ParPrc = 'GebKlf_WekIndNa'
		Else If @GebPerMom = 'DgnVorAfk' Set @ParPrc = 'AfkKoe_DagIndVor'
		Else If @GebPerMom = 'WknVorAfk' Set @ParPrc = 'AfkKoe_WekIndVor'
		Else If @GebPerMom = 'DgnNaAfk' Set @ParPrc = 'AfkKoe_DagIndNa'
		Else If @GebPerMom = 'WknNaAfk' Set @ParPrc = 'AfkKoe_WekIndNa'
		Else Set @ParPrc = 'Fout'
		
		Execute dbo.SP_Werklijst1 @ParPrc, @PrfCod, @VlgNum, @ActTxt, @IndGrp, @OngMin, @AntDgnWkn, @GebPerMom, @WekDag, @OpLst
		
		Fetch Next From curWerklijst Into @PrfCod, @VlgNum, @ActTxt, @IndGrp, @OngMin, @AntDgnWkn, @GebPerMom, @WekDag, @opLst
	End 

	close curWerklijst
   
END

