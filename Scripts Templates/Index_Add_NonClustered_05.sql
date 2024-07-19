
-- Uses the new syntax.  BOL 2008: "The following SQL Server Database Engine 
-- features are supported in the next version of SQL Server, but will be 
-- removed in a later version. The specific version of SQL Server has not 
-- been determined."


Add DROP INDEX call.


-----------------------------------------------------------------------------
-- Create index IX_<table_name, sysname, ThisTable>_<columns_for_name, NVARCHAR(MAX), ThisColumn_ThatColumn>.
-----------------------------------------------------------------------------

IF NOT EXISTS (SELECT * FROM sys.indexes
                     WHERE name = 'IX_<table_name_prefix, NVARCHAR(50), tbl><table_name, sysname, ThisTable>_<columns_for_name, NVARCHAR(MAX), ThisColumn_ThatColumn>' AND type_desc = 'NONCLUSTERED')
BEGIN
    RAISERROR('Creating the index <schema_name, sysname, dbo>.IX_<table_name_prefix, NVARCHAR(50), tbl><table_name, sysname, ThisTable>_<columns_for_name, NVARCHAR(MAX), ThisColumn_ThatColumn> ', 10, 1) WITH NOWAIT, LOG
    
    CREATE <del_if_not_unique, NVARCHAR(50), UNIQUE> NONCLUSTERED INDEX IX_<table_name_prefix, NVARCHAR(50), tbl><table_name, sysname, ThisTable>_<columns_for_name, NVARCHAR(MAX), ThisColumn_ThatColumn>
        ON <schema_name, sysname, dbo>.<table_name_prefix, NVARCHAR(50), tbl><table_name, sysname, ThisTable> (<columns_for_index, NVARCHAR(MAX), ThisColumn DESC, ThatColumn DESC, OtherColumn DESC>) 
      WITH (PAD_INDEX = ON, FILLFACTOR = <fill_factor, INT, 70>, SORT_IN_TEMPDB = ON, <ext_edition_only_createindex, NVARCHAR(50), ONLINE = ON>)
END


Add extended property for index.
