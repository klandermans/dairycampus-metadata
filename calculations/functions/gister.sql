-- select * from t_validate where cast(date as date) = yesterday()

create function gister() returns datetime

AS
 
begin

	DECLARE @r datetime

    select @r=cast(getdate() as date) 
    return @r
end

-- select yesterday()
