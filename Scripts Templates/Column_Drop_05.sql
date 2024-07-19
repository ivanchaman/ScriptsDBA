
IF EXISTS (SELECT * FROM sys.columns WHERE name = '<column_name, sysname, ThisColumn>'
              AND object_id = OBJECT_ID('<table_name_prefix, NVARCHAR(50), tbl><table_name, sysname, ThisTable>'))
BEGIN
    RAISERROR('Dropping column <column_name, sysname, ThisColumn> from table <table_name_prefix, NVARCHAR(50), tbl><table_name, sysname, ThisTable>', 10, 1) WITH NOWAIT<with_log, sysname, , LOG>
    
    ALTER TABLE <schema_name, sysname, dbo>.<table_name_prefix, NVARCHAR(50), tbl><table_name, sysname, ThisTable>
        DROP COLUMN <column_name, sysname, ThisColumn> 
END

