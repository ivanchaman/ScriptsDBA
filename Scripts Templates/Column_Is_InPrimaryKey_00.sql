
-- Is this column on this table in the Primary Key for this table?
IF EXISTS (SELECT *
             FROM <database_name, sysname, MyDB>.INFORMATION_SCHEMA.KEY_COLUMN_USAGE  AS tKey
             JOIN <database_name, sysname, MyDB>.INFORMATION_SCHEMA.TABLE_CONSTRAINTS AS tConst
               ON tKey.CONSTRAINT_NAME   = tConst.CONSTRAINT_NAME
            WHERE tKey.TABLE_NAME        = N'<table_name_prefix, sysname, tbl><table_name, sysname, ThisTable>'
              AND tKey.COLUMN_NAME       = N'<column_name, sysname, >'
              AND tConst.CONSTRAINT_TYPE = N'PRIMARY KEY')
BEGIN

END
