IF EXISTS (SELECT * FROM <database_name, sysname, MyDB>.INFORMATION_SCHEMA.COLUMNS
            WHERE TABLE_NAME  = N'<table_name_prefix, sysname, tbl><table_name, sysname, ThisTable>'
              AND COLUMN_NAME = N'<column_name, sysname, >'
              AND DATA_TYPE   = N'<data_type, sysname, INT>')
BEGIN
    ALTER TABLE <database_name, sysname, MyDB>.<table_name_prefix, sysname, tbl><table_name, sysname, ThisTable>
      ADD <column_name, sysname, > <data_type, sysname, INT> NOT NULL

    SET @nMyErr = @@ERROR, @nRowsAffected = @@ROWCOUNT IF @nMyErr != 0 BEGIN RAISERROR('     <Failure Message, NVARCHAR, *** Failed to ...> - @@ERROR: %d', 16, 1, @nMyErr) IF 0 < @@TRANCOUNT ROLLBACK RETURN END
END

