CREATE PROCEDURE ExecuteProcedureForEachDay
AS
BEGIN
    DECLARE @StartDate DATE = '2016-07-01';
    DECLARE @EndDate DATE = GETDATE(); -- Today's date
    DECLARE @CurrentDate DATE = @StartDate;
    DECLARE @view NVARCHAR(MAX);
    DECLARE @sql NVARCHAR(MAX);
    DECLARE @tempTableName NVARCHAR(255);
    DECLARE @destTableName NVARCHAR(255);

    SET @view = 'VL_Totaal_Bedrijf';
    PRINT(@view);

    SET @tempTableName = CONCAT('#T', @view);
    SET @destTableName = CONCAT('T', @view);

    WHILE @CurrentDate <= @EndDate
    BEGIN
        SET @sql = '
            SELECT * INTO ' + QUOTENAME(@tempTableName) + ' 
            FROM ' + QUOTENAME(@view) + ' 
            WHERE dat = ''' + CONVERT(NVARCHAR(10), @CurrentDate, 120) + ''';

            DELETE FROM ' + QUOTENAME(@destTableName) + ' 
            WHERE dat = ''' + CONVERT(NVARCHAR(10), @CurrentDate, 120) + ''';

            INSERT INTO ' + QUOTENAME(@destTableName) + ' 
            SELECT * FROM ' + QUOTENAME(@tempTableName) + ';';

        EXEC sp_executesql @sql;
        print(@currentDate)
        SET @CurrentDate = DATEADD(DAY, 1, @CurrentDate);
    END;
END;