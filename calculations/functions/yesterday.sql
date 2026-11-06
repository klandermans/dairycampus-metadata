-- select * from t_validate where cast(date as date) = yesterday()

create function yesterday() RETURNS date AS
 
begin
    return cast(getdate() as date)
end