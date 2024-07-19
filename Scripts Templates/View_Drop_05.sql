
IF EXISTS (SELECT * FROM sys.views WHERE name = '<view_name, sysname, ThisView>')
BEGIN
    RAISERROR('Dropping view <view_name, sysname, ThisView>', 10, 1) WITH NOWAIT<with_log, sysname, , LOG >
    DROP VIEW <schema_name, sysname, dbo>.<view_name, sysname, ThisView>
END


