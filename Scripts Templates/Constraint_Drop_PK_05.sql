-- Must use ALTER TABLE to remove these - can't use DROP INDEX on constraints.
DECLARE @sConstraintNameToDrop sysname
DECLARE @sSql                  NVARCHAR(4000)

SET @sConstraintNameToDrop = NULL

SELECT TOP 1 @sConstraintNameToDrop = name
  FROM sys.indexes
 WHERE object_id = OBJECT_ID('<schema_name, sysname, dbo>.<table_name_prefix, sysname, tbl><table_name, sysname, ThisTable>')
   AND is_primary_key = 1

IF @sConstraintNameToDrop IS NOT NULL
BEGIN
    RAISERROR('Dropping existing PRIMARY KEY constraint %s on table <table_name_prefix, sysname, tbl><table_name, sysname, ThisTable>', 10, 1, @sConstraintNameToDrop) WITH NOWAIT, LOG
    SET @sSql = 'ALTER TABLE <schema_name, sysname, dbo>.<table_name_prefix, sysname, tbl><table_name, sysname, ThisTable> DROP CONSTRAINT ' + @sConstraintNameToDrop
    EXEC sp_executesql @sSql
END

GO
