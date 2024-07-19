
IF EXISTS (SELECT *
             FROM sys.foreign_keys
            WHERE referenced_object_id = OBJECT_ID('<table_name_prefix, NVARCHAR(50), tbl><table_name, sysname, ThisTable>')
              AND schema_id = SCHEMA_ID('<schema_name, sysname, dbo>')
              AND type_desc = 'FOREIGN_KEY_CONSTRAINT')
BEGIN
    RAISERROR('Table <schema_name, sysname, dbo>.<table_name_prefix, NVARCHAR(50), tbl><table_name, sysname, ThisTable> is depended upon by foreign key constraint(s)', 10, 1) WITH NOWAIT <with_log, sysname, , LOG>


END
