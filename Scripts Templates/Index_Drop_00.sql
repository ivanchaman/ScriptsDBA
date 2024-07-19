IF (SELECT INDEXPROPERTY(OBJECT_ID(N'<schema_name, sysname, dbo>.<table_name_prefix, sysname, tbl><table_name, sysname, ThisTable>'), N'IX_<table_name, sysname, ThisTable>_<columns_for_name, NVARCHAR(MAX), ThisColumn_ThatColumn>', N'IndexId')) IS NOT NULL
BEGIN
    RAISERROR(N'Dropping the IX_<table_name, sysname, ThisTable>_<columns_for_name, NVARCHAR(MAX), ThisColumn_ThatColumn> index from the <table_name_prefix, sysname, tbl><table_name, sysname, ThisTable> table', 10, 1) WITH NOWAIT
    DROP INDEX <schema_name, sysname, dbo>.<table_name_prefix, sysname, tbl><table_name, sysname, ThisTable>.IX_<table_name, sysname, ThisTable>_<columns_for_name, NVARCHAR(MAX), ThisColumn_ThatColumn>
    SET @nMyErr = @@ERROR, @nRowsAffected = @@ROWCOUNT IF @nMyErr != 0 BEGIN RAISERROR('     *** Failed to drop index IX_<table_name, sysname, ThisTable>_<columns_for_name, NVARCHAR(MAX), ThisColumn_ThatColumn> - @@ERROR: %d', 16, 1, @nMyErr) IF 0 < @@TRANCOUNT ROLLBACK RETURN END
    RAISERROR(N'Dropped the IX_<table_name, sysname, ThisTable>_<columns_for_name, NVARCHAR(MAX), ThisColumn_ThatColumn> index from the <table_name_prefix, sysname, tbl><table_name, sysname, ThisTable> table', 10, 1) WITH NOWAIT
END
