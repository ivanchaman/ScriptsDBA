IF NOT EXISTS (SELECT * FROM <database_name, sysname, MyDB>.INFORMATION_SCHEMA.TABLES
                WHERE TABLE_NAME = N'<table_name_prefix, sysname, tbl><table_name, sysname, TransactionAlias>')
BEGIN
    RAISERROR (N'Creating table <table_name_prefix, sysname, tbl><table_name, sysname, TransactionAlias> in database <database_name, sysname, MyDB>', 10, 1) WITH NOWAIT, LOG

    CREATE TABLE <database_name, sysname, MyDB>.<schema_name, sysname, dbo>.<table_name_prefix, sysname, tbl><table_name, sysname, TransactionAlias>
    (
        <table_name, sysname, TransactionAlias>Index   INT IDENTITY (1, 1)    NOT NULL
            CONSTRAINT PK_<table_name, sysname, TransactionAlias> PRIMARY KEY CLUSTERED (<table_name, sysname, TransactionAlias>Index) WITH FILLFACTOR = 70
    )

    SET @nMyErr = @@ERROR, @nRowsAffected = @@ROWCOUNT IF @nMyErr != 0 BEGIN RAISERROR('     <Failure Message, NVARCHAR, *** Failed to ...> - @@ERROR: %d', 16, 1, @nMyErr) IF 0 < @@TRANCOUNT ROLLBACK RETURN END

    EXEC sp_addextendedproperty 
        @name       = N'MS_Description',
        @value      = N'<table_description_value,,>',
        @level0type = N'SCHEMA',
        @level0name = N'<schema_name, sysname, dbo>',
        @level1type = N'TABLE',
        @level1name = N'<table_name_prefix, sysname, tbl><table_name, sysname, TransactionAlias>'
END
