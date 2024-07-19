
-----------------------------------------------------------------------------
-- Drop FK constraint on <table_name_prefix, NVARCHAR(50), tbl><table_name, sysname, ThisTable> for <table_name_prefix, NVARCHAR(50), tbl><other_table_name, sysname, OtherTable>.
-----------------------------------------------------------------------------

IF EXISTS (SELECT * FROM sys.foreign_keys
            WHERE name                              = N'FK_<table_name_prefix, NVARCHAR(50), tbl><table_name, sysname, ThisTable>_<table_name_prefix, NVARCHAR(50), tbl><other_table_name, sysname, OtherTable>'
              AND OBJECT_NAME(parent_object_id)     = N'<table_name_prefix, NVARCHAR(50), tbl><table_name, sysname, ThisTable>'
              AND OBJECT_NAME(referenced_object_id) = N'<table_name_prefix, NVARCHAR(50), tbl><other_table_name, sysname, OtherTable>')
BEGIN
    RAISERROR('Dropping foreign key FK_<table_name_prefix, NVARCHAR(50), tbl><table_name, sysname, ThisTable>_<table_name_prefix, NVARCHAR(50), tbl><other_table_name, sysname, OtherTable> from table <table_name_prefix, NVARCHAR(50), tbl><table_name, sysname, ThisTable> in database <database_name, sysname, MyDB>', 10, 1) WITH NOWAIT, LOG

    ALTER TABLE <schema_name, sysname, dbo>.<table_name_prefix, NVARCHAR(50), tbl><table_name, sysname, ThisTable>
     DROP CONSTRAINT FK_<table_name_prefix, NVARCHAR(50), tbl><table_name, sysname, ThisTable>_<table_name_prefix, NVARCHAR(50), tbl><other_table_name, sysname, OtherTable>
END
