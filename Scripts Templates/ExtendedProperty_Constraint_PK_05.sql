    EXEC sp_addextendedproperty 
            @name       = N'MS_Description',
            @value      = N'<extd_prop_pk_constraint_desc, NVARCHAR(MAX), Description...>',
            @level0type = N'SCHEMA',
            @level0name = N'<schema_name, sysname, dbo>',
            @level1type = N'TABLE',
            @level1name = N'<table_name_prefix, sysname, tbl><table_name, sysname, ThisTable>',
            @level2type = N'CONSTRAINT',
            @level2name = N'PK_<table_name, sysname, ThisTable>'
