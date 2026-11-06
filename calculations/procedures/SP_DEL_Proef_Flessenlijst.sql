
-- =============================================
-- Author:		Willem Jan Kortleve
-- Create date: 16-02-2016
-- Description:	Update_Proef
-- =============================================
CREATE PROCEDURE [dbo].[SP_DEL_Proef_Flessenlijst] 	
	@PrfCod varchar(20),
	@Dat DateTime	
AS
BEGIN
	
	SET NOCOUNT ON;

	DELETE FROM T_Proef_Flessenlijst_Dier WHERE PrfCod=@PrfCod AND Dat = @Dat
	DELETE FROM T_Proef_Flessenlijst WHERE PrfCod=@PrfCod AND Dat = @Dat
		
END

