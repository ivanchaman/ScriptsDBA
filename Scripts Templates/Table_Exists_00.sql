
IF EXISTS (SELECT * FROM <database_name, sysname, MyDB>.INFORMATION_SCHEMA.TABLES
            WHERE TABLE_NAME = N'<table_name_prefix, sysname, tbl><table_name, sysname, ThisTable>')
BEGIN


    SET @nMyErr = @@ERROR, @nRowsAffected = @@ROWCOUNT IF @nMyErr != 0 BEGIN RAISERROR('     <Failure Message, NVARCHAR, *** Failed to ...> - @@ERROR: %d', 16, 1, @nMyErr) IF 0 < @@TRANCOUNT ROLLBACK RETURN END
END

