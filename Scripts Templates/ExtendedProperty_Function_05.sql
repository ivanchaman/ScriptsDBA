-----------------------------------------------------------------------------
-- If function exists, and extended property doesn't already exist, add the  
-- extended property. 
-----------------------------------------------------------------------------

IF OBJECT_ID('<schema_name, sysname, dbo>.<function_name, sysname, Function Name (No Prefix)>') IS NOT NULL
   AND NOT EXISTS (SELECT * FROM <database_name, sysname, MyDB>.sys.extended_properties
                    WHERE class_desc = 'FUNCTION'
                      AND major_id   = OBJECT_ID('<function_name, sysname, Function Name (No Prefix)>'))
BEGIN
    EXEC sp_addextendedproperty
        @name       = N'MS_Description',
        @value      = N'<extd_prop_function_desc, NVARCHAR(MAX), Description...>',
        @level0type = N'USER',
        @level0name = N'<schema_name, sysname, dbo>',
        @level1type = N'FUNCTION',
        @level1name = N'<function_name, sysname, Function Name (No Prefix)>'
END


                    Add extended property for function?

