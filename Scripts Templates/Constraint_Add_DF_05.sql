
    -- Add a default constraint to an existing column if not already one
    -- there (regardless of the default constraint's name).  ANSI considers
    -- 'default' to be a column attribute, not a constraint, so we can't
    -- use INFORMATION_SCHEMA.
    IF NOT EXISTS (SELECT * FROM sys.columns 
                    WHERE cdefault != 0
                      AND id = OBJECT_ID(N'<table_name_prefix, sysname, tbl><table_name, sysname, ThisTable>')
                      AND name = N'<column_name, sysname, >')
    BEGIN
        RAISERROR(N'Adding default constraint DF_<table_name_prefix, NVARCHAR(50), tbl><table_name, sysname, ThisTable>_<column_name_constraint_is_on, sysname, ThisColumn>', 10, 1) WITH NOWAIT<with_log, sysname, , LOG >

        ALTER TABLE <schema_name, sysname, dbo>.<table_name_prefix, sysname, tbl><table_name, sysname, ThisTable>
          ADD CONSTRAINT DF_<table_name_prefix, NVARCHAR(50), tbl><table_name, sysname, ThisTable>_<column_name_constraint_is_on, sysname, ThisColumn>
                DEFAULT <default_expression, sysname, 0>
                FOR <column_name, sysname, column_name>

        SET @nMyErr = @@ERROR, @nRowsAffected = @@ROWCOUNT IF @nMyErr != 0 BEGIN RAISERROR('     <Failure Message, NVARCHAR, *** Failed to ...> - @@ERROR: %d', 16, 1, @nMyErr) IF 0 < @@TRANCOUNT ROLLBACK RETURN END
    END
