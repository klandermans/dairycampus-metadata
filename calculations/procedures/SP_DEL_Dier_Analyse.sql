
-- =============================================
-- Author:		Willem Jan Kortleve
-- Create date: 16-02-2016
-- Description:	Update_Proef
-- =============================================
CREATE PROCEDURE [dbo].[SP_DEL_Dier_Analyse] 
	@Dat DateTime,
	@MedCod varchar(20)	
AS
BEGIN
	
	SET NOCOUNT ON;

	DELETE FROM  T_Dier_Analyse_Parameter WHERE Dat = @Dat AND MedCod = @MedCod
	DELETE FROM  T_Dier_Analyse_Melkgift WHERE Dat = @Dat AND MedCod = @MedCod
	DELETE FROM  T_Dier_Analyse WHERE Dat = @Dat AND MedCod = @MedCod
	
END

