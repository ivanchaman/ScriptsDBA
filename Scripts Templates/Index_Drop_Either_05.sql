
-----------------------------------------------------------------------------
-- Drop index IX_<table_name, sysname, ThisTable>_<columns_for_name, NVARCHAR(MAX), ThisColumn_ThatColumn>.
-----------------------------------------------------------------------------

IF EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_<table_name, sysname, ThisTable>_<columns_for_name, NVARCHAR(MAX), ThisColumn_ThatColumn>')
BEGIN
    RAISERROR('Dropping the index IX_<table_name, sysname, ThisTable>_<columns_for_name, NVARCHAR(MAX), ThisColumn_ThatColumn> on table <schema_name, sysname, dbo>.<table_name_prefix, NVARCHAR(50), tbl><table_name, sysname, ThisTable>', 10, 1) WITH NOWAIT, LOG

    DROP INDEX IX_<table_name, sysname, ThisTable>_<columns_for_name, NVARCHAR(MAX), ThisColumn_ThatColumn>
      ON <schema_name, sysname, dbo>.<table_name_prefix, NVARCHAR(50), tbl><table_name, sysname, ThisTable>
         <ext_edition_only, NVARCHAR(50), WITH (ONLINE = ON)>

END

