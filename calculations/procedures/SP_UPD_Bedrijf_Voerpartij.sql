
-- =============================================
-- Author:		Willem Jan Kortleve
-- Create date: 16-02-2016
-- Description:	Update_Bedrijf_Voerpartij
-- =============================================
CREATE PROCEDURE [dbo].[SP_UPD_Bedrijf_Voerpartij] 
	@PrtNam varchar(20),
	@VoeTypCod varchar(20),
	@PrtOms varchar(1000),
	@Act int,
	@username varchar(100),
	@RowId int		
AS
BEGIN
	
	SET NOCOUNT ON;
	    
	UPDATE T_Bedrijf_Voerpartij SET
	   Prtnam = @PrtNam,
	   VoeTypCod = @VoeTypCod,
	   PrtOms = @PrtOms,
	   Act = @Act,	   
	   AccUpd = @username,
	   DatUpd = GETDATE()
	WHERE RowID = @RowId
END

