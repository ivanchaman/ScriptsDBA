-- Add comments to metadata.
EXEC sp_addextendedproperty
    @name       = N'MS_Description',
    @value      = N'<extd_prop_procedure_desc, NVARCHAR(MAX), Description...>',
    @level0type = N'SCHEMA',
    @level0name = N'<schema_name, sysname, dbo>',
    @level1type = N'PROCEDURE',
    @level1name = N'<stored_procedure_name, sysname, usp_>'
