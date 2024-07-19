-- Uses the new syntax.  BOL 2008: "The following SQL Server Database Engine 
-- features are supported in the next version of SQL Server, but will be 
-- removed in a later version. The specific version of SQL Server has not 
-- been determined."


            Add DROP INDEX call?


    -----------------------------------------------------------------------------
    -- Create included index <index_prefix, sysname, IX UQ>_<table_name, sysname, ThisTable>_<columns_for_name, NVARCHAR(MAX), ThisColumn_ThatColumn_plus_IncludedColumn>.
    -----------------------------------------------------------------------------

    IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = '<index_prefix, sysname, IX UQ>_<table_name, sysname, ThisTable>_<columns_for_name, NVARCHAR(MAX), ThisColumn_ThatColumn>' AND type_desc = 'NONCLUSTERED')
    BEGIN
        RAISERROR('Creating the index <schema_name, sysname, dbo>.<index_prefix, sysname, IX UQ>_<table_name, sysname, ThisTable>_<columns_for_name, NVARCHAR(MAX), ThisColumn_ThatColumn>', 10, 1) WITH NOWAIT, LOG
        
        CREATE <del_if_not_unique, NVARCHAR(50), UNIQUE> NONCLUSTERED INDEX <index_prefix, sysname, IX UQ>_<table_name, sysname, ThisTable>_<columns_for_name, NVARCHAR(MAX), ThisColumn_ThatColumn>
            ON <schema_name, sysname, dbo>.<table_name_pref, NVARCHAR(50), tbl><table_name, sysname, ThisTable> (<columns_for_index, NVARCHAR(MAX), ThisColumn DESC, ThatColumn DESC, OtherColumn DESC>) 
       INCLUDE (<columns_for_include, NVARCHAR(MAX), ThisColumn, ThatColumn>)
          WITH (PAD_INDEX = ON, FILLFACTOR = <fill_factor, INT, 70>, SORT_IN_TEMPDB = ON<ext_edition_only, NVARCHAR(50), , ONLINE = ON>)
    END



                Add extended property for index.
