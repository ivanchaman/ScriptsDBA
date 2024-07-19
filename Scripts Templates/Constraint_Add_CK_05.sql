
IF EXISTS (SELECT * FROM sys.default_constraints
            WHERE name = 'CK_<table_name_prefix, NVARCHAR(50), tbl><table_name, sysname, ThisTable>_<check_constraint_key_name, sysname, _Columns or _Usage>'
              AND OBJECT_NAME(parent_object_id) = '<table_name_prefix, NVARCHAR(50), tbl><table_name, sysname, ThisTable>')
BEGIN
    ALTER TABLE <schema_name, sysname, dbo>.<table_name_prefix, NVARCHAR(50), tbl><table_name, sysname, ThisTable> WITH CHECK 
      ADD CONSTRAINT CK_<table_name_prefix, NVARCHAR(50), tbl><table_name, sysname, ThisTable>_<check_constraint_key_name, sysname, _Columns or _Usage>
      CHECK (<check_constraint_expr, NVARCHAR(MAX), ThisColumn = 0 AND ThatColumn IS NOT NULL>) 
END


 