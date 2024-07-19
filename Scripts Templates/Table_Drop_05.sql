Are there any dependent tables with FKs that must be dropped first?


-----------------------------------------------------------------------------
-- Drop table <table_name_prefix, NVARCHAR(50), tbl><table_name, sysname, ThisTable>.
-----------------------------------------------------------------------------

IF EXISTS (SELECT * FROM <database_name, sysname, MyDB>.sys.tables WHERE name = '<table_name_prefix, NVARCHAR(50), tbl><table_name, sysname, ThisTable>')
BEGIN
    RAISERROR('Dropping the <table_name_prefix, NVARCHAR(50), tbl><table_name, sysname, ThisTable> table from the <database_name, sysname, MyDB> database', 10, 1) WITH NOWAIT, LOG
    DROP TABLE <database_name, sysname, MyDB>.<schema_name, sysname, dbo>.<table_name_prefix, NVARCHAR(50), tbl><table_name, sysname, ThisTable>
END
