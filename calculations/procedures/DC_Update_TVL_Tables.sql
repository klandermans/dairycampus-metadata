CREATE PROCEDURE [dbo].[DC_Update_TVL_Tables] (@view NVARCHAR(MAX) = 'construct', @dat NVARCHAR(MAX) = 'dat',  @date NVARCHAR(MAX) = 'construct') AS
BEGIN


    begin try
        DECLARE @sql NVARCHAR(MAX);
        DECLARE @tempTableName NVARCHAR(255);
        DECLARE @destTableName NVARCHAR(255);

        
        PRINT(@view);

        SET @tempTableName = CONCAT('#T', @view);
        SET @destTableName = CONCAT('T', @view);
        
        if @date = 'construct' begin
            -- SET @sql = '
            --     SELECT * INTO ' + QUOTENAME(@tempTableName) + ' 
            --     FROM ' + QUOTENAME(@view) + ' 
            --     WHERE ' + QUOTENAME(@dat) + '  > DATEADD(dd, -90, GETDATE()) AND ' + QUOTENAME(@dat) + ' < DATEADD(dd, 90, GETDATE());

            --     DELETE FROM ' + QUOTENAME(@destTableName) + ' 
            --     WHERE ' + QUOTENAME(@dat) + ' > DATEADD(dd, -90, GETDATE()) AND ' + QUOTENAME(@dat) + ' < DATEADD(dd, 90, GETDATE());

            --     INSERT INTO ' + QUOTENAME(@destTableName) + ' 
            --     SELECT * FROM ' + QUOTENAME(@tempTableName) + ';';
            declare @startDate date;
            declare @endDate date;
            declare @currentDate date;
            SET @startDate = DATEADD(DAY, -120, GETDATE());
            SET @endDate = DATEADD(DAY, 120, GETDATE());
            SET @currentDate = @startDate;
            WHILE @currentDate <= @endDate

                BEGIN
                    SET @sql =  '
                        begin transaction;

                        SELECT * INTO ' + QUOTENAME(@tempTableName) + ' 
                        FROM ' + QUOTENAME(@view) + ' 
                        WHERE ' + QUOTENAME(@dat) + ' = ''' + CONVERT(NVARCHAR(10), @currentDate, 120) + ''';

                        DELETE FROM ' + QUOTENAME(@destTableName) + ' 
                        WHERE ' + QUOTENAME(@dat) + ' = ''' + CONVERT(NVARCHAR(10), @currentDate, 120) + ''';

                        INSERT INTO ' + QUOTENAME(@destTableName) + ' 
                        SELECT * FROM ' + QUOTENAME(@tempTableName) + ';
                        
                        commit';
        
                    EXEC sp_executesql @sql;
                        SET @currentDate = DATEADD(DAY, 1, @currentDate);
                END

                


           
        end
        if @date != 'construct'  BEGIN


            SET @sql = '
                SELECT * INTO ' + QUOTENAME(@tempTableName) + ' 
                FROM ' + QUOTENAME(@view) + ' 
                WHERE ' + QUOTENAME(@dat) + ' =''' + (@date) + ''';

                DELETE FROM ' + QUOTENAME(@destTableName) + ' 
                WHERE ' + QUOTENAME(@dat) + ' =''' + (@date) + ''';

                INSERT INTO ' + QUOTENAME(@destTableName) + ' 
                SELECT * FROM ' + QUOTENAME(@tempTableName) + ';';
            print(@sql)
            EXEC sp_executesql @sql;
        end
    
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        DECLARE @ErrorMessage NVARCHAR(MAX);
        DECLARE @ErrorSeverity INT;
        DECLARE @ErrorState INT;

        SELECT 
            @ErrorMessage = ERROR_MESSAGE(),
            @ErrorSeverity = ERROR_SEVERITY(),
            @ErrorState = ERROR_STATE();

        RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH
END
