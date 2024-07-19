-- If index exists, and extended property doesn't already exist, add extended property.
IF      EXISTS (SELECT * FROM <database_name, sysname, MyDB>.sys.indexes
                 WHERE name                 = 'UQ_<table_name, sysname, ThisTable>_<columns_for_name, NVARCHAR(MAX), ThisColumn_ThatColumn>'
                   AND type_desc            = 'NONCLUSTERED'
                   AND is_unique_constraint = 1)
AND NOT EXISTS (SELECT * FROM <database_name, sysname, MyDB>.sys.extended_properties
                 WHERE class_desc           = 'INDEX'
                   AND major_id             = OBJECT_ID('UQ_<table_name, sysname, ThisTable>_<columns_for_name, NVARCHAR(MAX), ThisColumn_ThatColumn>'))
BEGIN

    EXEC sp_addextendedproperty
        @name       = N'MS_Description',
        @value      = N'<extd_prop_index_desc, NVARCHAR(MAX), Implements unique constraint.  Used for...>',
        @level0type = N'SCHEMA',
        @level0name = N'<schema_name, sysname, dbo>',
        @level1type = N'TABLE',
        @level1name = N'<table_name_prefix, sysname, tbl><table_name, sysname, ThisTable>',
        @level2type = N'INDEX',
        @level2name = N'UQ_<table_name, sysname, ThisTable>_<columns_for_name, NVARCHAR(MAX), ThisColumn_ThatColumn>'
END
