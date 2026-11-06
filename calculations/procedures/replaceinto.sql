CREATE PROCEDURE replaceinto
(
    @TargetTable NVARCHAR(128),
    @SourceTable NVARCHAR(128)
)
AS
BEGIN
    DECLARE @KeyColumns NVARCHAR(MAX) = '';
    DECLARE @Columns NVARCHAR(MAX) = '';
    DECLARE @Values NVARCHAR(MAX) = '';
    DECLARE @UpdatePairs NVARCHAR(MAX) = '';
    DECLARE @sql NVARCHAR(MAX);

    -- Vind de primaire sleutels van de doeltabel
    SELECT @KeyColumns = STRING_AGG(QUOTENAME(COLUMN_NAME), ' AND target.')
    FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE
    WHERE TABLE_NAME = @TargetTable
    AND OBJECTPROPERTY(OBJECT_ID(CONSTRAINT_SCHEMA + '.' + CONSTRAINT_NAME), 'IsPrimaryKey') = 1;

    -- Verifieer dat er een primaire sleutel is gevonden
    IF @KeyColumns IS NULL
    BEGIN
        RAISERROR('Er is geen primaire sleutel gevonden in de doeltabel.', 16, 1);
        RETURN;
    END

    -- Vind alle kolommen van de doeltabel
    SELECT @Columns = STRING_AGG(QUOTENAME(COLUMN_NAME), ', '),
           @Values = STRING_AGG('source.' + QUOTENAME(COLUMN_NAME), ', '),
           @UpdatePairs = STRING_AGG('target.' + QUOTENAME(COLUMN_NAME) + ' = source.' + QUOTENAME(COLUMN_NAME), ', ')
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE TABLE_NAME = @TargetTable;

    -- Bouw de dynamische SQL voor de MERGE-statement
    SET @sql = '
    MERGE ' + QUOTENAME(@TargetTable) + ' AS target
    USING ' + QUOTENAME(@SourceTable) + ' AS source
    ON ' + @KeyColumns + '
    WHEN MATCHED THEN
        UPDATE SET ' + @UpdatePairs + '
    WHEN NOT MATCHED BY TARGET THEN
        INSERT (' + @Columns + ')
        VALUES (' + @Values + ');';

    -- Voer de dynamische SQL uit
    EXEC sp_executesql @sql;
END;