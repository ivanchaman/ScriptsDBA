
IF EXISTS (SELECT * FROM sys.foreign_keys
            WHERE OBJECT_NAME(name)                 = N'FK_<table_name, sysname, ThisTable>_<other_table_name, sysname, OtherTable>'
              AND OBJECT_NAME(parent_object_id)     = N'<table_name, sysname, ThisTable>'
              AND OBJECT_NAME(referenced_object_id) = N'<other_table_name, sysname, OtherTable>')
BEGIN

END
