-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[OchtendAvond] (@Tyd as time)

RETURNS varchar(1)
AS
BEGIN
	Declare @OA as varchar(1)

	If datepart(hh, @Tyd) < 12 Set @OA = 'O' Else If datepart(hh, @Tyd) >= 12 Set @OA = 'A' else Set @OA = NULL

	Return @Oa

END
