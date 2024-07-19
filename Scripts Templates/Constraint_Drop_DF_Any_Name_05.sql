
DECLARE @sDefaultConstraintName sysname

SELECT @sDefaultConstraintName = dc.name
  FROM sys.default_constraints            dc
  JOIN sys.columns                        c
    ON dc.parent_object_id = c.object_id
   AND dc.parent_column_id = c.column_id
 WHERE dc.parent_object_id = OBJECT_ID('<table_name_prefix, NVARCHAR(50), tbl><table_name, sysname, ThisTable>')
   AND c.name = '<column_name_constraint_is_on, sysname, ThisColumn>')

IF @sDefaultConstraintName IS NOT NULL              
BEGIN
    RAISERROR('Dropping default constraint %s', 10, 1, @sDefaultConstraintName) WITH NOWAIT<with_log, sysname, , LOG>

    DECLARE @sSql NVARCHAR(4000)
    
    SET @sSql = ''
        + 'ALTER TABLE <schema_name, sysname, dbo>.<table_name_prefix, NVARCHAR(50), tbl><table_name, sysname, ThisTable> '
        + '    DROP CONSTRAINT ' + @sDefaultConstraintName

    EXEC sp_executesql @sSql
END

