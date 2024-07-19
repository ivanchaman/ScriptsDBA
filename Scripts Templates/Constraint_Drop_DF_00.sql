
IF EXISTS (SELECT * FROM <database_name, sysname, MyDB>.INFORMATION_SCHEMA.CONSTRAINT_COLUMN_USAGE
            WHERE CONSTRAINT_NAME = N'DF_<table_name_prefix, NVARCHAR(50), tbl><table_name, sysname, ThisTable>_<column_name_constraint_is_on, sysname, ThisColumn>')
BEGIN
    EXEC procOutput N'Dropping constraint DF_<table_name_prefix, NVARCHAR(50), tbl><table_name, sysname, ThisTable>_<column_name_constraint_is_on, sysname, ThisColumn>'

    ALTER TABLE <database_name, sysname, ConsolidatedDB>.<schema_name, sysname, dbo>.<table_name_prefix, sysname, tbl><table_name, sysname, ThisTable>
     DROP CONSTRAINT DF_<table_name_prefix, NVARCHAR(50), tbl><table_name, sysname, ThisTable>_<column_name_constraint_is_on, sysname, ThisColumn>
END

SET @nMyErr = @@ERROR, @nRowsAffected = @@ROWCOUNT IF @nMyErr != 0 BEGIN RAISERROR('     <Failure Message, NVARCHAR, *** Failed to ...> - @@ERROR: %d', 16, 1, @nMyErr) IF 0 < @@TRANCOUNT ROLLBACK RETURN END
