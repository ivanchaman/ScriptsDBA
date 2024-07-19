
IF EXISTS (SELECT * FROM sys.procedures
            WHERE name = '<stored_procedure_name, sysname, usp_>')
BEGIN
    RAISERROR ('Dropping stored procedure <stored_procedure_name, sysname, usp_>', 10, 1) WITH NOWAIT, LOG
    DROP PROCEDURE <stored_procedure_name, sysname, usp_>
END

