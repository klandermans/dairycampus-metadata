CREATE  procedure [dbo].[DC_Log] (@subject NVARCHAR(MAX)='construct', @message NVARCHAR(MAX)=null) 
as begin
   print('insert into t_validate_log ([date], [subject], [message]) values (GETDATE(), '''+@subject+''','''+@message+''')')
   execute ('insert into t_validate_log ([date], [subject], [message]) values (GETDATE(), '''+@subject+''','''+@message+''')')

end



