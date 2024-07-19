    EXEC sys.sp_addextendedproperty 
        @name       = N'MS_Description', 
        @value      = N'<extd_prop_column_desc, NVARCHAR(MAX), GUID that is unique across the galaxy used for ...>',
        @level0type = N'SCHEMA', 
        @level0name = N'<schema_name, sysname, dbo>', 
        @level1type = N'TABLE', 
        @level1name = N'<table_name_prefix, NVARCHAR(50), tbl><table_name, sysname, ThisTable>', 
        @level2type = N'COLUMN', 
        @level2name = N'<column_name, sysname, ThisColumn>'
