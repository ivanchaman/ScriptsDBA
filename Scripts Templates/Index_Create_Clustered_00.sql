----------------------------------------------------------------------------------------
-- There is no INFORMATION_SCHEMA data for indexes, because INFORMATION_SCHEMA is an    
-- ANSI standard, and it deals only with logical things (tables, views, constraints,    
-- etc.) and not physical things (like indexes).  So, we have to use the 'sysindexes'   
-- table.  The 'sp_addextendedproperty' proc requires 'USE'.                            
----------------------------------------------------------------------------------------

USE <database_name, sysname, ConsolidatedDB>

----------------------------------------------------------------------------------------
-- Add clustered index IX_<table_name, sysname, ThisTable>_<column_names, sysname, Col1_Col2>.
----------------------------------------------------------------------------------------

IF (SELECT INDEXPROPERTY(OBJECT_ID(N'<schema_name, sysname, dbo>.<table_name_prefix, sysname, tbl><table_name, sysname, ThisTable>'), N'IX_<table_name, sysname, ThisTable>_<column_names, sysname, Col1_Col2>', N'IndexId')) IS NULL
BEGIN
    RAISERROR(N'Creating clustered index IX_<table_name, sysname, ThisTable>_<column_names, sysname, Col1_Col2>', 10, 1) WITH NOWAIT, LOG

    CREATE CLUSTERED INDEX IX_<table_name, sysname, ThisTable>_<column_names, sysname, Col1_Col2>
        ON <database_name, sysname, MyDB>.<schema_name, sysname, dbo>.<table_name_prefix, sysname, tbl><table_name, sysname, ThisTable>
           (<column_names, sysname, Col1_Col2>)
      WITH PAD_INDEX, FILLFACTOR = <fill_factor, sysname, 70>

    SET @nMyErr = @@ERROR, @nRowsAffected = @@ROWCOUNT IF @nMyErr != 0 BEGIN RAISERROR('     <failure message, NVARCHAR, *** Failed to create clustered index> - @@ERROR: %d', 16, 1, @nMyErr) IF 0 < @@TRANCOUNT ROLLBACK RETURN END

    RAISERROR(N'Created clustered index IX_<table_name, sysname, ThisTable>_<column_names, sysname, Col1_Col2>', 10, 1) WITH NOWAIT, LOG

    -- Add documention for an index.  Visible in all Microsoft database tools.
    EXEC sp_addextendedproperty
        @name       = N'MS_Description',
        @value      = N'<extd_prop_index_description, NVARCHAR(4000), Describe it here...>',
        @level0type = N'USER',
        @level0name = N'<schema_name, sysname, dbo>',
        @level1type = N'TABLE',
        @level1name = N'<table_name_prefix, sysname, tbl><table_name, sysname, ThisTable>',
        @level2type = N'INDEX',
        @level2name = N'IX_<table_name, sysname, ThisTable>_<column_names, sysname, Col1_Col2>'
END
