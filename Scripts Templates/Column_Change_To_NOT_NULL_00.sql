
    -- If already the nullability we want, nothing to do.
    IF NOT EXISTS (SELECT * FROM <database_name, sysname, MyDB>.INFORMATION_SCHEMA.COLUMNS
                    WHERE TABLE_NAME  = N'<table_name_prefix, sysname, tbl><table_name, sysname, ThisTable>'
                      AND COLUMN_NAME = N'<column_name, sysname, >'
                      AND IS_NULLABLE = N'<nullability,, YES>')
    BEGIN
        -- See BOL for the dozen things that the column cannot be...

        -- Now make the '<column_name, sysname, >' column the nullability we want.
        RAISERROR(N'<message, NVARCHAR(400), >', 10, 1) WITH NOWAIT<with_log, sysname, , LOG>

        ALTER TABLE <table_name_prefix, sysname, tbl><table_name, sysname, ThisTable>
            ALTER COLUMN <column_name, sysname, > <datatype,, INT> <null_text, NVARCHAR(32), NOT NULL>

        SET @nMyErr = @@ERROR, @nRowsAffected = @@ROWCOUNT IF @nMyErr != 0 BEGIN RAISERROR('     <Failure Message, NVARCHAR, *** Failed to ...> - @@ERROR: %d', 16, 1, @nMyErr) IF 0 < @@TRANCOUNT ROLLBACK RETURN END
    END
