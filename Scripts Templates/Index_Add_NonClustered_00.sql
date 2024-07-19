----------------------------------------------------------------------------------------
-- There is no INFORMATION_SCHEMA data for indexes, because INFORMATION_SCHEMA is an    
-- ANSI standard, and it deals only with logical things (tables, views, constraints,    
-- etc.) and not physical things (like indexes).  So, we have to use the 'sysindexes'   
-- table.  The 'sp_addextendedproperty' proc requires 'USE'.                            
----------------------------------------------------------------------------------------

USE <database_name, sysname, MyDB>


----------------------------------------------------------------------------------------
-- Create IX_<table_name, sysname, ThisTable>_<columns_for_name, NVARCHAR(MAX), ThisColumn_ThatColumn>.
----------------------------------------------------------------------------------------

IF (SELECT INDEXPROPERTY(OBJECT_ID(N'<schema_name, sysname, dbo>.<table_name_prefix, sysname, tbl><table_name, sysname, ThisTable>'), N'IX_<table_name, sysname, ThisTable>_<columns_for_name, NVARCHAR(MAX), ThisColumn_ThatColumn>', N'IndexId')) IS NULL
BEGIN
    RAISERROR(N'Creating index IX_<table_name, sysname, ThisTable>_<columns_for_name, NVARCHAR(MAX), ThisColumn_ThatColumn>', 10, 1) WITH NOWAIT<with_log, sysname, , LOG>

    CREATE INDEX IX_<table_name, sysname, ThisTable>_<columns_for_name, NVARCHAR(MAX), ThisColumn_ThatColumn>
        ON <database_name, sysname, ConsolidatedDB>.<schema_name, sysname, dbo>.<table_name_prefix, NVARCHAR(50), tbl><table_name, sysname, ThisTable>
           (<columns_for_index, NVARCHAR(MAX), ThisColumn DESC, ThatColumn DESC, OtherColumn DESC>)
      WITH PAD_INDEX, FILLFACTOR = <fill_factor, sysname, 70>

    SET @nMyErr = @@ERROR, @nRowsAffected = @@ROWCOUNT IF @nMyErr != 0 BEGIN RAISERROR('     *** Failed to create index IX_<table_name, sysname, ThisTable>_<columns_for_name, NVARCHAR(MAX), ThisColumn_ThatColumn> - @@ERROR: %d', 16, 1, @nMyErr) IF 0 < @@TRANCOUNT ROLLBACK RETURN END

    EXEC sp_addextendedproperty
        @name       = N'MS_Description',
        @value      = N'<extd_prop_index_description, NVARCHAR(4000), Enter description...>',
        @level0type = N'USER',
        @level0name = N'<schema_name, sysname, dbo>',
        @level1type = N'TABLE',
        @level1name = N'<table_name_prefix, NVARCHAR(50), tbl><table_name, sysname, ThisTable>',
        @level2type = N'INDEX',
        @level2name = N'IX_<table_name, sysname, ThisTable>_<columns_for_name, NVARCHAR(MAX), ThisColumn_ThatColumn>'

    RAISERROR(N'Created index IX_<table_name, sysname, ThisTable>_<columns_for_name, NVARCHAR(MAX), ThisColumn_ThatColumn>', 10, 1) WITH NOWAIT<with_log, sysname, , LOG>
END
