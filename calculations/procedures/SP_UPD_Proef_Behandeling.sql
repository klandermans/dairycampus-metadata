
-- =============================================
-- Author:		Willem Jan Kortleve
-- Create date: 16-02-2016
-- Description:	Update_Behandeling
-- =============================================
CREATE PROCEDURE [dbo].[SP_UPD_Proef_Behandeling] 
	@PrfCod varchar(20),
	@BehCod varchar(20),
	@BehNam varchar(50),
	@username varchar(100),
	@RowId int		
AS
BEGIN
	
	SET NOCOUNT ON;
	    
	UPDATE T_Proef_Behandeling SET
	   PrfCod = @PrfCod,
	   BehCod = @BehCod,
	   BehNam = @BehNam,
	   AccUpd = @username,
	   DatUpd = GETDATE()
	WHERE RowID = @RowId
END

