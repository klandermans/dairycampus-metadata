
-- =============================================
-- Author:		Willem Jan Kortleve
-- Create date: 16-02-2016
-- Description:	Update_Proef
-- =============================================
CREATE PROCEDURE [dbo].[SP_UPD_Proef] 
	@PrfCod varchar(20),
	@PrfNam varchar(50),
	@NamOnd varchar(50),
	@BegDat DateTime,
	@EndDat DateTime,	
	@username varchar(100),
	@RowId int		
AS
BEGIN
	
	SET NOCOUNT ON;
	    
	UPDATE T_Proef SET
	   PrfCod = @PrfCod,
	   Prfnam = @PrfNam,
	   NamOnd = @NamOnd,
	   BegDat = @BegDat,
	   EndDat = @EndDat,	   
	   AccUpd = @username,
	   DatUpd = GETDATE()
	WHERE RowID = @RowId
END

