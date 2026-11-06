-- =============================================
-- Author:		Hans van den Heuvel
-- Create date: 1-dec-2016
-- 
-- =============================================
CREATE PROCEDURE [dbo].[SP_INS_Trioliet_RIC_Tables]
AS
BEGIN
	SET NOCOUNT ON;

	--TVL_RIC_Dier_Opname_Mengsel
	Begin Try
		Drop Table TVL_RIC_Dier_Opname_Mengsel;
	End Try
	Begin Catch
		If @@ERROR <> 0	Insert Into T_Error (DatTim, ErrSrc, ErrNum, ErrMsg) Values (GetDate(), 'SP_INS_Trioliet_RIC_Tables - TVL_RIC_Dier_Opname_Mengsel', Error_Number(), Error_Message())
	End Catch
	Begin Try
   		SELECT * Into TVL_RIC_Dier_Opname_Mengsel From VL_RIC_Dier_Opname_Mengsel;
		ALTER TABLE TVL_RIC_Dier_Opname_Mengsel add  RowID int identity(1,1);
		ALTER TABLE TVL_RIC_Dier_Opname_Mengsel ADD PRIMARY KEY (RowID);
	End Try
	Begin Catch
		If @@ERROR <> 0	Insert Into T_Error (DatTim, ErrSrc, ErrNum, ErrMsg) Values (GetDate(), 'SP_INS_Trioliet_RIC_Tables - TVL_RIC_Dier_Opname_Mengsel', Error_Number(), Error_Message())
	End Catch

	--TVL_RIC_SomPerDat
	Begin Try
		Drop Table TVL_RIC_SomPerDat;
	End Try
	Begin Catch
		If @@ERROR <> 0	Insert Into T_Error (DatTim, ErrSrc, ErrNum, ErrMsg) Values (GetDate(), 'SP_INS_Trioliet_RIC_Tables - TVL_RIC_SomPerDat', Error_Number(), Error_Message())
	End Catch
	Begin Try
   		SELECT * Into TVL_RIC_SomPerDat From VL_RIC_SomPerDat;
		ALTER TABLE TVL_RIC_SomPerDat add  RowID int identity(1,1);
		ALTER TABLE TVL_RIC_SomPerDat ADD PRIMARY KEY (RowID);
	End Try
	Begin Catch
		If @@ERROR <> 0	Insert Into T_Error (DatTim, ErrSrc, ErrNum, ErrMsg) Values (GetDate(), 'SP_INS_Trioliet_RIC_Tables - TVL_RIC_SomPerDat', Error_Number(), Error_Message())
	End Catch

	--TVL_Trioliet_Laad_DatPrt
	Begin Try
		Drop Table TVL_Trioliet_Laad_DatPrt;
	End Try
	Begin Catch
		If @@ERROR <> 0	Insert Into T_Error (DatTim, ErrSrc, ErrNum, ErrMsg) Values (GetDate(), 'SP_INS_Trioliet_RIC_Tables - TVL_Trioliet_Laad_DatPrt', Error_Number(), Error_Message())
	End Catch
	Begin Try
		SELECT * Into TVL_Trioliet_Laad_DatPrt From VL_Trioliet_Laad_DatPrt;
		ALTER TABLE TVL_Trioliet_Laad_DatPrt add  RowID int identity(1,1);
		ALTER TABLE TVL_Trioliet_Laad_DatPrt ADD PRIMARY KEY (RowID);
	End Try
	Begin Catch
		If @@ERROR <> 0	Insert Into T_Error (DatTim, ErrSrc, ErrNum, ErrMsg) Values (GetDate(), 'SP_INS_Trioliet_RIC_Tables - TVL_Trioliet_Laad_DatPrt', Error_Number(), Error_Message())
	End Catch

	--TVL_Trioliet_LaadLos_SomPerDat
	Begin Try
		Drop Table TVL_Trioliet_LaadLos_SomPerDat;
	End Try
	Begin Catch
		If @@ERROR <> 0	Insert Into T_Error (DatTim, ErrSrc, ErrNum, ErrMsg) Values (GetDate(), 'SP_INS_Trioliet_RIC_Tables - TVL_Trioliet_LaadLos_SomPerDat', Error_Number(), Error_Message())
	End Catch
	Begin Try
		SELECT * Into TVL_Trioliet_LaadLos_SomPerDat From VL_Trioliet_LaadLos_SomPerDat;
		ALTER TABLE TVL_Trioliet_LaadLos_SomPerDat add  RowID int identity(1,1);
		ALTER TABLE TVL_Trioliet_LaadLos_SomPerDat ADD PRIMARY KEY (RowID);
	End Try
	Begin Catch
		If @@ERROR <> 0	Insert Into T_Error (DatTim, ErrSrc, ErrNum, ErrMsg) Values (GetDate(), 'SP_INS_Trioliet_RIC_Tables - TVL_Trioliet_LaadLos_SomPerDat', Error_Number(), Error_Message())
	End Catch

	--TVL_Trioliet_LaadLos_SomPerDatMng
	Begin Try
		Drop Table TVL_Trioliet_LaadLos_SomPerDatMng;
	End Try
	Begin Catch
		If @@ERROR <> 0	Insert Into T_Error (DatTim, ErrSrc, ErrNum, ErrMsg) Values (GetDate(), 'SP_INS_Trioliet_RIC_Tables - TVL_Trioliet_LaadLos_SomPerDatMng', Error_Number(), Error_Message())
	End Catch
	Begin Try
		SELECT * Into TVL_Trioliet_LaadLos_SomPerDatMng From VL_Trioliet_LaadLos_SomPerDatMng;
		ALTER TABLE TVL_Trioliet_LaadLos_SomPerDatMng add  RowID int identity(1,1);
		ALTER TABLE TVL_Trioliet_LaadLos_SomPerDatMng ADD PRIMARY KEY (RowID);
	End Try
	Begin Catch
		If @@ERROR <> 0	Insert Into T_Error (DatTim, ErrSrc, ErrNum, ErrMsg) Values (GetDate(), 'SP_INS_Trioliet_RIC_Tables - TVL_Trioliet_LaadLos_SomPerDatMng', Error_Number(), Error_Message())
	End Catch

	--TVL_Trioliet_Los_BatchBak
	Begin Try
		Drop Table TVL_Trioliet_Los_BatchBak
	End Try
	Begin Catch
		If @@ERROR <> 0	Insert Into T_Error (DatTim, ErrSrc, ErrNum, ErrMsg) Values (GetDate(), 'SP_INS_Trioliet_RIC_Tables - TVL_Trioliet_Los_BatchBak', Error_Number(), Error_Message())
	End Catch
	Begin Try
		SELECT * Into TVL_Trioliet_Los_BatchBak	From VL_Trioliet_Los_BatchBak	
		ALTER TABLE TVL_Trioliet_Los_BatchBak add  RowID int identity(1,1);
		ALTER TABLE TVL_Trioliet_Los_BatchBak ADD PRIMARY KEY (RowID);
	End Try
	Begin Catch
		If @@ERROR <> 0	Insert Into T_Error (DatTim, ErrSrc, ErrNum, ErrMsg) Values (GetDate(), 'SP_INS_Trioliet_RIC_Tables - TVL_Trioliet_Los_BatchBak', Error_Number(), Error_Message())
	End Catch

END


