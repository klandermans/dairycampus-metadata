
/**
  * Recursive Stored procedure ValidateDay
  * 
  * Validate @table aggregrated by @date based on a moving average of @sum 
  * This procedure is building the validate table
  * When no parameters are specified, the constructor is started
  * 
  *
  * According to the documentation, Microsoft states: Avoid the use of the sp_ prefix when naming procedures. 
  * This prefix is used by SQL Server to designate system procedures. Using the prefix can cause application code to break if there is a system procedure with the same name.
  *
  * @author Bert Klandermans <bert.klandermans@wur.nl>
  *
  * @table      the table to validate
  * @date       the name of the date column to validate
  * @sum        the column to sum and compare with the moving average
  * 
  * @return bool 
  * 
  */
-- exec SP_validateDay
CREATE procedure [dbo].[DC_validateDay] (@table NVARCHAR(MAX)='construct', @date NVARCHAR(MAX)=null, @sum NVARCHAR(MAX)=null) as
begin
    declare @sql NVARCHAR(MAX)
    
end



