
----------------------------------------------------------------------------------------
-- There is no INFORMATION_SCHEMA data for indexes, because INFORMATION_SCHEMA is an    
-- ANSI standard, and it deals only with logical things (tables, views, constraints,    
-- etc.) and not physical things (like indexes).                                        
----------------------------------------------------------------------------------------

IF (SELECT INDEXPROPERTY(OBJECT_ID(N'<schema_name, sysname, dbo>.<table_name_prefix, NVARCHAR(50), tbl><table_name, sysname, ThisTable>'), N'IX_<table_name, sysname, ThisTable>', N'IndexId')) IS NOT NULL
BEGIN
    PRINT N'Index exists'
END
