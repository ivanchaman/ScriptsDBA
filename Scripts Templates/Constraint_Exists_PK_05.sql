
-- Does a Primary Key exist on this table?
IF EXISTS (SELECT * FROM sys.key_constraints WHERE type = 'PK'
              AND parent_object_id = OBJECT_ID('<table_name_prefix, NVARCHAR(50), tbl><table_name, sysname, ThisTable>'))
BEGIN

    -- Your code here.
    
END

