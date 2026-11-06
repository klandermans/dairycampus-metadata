/*	=============================================
	Author:		Hans van den Heuvel
	Create date: 22-feb-2016
	Description:	Kopieert de nog niet aanwezige regels een paar tabellen 
					uit de DairyCampus DB naar de DairyCampusPlus DB.

					Het gaat om de tabellen T_Animal_AnimalWeighings, T_Animal_Feedings en T_Animal_Milkings.
					Van deze drie tabellen komen vanuit Agrovision alleen de laatste 50 dagen mee, vanuit performance oogpunt . 
					Door steeds de nieuwe regels naar de Plus DB te kopieren komen alle regels beschikbaar.

					Het wegen van de dieren gebeurt na het melken. De tijdstippen van zowel wegen als melken zijn per koe. 
					Als er wordt gemolken met de robot dan is bevat de laatste datum maar een deel van de dieren, bijvoorbeeld als 
					er kort na 00:00 uur nog een paar koeien zijn gemolken. Dit geldt ook voor wegen. Bij krachtvoeropnamen geldt 
					wel dat de laatste datum voor alle dieren gelijk is. De procedures voor gewicht/melk en krachtvoer verschillen
					hierdoor enigszins.

					De tabelstructuren van de overeenkomstige tabellen zijn identiek, inclusief de PK. Dit maakt het mogelijk
					om de statements eenvoudig te houden: Insert Into <doeltabel> Select * From <brontabel>. Als een Agrovision tabel 
					wijzigt dan moet de Plus tabel meewijzigen. Omdat dat altijd in overleg gaat tussen ons en Agrovision voorzie ik hier
					geen problemen. 
					De PK wordt overgenomen van Agrovision. Daar kan een probleem optreden als de database in Agrovision 
					opnieuw wordt opgebouwd vanuit ComRu. Dan kan de PK wijzigen. Hier nog even over nadenken.
 =============================================
 */

CREATE PROCEDURE [dbo].[DC_Construct_WeightFeedMilk] 
	
AS
BEGIN


    declare @max as DATE

	SET NOCOUNT ON;

	-- Gewichten
	Begin Try
        set @max = (select dateadd(dd, -7, max(WeighDateDT)) from TB_Animal_AnimalWeighings)      
		Delete From TB_Animal_AnimalWeighings Where WeighDateDT >= @max
		Insert Into TB_Animal_AnimalWeighings 
			Select	* From T_Animal_AnimalWeighings
			Where	WeighDateDT >=  @max
	End Try
	Begin Catch
		If @@ERROR <> 0	Insert Into T_Error (DatTim, ErrSrc, ErrNum, ErrMsg) Values (GetDate(), 'SP_INS_Animal_WeightFeedMilk - Weight', Error_Number(), Error_Message())
	End Catch

    -- TODO::  DIT MOET OPGERUIMD WORDEN dit is ook niet goed, agrovisionv erantderd de nummers wel eens.

    set @max = (select dateadd(dd, -7, max(cast(milkingdate as date))) from tb_animal_milkings)
	
    delete from 
		tb_animal_milkings 
	where
		milkingdate >= @max;

	insert into 
		TB_Animal_Milkings 
	select * from t_animal_milkings where milkingdate >= @max

		-- Krachtvoer
	Begin Try
        set @max =  (select dateadd(dd, -2, max(FeedStartPeriodDateDT)) from TB_Animal_Feedings )
		delete From TB_Animal_Feedings Where FeedStartPeriodDateDT >= @max

		Insert Into TB_Animal_Feedings
			Select	null
                    ,[AnimalID]
                    ,[AnimalServerID]
                    ,[AnimalNo]
                    ,[SortAnimalNo]
                    ,[ProcessComputerFeedID]
                    ,[ProcessComputerFeedAbbr]
                    ,[ProcessComputerID]
                    ,[ProcessComputerAbbr]
                    ,[FeedStartPeriodDate]
                    ,[FeedStartPeriodDateDT]
                    ,[FeedStartPeriodTime]
                    ,[AdviceFeedSequenceNo]
                    ,[FeedSchemeType]
                    ,[FeedSchemeTypeName]
                    ,[CalculatedQuantity]
                    ,[RationQuantity]
                    ,[IncreasedRationQuantity]
                    ,[IsManual]
                    ,[Quantity]
                    ,[PercentageDryMatter]
                    ,[QuantityPartMilkingParlour]
                    ,[PercentagePartMilkingParlour]
                    ,[FeedGroupAnimalType]
                    ,[FeedGroupAnimalTypeName]
                    ,[FeedGroupRationSequenceNo]
                    ,[SendDateTime]
                    ,[QuantitySend]
                    ,[QuantitySendPartMilkingParlour]
                    ,[PercentageSendPartMilkingParlour]
                    ,[IsRealySend]
                    ,[ReceiveDateTime]
                    ,[QuantityProgrammed]
                    ,[QuantityRemainFeed] From T_Animal_Feedings
			Where	FeedStartPeriodDateDT >= @max
	End Try
	Begin Catch
		If @@ERROR <> 0	Insert Into T_Error (DatTim, ErrSrc, ErrNum, ErrMsg) Values (GetDate(), 'SP_INS_Animal_WeightFeedMilk - Feed', Error_Number(), Error_Message())
	End Catch

	-- Milkdays
	Begin Try
        set @max = (select dateadd(dd, -2, max(Milkdaydate)) from TB_Animal_Milkdays )

		Delete From TB_Animal_Milkdays Where Milkdaydate >= @max

		Insert Into T_Animal_Milkdays
			Select	* From T_Animal_Milkdays
			Where	Milkdaydate >= @max
	End Try
	Begin Catch
		If @@ERROR <> 0	Insert Into T_Error (DatTim, ErrSrc, ErrNum, ErrMsg) Values (GetDate(), 'SP_INS_Animal_WeightFeedMilk - Milkdaydate', Error_Number(), Error_Message())
	End Catch


END








