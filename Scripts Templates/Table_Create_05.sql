
-----------------------------------------------------------------------------
-- Create table <table_name_prefix, NVARCHAR(50), tbl><table_name, sysname, ThisTable>.
-----------------------------------------------------------------------------

IF NOT EXISTS (SELECT * FROM <database_name, sysname, MyDB>.sys.tables WHERE name = '<table_name_prefix, NVARCHAR(50), tbl><table_name, sysname, ThisTable>')
BEGIN
    RAISERROR('Creating table <table_name_prefix, NVARCHAR(50), tbl><table_name, sysname, ThisTable> in database <database_name, sysname, MyDB>', 10, 1) WITH NOWAIT, LOG

    -- Create table, columns, column constraints, and PK constraint and index.
    CREATE TABLE <database_name, sysname, MyDB>.<schema_name, sysname, dbo>.<table_name_prefix, NVARCHAR(50), tbl><table_name, sysname, ThisTable>
    (
        <table_name, sysname, ThisTable>Index   INT IDENTITY (1, 1)    NOT NULL,

                        Add your other columns here.

        CONSTRAINT PK_<table_name, sysname, ThisTable> PRIMARY KEY CLUSTERED (<table_name, sysname, ThisTable>Index) WITH FILLFACTOR = <fill_factor, INT, 70>,
    )


                - - Add extended properties for table.
                - - Add extended property for PK Index?
                - - Add extended properties for columns!

    RAISERROR('Created  table <table_name_prefix, NVARCHAR(50), tbl><table_name, sysname, ThisTable> in database <database_name, sysname, MyDB>', 10, 1) WITH NOWAIT, LOG
END


-----------------------------------------------------------------------------
-- Verify table <table_name_prefix, NVARCHAR(50), tbl><table_name, sysname, ThisTable> was created.
-- If not, sever the SQL Server connection to prevent subsequent statements
-- from executing, as they may so damage since this table doesn't exist.
-----------------------------------------------------------------------------

IF NOT EXISTS (SELECT * FROM <database_name, sysname, MyDB>.sys.tables WHERE name = '<table_name_prefix, NVARCHAR(50), tbl><table_name, sysname, ThisTable>')
BEGIN
    RAISERROR('Failed to create table <table_name_prefix, NVARCHAR(50), tbl><table_name, sysname, ThisTable> in database <database_name, sysname, MyDB>', 20, 1) WITH NOWAIT, LOG
    RETURN
GO

                - - Add indexes.

