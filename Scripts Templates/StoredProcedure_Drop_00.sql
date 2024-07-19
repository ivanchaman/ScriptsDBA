
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.ROUTINES 
            WHERE SPECIFIC_SCHEMA = N'<schema_name, sysname, dbo>'
              AND SPECIFIC_NAME   = N'<stored_procedure_name, sysname, usp_>')
BEGIN
    RAISERROR(N'Dropping the <stored_procedure_name, sysname, usp_> stored procedure from the <database_name, sysname, MyDB> database', 10, 1) WITH NOWAIT, LOG
    DROP PROCEDURE <schema_name, sysname, dbo>.<stored_procedure_name, sysname, usp_>
    SET @nMyErr = @@ERROR, @nRowsAffected = @@ROWCOUNT IF @nMyErr != 0 BEGIN RAISERROR('     <Failure Message, NVARCHAR, *** Failed to ...> - @@ERROR: %d', 16, 1, @nMyErr) IF 0 < @@TRANCOUNT ROLLBACK RETURN END
END
