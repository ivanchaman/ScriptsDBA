
-----------------------------------------------------------------------------
-- Drop CK constraint CK_<table_name_prefix, NVARCHAR(50), tbl><table_name, sysname, ThisTable>_<column_name, sysname, ThisColumn>
-----------------------------------------------------------------------------

IF EXISTS (SELECT * FROM sys.check_constraints
            WHERE name                              = N'CK_<table_name_prefix, NVARCHAR(50), tbl><table_name, sysname, ThisTable>_<column_name, sysname, ThisColumn>'
              AND OBJECT_NAME(parent_object_id)     = N'<table_name_prefix, NVARCHAR(50), tbl><table_name, sysname, ThisTable>')
BEGIN
    RAISERROR('Dropping check constraint CK_<table_name_prefix, NVARCHAR(50), tbl><table_name, sysname, ThisTable>_<column_name, sysname, ThisColumn> from table <table_name_prefix, NVARCHAR(50), tbl><table_name, sysname, ThisTable> in database <database_name, sysname, MyDB>', 10, 1) WITH NOWAIT, LOG

    ALTER TABLE <schema_name, sysname, dbo>.<table_name_prefix, NVARCHAR(50), tbl><table_name, sysname, ThisTable>
     DROP CONSTRAINT CK_<table_name_prefix, NVARCHAR(50), tbl><table_name, sysname, ThisTable>_<column_name, sysname, ThisColumn>
END

