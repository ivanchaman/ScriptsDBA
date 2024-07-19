
IF OBJECT_ID('<schema_name, sysname, dbo>.<view_name, sysname, vw_>', 'V') IS NOT NULL
BEGIN
    RAISERROR('Dropping view <view_name, sysname, VW_>...', 10, 1) WITH NOWAIT, LOG
    DROP VIEW <schema_name, sysname, dbo>.<view_name, sysname, VW_>
    RAISERROR('Dropped  view <view_name, sysname, VW_>...', 10, 1) WITH NOWAIT, LOG
END

RAISERROR('Creating view <view_name, sysname, VW_>...', 10, 1) WITH NOWAIT, LOG
GO

CREATE VIEW <schema_name, sysname, dbo>.<view_name, sysname, VW_>
AS
    SELECT <column_name, sysname, ThisColumn>
      FROM <table_name_prefix, NVARCHAR(50), tbl><table_name, sysname, ThisTable>
GO

RAISERROR('Created  view <view_name, sysname, VW_>...', 10, 1) WITH NOWAIT, LOG


                Add extended property?