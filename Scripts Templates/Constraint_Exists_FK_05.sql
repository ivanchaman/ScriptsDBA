
IF EXISTS (SELECT * FROM sys.foreign_keys
            WHERE name = 'FK_<table_name_prefix, NVARCHAR(50), tbl><table_name, sysname, ThisTable>_<table_name_prefix, NVARCHAR(50), tbl><other_table_name, sysname, OtherTable>'
              AND parent_object_id = OBJECT_ID('<table_name_prefix, NVARCHAR(50), tbl><table_name, sysname, ThisTable>'))
BEGIN

END


