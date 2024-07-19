IF EXISTS (SELECT * FROM master.INFORMATION_SCHEMA.SCHEMATA 
                WHERE CATALOG_NAME = N'<database_name, sysname, >')
BEGIN

    SET @nMyErr = @@ERROR, @nRowsAffected = @@ROWCOUNT IF @nMyErr != 0 BEGIN RAISERROR('     <Failure Message, NVARCHAR, *** Failed to ...> - @@ERROR: %d', 16, 1, @nMyErr) IF 0 < @@TRANCOUNT ROLLBACK RETURN END
END
