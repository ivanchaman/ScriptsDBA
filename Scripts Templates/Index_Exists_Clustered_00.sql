
----------------------------------------------------------------------------------------
-- There is no INFORMATION_SCHEMA data for indexes, because INFORMATION_SCHEMA is an    
-- ANSI standard, and it deals only with logical things (tables, views, constraints,    
-- etc.) and not physical things (like indexes).                                        
----------------------------------------------------------------------------------------

IF (SELECT INDEXPROPERTY(OBJECT_ID('<schema_name, sysname, dbo>.<table_name_prefix, sysname, tbl><table_name, sysname, ThisTable>'), '<index_name, sysname, IX_>', 'IsClustered')) IS NOT NULL
BEGIN
    RAISERROR('Clustered index ''<index_name, sysname, IX_>'' found.', 10, 1) WITH NOWAIT<with_log, sysname, , LOG>
END
