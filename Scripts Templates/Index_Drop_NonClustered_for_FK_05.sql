
    Must drop FK constraint first!

    -----------------------------------------------------------------------------
    -- Drop FK-supporting index IX_<table_name, sysname, ThisTable>_<columns_for_name, NVARCHAR(MAX), ThisColumn_ThatColumn>.
    -----------------------------------------------------------------------------

    IF EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_<table_name, sysname, ThisTable>_<columns_for_name, NVARCHAR(MAX), ThisColumn_ThatColumn>' AND type_desc = 'NONCLUSTERED')
    BEGIN
        RAISERROR('Dropping the FK-supporting index IX_<table_name, sysname, ThisTable>_<columns_for_name, NVARCHAR(MAX), ThisColumn_ThatColumn> on table <schema_name, sysname, dbo>.<table_name_prefix, NVARCHAR(50), tbl><table_name, sysname, ThisTable>', 10, 1) WITH NOWAIT, LOG

        DROP INDEX IX_<table_name, sysname, ThisTable>_<columns_for_name, NVARCHAR(MAX), ThisColumn_ThatColumn>
                ON <schema_name, sysname, dbo>.<table_name_prefix, NVARCHAR(50), tbl><table_name, sysname, ThisTable>
                   <ext_edition_only_dropindex, NVARCHAR(50), WITH (ONLINE = ON)>
    END
