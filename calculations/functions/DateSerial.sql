CREATE FUNCTION dbo.DateSerial
(
  @year int ,
  @month int ,
  @day bigint
)
RETURNS datetime
AS
BEGIN
   DECLARE @date datetime
   -- catch invalid year entries and default appropriately
   SET @year = 
      CASE WHEN @year < 1900 THEN 1900
         WHEN @year > 9999 THEN year(getdate())
         ELSE @year
      END
   -- convert date by adding together like yyyymmdd
   SET @date = cast(@year * 10000 + 101 AS char(8))
   ;
      
   -- Add to date the proper months subtracting 1,
   -- since we used 1 as start instead of zero.    
   SET @date = dateadd(mm , @month - 1 , @date)
   -- Add to date the proper days subtracting 1,
   -- since we used 1 as start instead of zero.    
   SET @date = dateadd(dd , @day - 1 , @date)
   ;
      
   RETURN @date ;
END

