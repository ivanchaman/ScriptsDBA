
IF EXISTS (SELECT * FROM N'<database_name, sysname, MyDB>'.INFORMATION_SCHEMA.COLUMNS
            WHERE TABLE_NAME  = N'<table_name_prefix, sysname, tbl><table_name, sysname, ThisTable>'
              AND COLUMN_NAME = N'<column_name, sysname, >'
              AND IS_NULLABLE = N'<nullability,, NOT NULL>')
BEGIN
    RAISERROR(N'<message, NVARCHAR(400), >', 10, 1) WITH NOWAIT<with_log, sysname, , LOG>


    SET @nMyErr = @@ERROR, @nRowsAffected = @@ROWCOUNT IF @nMyErr != 0 BEGIN RAISERROR('     <Failure Message, NVARCHAR, *** Failed to ...> - @@ERROR: %d', 16, 1, @nMyErr) IF 0 < @@TRANCOUNT ROLLBACK RETURN END
END
