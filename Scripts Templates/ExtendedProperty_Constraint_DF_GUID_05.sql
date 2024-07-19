    EXEC sp_addextendedproperty 
        @name       = N'MS_Description',
        @value      = N'<extd_prop_constraint_default_desc, NVARCHAR(MAX), Unique across the galaxy, as long as network card exists.>',
        @level0type = N'SCHEMA',
        @level0name = N'<schema_name, sysname, dbo>',
        @level1type = N'TABLE',
        @level1name = N'<table_name_prefix, sysname, tbl><table_name, sysname, ThisTable>',
        @level2type = N'CONSTRAINT',
        @level2name = N'DF_<table_name, sysname, ThisTable>_<column_name, sysname, ThisColumn>'
