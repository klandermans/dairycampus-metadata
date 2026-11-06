-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[UrenMinutenSeconden] (@Sec as int)

RETURNS varchar(9)
AS
BEGIN
	Declare @uummss as varchar(9)
	Declare @uu as int
	Declare @mm as int
	Declare @ss as int
	Declare @Rest as int

	Set @uu = @Sec / 3600
	Set @Rest = @Sec % 3600

	Set @mm = @Rest / 60
	Set @ss = @Rest % 60

	Set @uummss = format(@uu,'#00') + ':' + format(@mm,'00')  + ':' + format(@ss,'00')

	Return @uummss

END

