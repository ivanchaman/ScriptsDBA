EXEC sp_addextendedproperty
    @name       = N'MS_Description',
    @value      = N'<extd_prop_table_desc, NVARCHAR(MAX), Description...>',
    @level0type = N'SCHEMA',
    @level0name = N'<schema_name, sysname, dbo>',
    @level1type = N'TABLE',
    @level1name = N'<table_name_prefix, NVARCHAR(50), tbl><table_name, sysname, ThisTable>'
