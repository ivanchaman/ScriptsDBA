
IF EXISTS (SELECT * FROM sys.columns  c
             JOIN sys.types           t
               ON c.system_type_id = t.system_type_id
            WHERE OBJECT_NAME(c.object_id) = '<table_name, sysname, ThisTable>'
              AND c.name = '<column_name, sysname, >'
              AND t.name <> '<column_type_new, sysname, ''INT''>')
BEGIN
    RAISERROR(N'In table <table_name_prefix, NVARCHAR(50), tbl><table_name, sysname, ThisTable>, changing column <column_name, sysname, >''s type to <column_type_new, sysname, ''INT''>', 10, 1) WITH NOWAIT<with_log, sysname, , LOG>

    ALTER TABLE <schema_name, sysname, dbo>.<table_name_prefix, sysname, tbl><table_name, sysname, ThisTable>
        ALTER COLUMN <column_name, sysname, > <column_type_new, sysname, 'INT'>
END

