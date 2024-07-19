    IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
                    WHERE CONSTRAINT_CATALOG = '<database_name, sysname, MyDB>'
                      AND CONSTRAINT_NAME    = 'PK_<table_name, sysname, ThisTable>')
                      AND TABLE_NAME         = '<table_name_prefix, NVARCHAR(50), tbl><table_name, sysname, ThisTable>'
                      AND CONSTRAINT_TYPE    = 'PRIMARY KEY')
    BEGIN
        RAISERROR(N'Adding PRIMARY KEY constraint PK_<table_name, sysname, ThisTable>', 10, 1) WITH NOWAIT<with_log, sysname, , LOG >

        ALTER TABLE <schema_name, sysname, dbo>.<table_name_prefix, NVARCHAR(50), tbl><table_name, sysname, ThisTable>
          ADD CONSTRAINT PK_<table_name, sysname, ThisTable> PRIMARY KEY (<columns_in_primary_key, NVARCHAR(MAX), ThisPkColumn, ThatPkColumn>)

        SET @nMyErr = @@ERROR, @nRowsAffected = @@ROWCOUNT IF @nMyErr != 0 BEGIN RAISERROR('     <Failure Message, NVARCHAR, *** Failed to ...> - @@ERROR: %d', 16, 1, @nMyErr) IF 0 < @@TRANCOUNT ROLLBACK RETURN END
    END
    
    
    
            Add extended property for primary key?
