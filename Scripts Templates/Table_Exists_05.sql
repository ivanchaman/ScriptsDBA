
IF EXISTS (SELECT * FROM <database_name, sysname, MyDB>.sys.tables
            WHERE name = '<table_name_prefix, NVARCHAR(50), tbl><table_name, sysname, ThisTable>')
BEGIN
    
                    Your code here.

END
