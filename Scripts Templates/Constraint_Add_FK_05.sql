
-----------------------------------------------------------------------------
-- Create FK on <table_name_prefix, NVARCHAR(50), tbl><table_name, sysname, ThisTable> for <table_name_prefix, NVARCHAR(50), tbl><other_table_name, sysname, OtherTable>.
-----------------------------------------------------------------------------

-- Drop the foreign key constraint if it already exists.
IF EXISTS (SELECT * FROM sys.foreign_keys
            WHERE name                              = N'FK_<table_name_prefix, NVARCHAR(50), tbl><table_name, sysname, ThisTable>_<table_name_prefix, NVARCHAR(50), tbl><other_table_name, sysname, OtherTable>'
              AND OBJECT_NAME(parent_object_id)     = N'<table_name_prefix, NVARCHAR(50), tbl><table_name, sysname, ThisTable>'
              AND OBJECT_NAME(referenced_object_id) = N'<table_name_prefix, NVARCHAR(50), tbl><other_table_name, sysname, OtherTable>')
BEGIN
    RAISERROR('Dropping foreign key FK_<table_name_prefix, NVARCHAR(50), tbl><table_name, sysname, ThisTable>_<table_name_prefix, NVARCHAR(50), tbl><other_table_name, sysname, OtherTable> from table <table_name_prefix, NVARCHAR(50), tbl><table_name, sysname, ThisTable> in database <database_name, sysname, MyDB>', 10, 1) WITH NOWAIT, LOG

    ALTER TABLE <schema_name, sysname, dbo>.<table_name_prefix, NVARCHAR(50), tbl><table_name, sysname, ThisTable>
     DROP CONSTRAINT FK_<table_name_prefix, NVARCHAR(50), tbl><table_name, sysname, ThisTable>_<table_name_prefix, NVARCHAR(50), tbl><other_table_name, sysname, OtherTable>
END

-- Create the foreign key constraint unless it somehow still exists.
IF NOT EXISTS (SELECT * FROM sys.foreign_keys
                WHERE name                              = N'FK_<table_name_prefix, NVARCHAR(50), tbl><table_name, sysname, ThisTable>_<table_name_prefix, NVARCHAR(50), tbl><other_table_name, sysname, OtherTable>'
                  AND OBJECT_NAME(parent_object_id)     = N'<table_name_prefix, NVARCHAR(50), tbl><table_name, sysname, ThisTable>'
                  AND OBJECT_NAME(referenced_object_id) = N'<table_name_prefix, NVARCHAR(50), tbl><other_table_name, sysname, OtherTable>')
BEGIN
    RAISERROR('Creating foreign key FK_<table_name_prefix, NVARCHAR(50), tbl><table_name, sysname, ThisTable>_<table_name_prefix, NVARCHAR(50), tbl><other_table_name, sysname, OtherTable> from table <table_name_prefix, NVARCHAR(50), tbl><table_name, sysname, ThisTable> in database <database_name, sysname, MyDB>', 10, 1) WITH NOWAIT, LOG

    ALTER TABLE <schema_name, sysname, dbo>.<table_name_prefix, NVARCHAR(50), tbl><table_name, sysname, ThisTable>
      ADD CONSTRAINT FK_<table_name_prefix, NVARCHAR(50), tbl><table_name, sysname, ThisTable>_<table_name_prefix, NVARCHAR(50), tbl><other_table_name, sysname, OtherTable>
      FOREIGN KEY (<column_name, sysname, ThisColumn>)
      REFERENCES <schema_name, sysname, dbo>.<table_name_prefix, NVARCHAR(50), tbl><other_table_name, sysname, OtherTable> (<other_column_name, sysname, OtherColumn>)
END

            Add extended property for foreign key?
