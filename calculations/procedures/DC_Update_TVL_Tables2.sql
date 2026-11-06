CREATE PROCEDURE [dbo].[DC_Update_TVL_Tables2]
    @view  sysname = N'construct',  -- bv. 'dbo.MyView' of 'MyView'
    @dat   sysname = N'dat',        -- kolomnaam met datum
    @date  date    = NULL           -- NULL = range; anders die ene dag
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON; -- rollbackt automatisch bij fouten

    BEGIN TRY
        ------------------------------------------------------------
        -- Namen robust quoten (ondersteunt 'schema.object' of alleen 'object')
        ------------------------------------------------------------
        DECLARE @schema sysname = ISNULL(PARSENAME(@view, 2), N'dbo');
        DECLARE @object sysname = PARSENAME(@view, 1);
        DECLARE @tmp    nvarchar(300) = N'#T_' + @object;  -- géén QUOTENAME, géén schema, géén punt

        IF @object IS NULL
        BEGIN
            RAISERROR('Parameter @view is ongeldig.', 16, 1);
            RETURN;
        END

        DECLARE @viewQ nvarchar(300) = QUOTENAME(@schema) + N'.' + QUOTENAME(@object);
        DECLARE @destQ nvarchar(300) = QUOTENAME(@schema) + N'.' + QUOTENAME(N'T' + @object);
        DECLARE @colQ  nvarchar(300) = QUOTENAME(@dat);

        ------------------------------------------------------------
        -- Venster voor range (half-open interval: >= start AND < end)
        ------------------------------------------------------------
        DECLARE @startDate date, @endDateExclusive date;

        IF @date IS NULL
        BEGIN
            SET @startDate        = CONVERT(date, DATEADD(DAY, -500, GETDATE()));
            SET @endDateExclusive = DATEADD(DAY, 121, GETDATE()); -- +121 dagen totaal, exclusieve bovengrens
        END

        ------------------------------------------------------------
        -- Date-literals bouwen (YYYY-MM-DD) voor inline SQL
        ------------------------------------------------------------
        DECLARE @startLit nvarchar(30) = NULL;
        DECLARE @endLit   nvarchar(30) = NULL;
        DECLARE @dateLit  nvarchar(30) = NULL;

        IF @date IS NULL
        BEGIN
            SET @startLit = QUOTENAME(CONVERT(nvarchar(10), @startDate, 23), ''''); -- 'YYYY-MM-DD'
            SET @endLit   = QUOTENAME(CONVERT(nvarchar(10), @endDateExclusive, 23), '''');
        END
        ELSE
        BEGIN
            SET @dateLit  = QUOTENAME(CONVERT(nvarchar(10), @date, 23), '''');
        END

        ------------------------------------------------------------
        -- Dynamische SQL (nu ZONDER parameters)
        ------------------------------------------------------------
        DECLARE @sql nvarchar(MAX);

        IF @date IS NULL
        BEGIN
            SET @sql = N'
BEGIN TRAN;

    -- Vervang door nieuwe snapshot uit de view
    SELECT *
    INTO ' + @tmp + N'
    FROM ' + @viewQ + N'
    WHERE ' + @colQ + N' >= ' + @startLit + N'
      AND ' + @colQ + N' <  ' + @endLit + N';

    -- Verwijder doel-rows in één keer
    DELETE FROM ' + @destQ + N'
    WHERE ' + @colQ + N' >= ' + @startLit + N'
      AND ' + @colQ + N' <  ' + @endLit + N';

    INSERT INTO ' + @destQ + N' WITH (TABLOCK)
    SELECT * FROM ' + @tmp + N';

COMMIT;';
            PRINT @sql;  -- voor debug
            EXEC (@sql);
        END
        ELSE
        BEGIN
            SET @sql = N'
BEGIN TRAN;

    SELECT *
    INTO ' + @tmp + N'
    FROM ' + @viewQ + N'
    WHERE ' + @colQ + N' = ' + @dateLit + N';

    DELETE FROM ' + @destQ + N'
    WHERE ' + @colQ + N' = ' + @dateLit + N';

    INSERT INTO ' + @destQ + N' WITH (TABLOCK)
    SELECT * FROM ' + @tmp + N';

COMMIT;';
            PRINT @sql;  -- voor debug
            EXEC (@sql);
        END
    END TRY
    BEGIN CATCH
        IF XACT_STATE() <> 0 ROLLBACK TRANSACTION;
        DECLARE @ErrorMessage nvarchar(MAX) = ERROR_MESSAGE(),
                @ErrorSeverity int = ERROR_SEVERITY(),
                @ErrorState int = ERROR_STATE();
        PRINT(@ErrorMessage);
        RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH
END
