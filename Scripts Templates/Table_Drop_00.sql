
-----------------------------------------------------------------------------
-- Drop table <table_name_prefix, NVARCHAR(50), tbl><table_name, sysname, ThisTable>.
-----------------------------------------------------------------------------

IF EXISTS (SELECT * FROM <database_name, sysname, MyDB>.INFORMATION_SCHEMA.TABLES
            WHERE TABLE_CATALOG = N'<database_name, sysname, MyDB>'
              AND TABLE_NAME    = N'<table_name_prefix, sysname, tbl><table_name, sysname, ThisTable>')
BEGIN
    RAISERROR('Dropping the <table_name_prefix, NVARCHAR(50), tbl><table_name, sysname, ThisTable> table from the <database_name, sysname, MyDB> database', 10, 1) WITH NOWAIT, LOG
    DROP TABLE <database_name, sysname, MyDB>.<schema_name, sysname, dbo>.<table_name_prefix, sysname, tbl><table_name, sysname, ThisTable>
    SET @nMyErr = @@ERROR, @nRowsAffected = @@ROWCOUNT IF @nMyErr != 0 BEGIN RAISERROR('     <Failure Message, NVARCHAR, *** Failed to ...> - @@ERROR: %d', 16, 1, @nMyErr) IF 0 < @@TRANCOUNT ROLLBACK RETURN END
    RAISERROR('Dropped  the <table_name_prefix, NVARCHAR(50), tbl><table_name, sysname, ThisTable> table from the <database_name, sysname, MyDB> database', 10, 1) WITH NOWAIT, LOG
END
