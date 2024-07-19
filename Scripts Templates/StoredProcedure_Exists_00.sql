
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.ROUTINES 
            WHERE SPECIFIC_SCHEMA = N'<schema_name, sysname, dbo>'
              AND SPECIFIC_NAME   = N'<stored_procedure_name, sysname, fmsp_>')
BEGIN

END
