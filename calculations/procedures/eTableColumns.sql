
CREATE PROCEDURE [dbo].[eTableColumns] (@Table VARCHAR(100))
AS
SELECT ColumnNames = 
   STUFF( (SELECT ', ' +  c.name
FROM    
    sys.columns c
INNER JOIN 
    sys.types t ON c.user_type_id = t.user_type_id
WHERE
    c.object_id = OBJECT_ID( @Table)
        FOR XML PATH, TYPE).value('.[1]','varchar(2000)'),
    1, 1, '')

