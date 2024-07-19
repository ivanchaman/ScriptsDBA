
-- Add a check constraint to a table if not already there.
GO                    -- Is required if you just created the table.

IF NOT EXISTS (SELECT * FROM <database_name, sysname, MyDB>.INFORMATION_SCHEMA.CHECK_CONSTRAINTS
                WHERE CONSTRAINT_SCHEMA = N'<schema_name, sysname, dbo>'
                  AND CONSTRAINT_NAME   = N'CK_<table_name, sysname, ThisTable>_<column_name, sysname, >')
BEGIN
    RAISERROR(N'Creating check constraint CK_<table_name, sysname, ThisTable>_<column_name, sysname, >', 10, 1) WITH NOWAIT<with_log, sysname, , LOG >

    ALTER TABLE <schema_name, sysname, dbo>.<table_name_prefix, sysname, tbl><table_name, sysname, ThisTable>
      ADD CONSTRAINT CK_<table_name, sysname, ThisTable>_<column_name, sysname, >
            CHECK (<check_constraint, sysname, Salary = 50000.00>)

    SET @nMyErr = @@ERROR, @nRowsAffected = @@ROWCOUNT IF @nMyErr != 0 BEGIN RAISERROR('     <Failure Message, NVARCHAR, *** Failed to ...> - @@ERROR: %d', 16, 1, @nMyErr) IF 0 < @@TRANCOUNT ROLLBACK RETURN END
END




-- Change all raiserror from 16 to 20??
