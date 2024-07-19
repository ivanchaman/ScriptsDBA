
IF EXISTS (SELECT * FROM sys.triggers WHERE name = '<triggerddl_name, sysname, TRDDL_event>')
BEGIN
    RAISERROR('Dropping DDL trigger <triggerddl_name, sysname, TRDDL_event>...', 10, 1) WITH NOWAIT, LOG
    DROP TRIGGER <triggerddl_name, sysname, TRDDL_event> ON DATABASE
    RAISERROR('Dropped  DDL trigger <triggerddl_name, sysname, TRDDL_event>...', 10, 1) WITH NOWAIT, LOG
END
GO

RAISERROR('Creating DDL trigger <triggerddl_name, sysname, TRDDL_event>...', 10, 1) WITH NOWAIT, LOG
GO

CREATE TRIGGER <triggerddl_name, sysname, TRDDL_event>
    ON DATABASE FOR DROP_TABLE AS
BEGIN
    SET NOCOUNT ON
    
    DECLARE @sObjectName sysname
    SELECT  @sObjectName = EVENTDATA().value('(/EVENT_INSTANCE/ObjectName', 'sysname')
    DECLARE @sObjectType sysname
    SELECT  @sObjectType = EVENTDATA().value('(/EVENT_INSTANCE/ObjectType', 'sysname')

    IF @sObjectName NOT IN ('<table_name_prefix, NVARCHAR(50), tbl><table_name, sysname, ThisTable>')  RETURN

   RAISERROR ('You must disable the DDL trigger "<triggerddl_name, sysname, TRDDL_event>" ' +
              'to DROP the "' + @sObjectName + '" ' + @sObjectType + '".', 16, 1) WITH NOWAIT, LOG
   ROLLBACK
END
GO
