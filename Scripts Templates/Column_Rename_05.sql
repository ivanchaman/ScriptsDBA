
------------------------------------------------------------------------------ 
-- Rename column.    Use random number for clarity and to guarantee no conflicts. 
------------------------------------------------------------------------------ 

BEGIN TRAN

IF EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID('<table_name_prefix, NVARCHAR(50), tbl><table_name, sysname, ThisTable>')
              AND name = '<column_name_source, sysname, SourceColumn>')
BEGIN
    IF NOT EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID('<table_name_prefix, NVARCHAR(50), tbl><table_name, sysname, ThisTable>')
                      AND name = '<column_name_target, sysname, TargetColumn>')
    BEGIN
        RAISERROR('Renaming column %s to %s in table %s', 10, 1,
                  '<column_name_source, sysname, SourceColumn>',
                  '<column_name_target, sysname, TargetColumn>',
                  '<table_name_prefix, NVARCHAR(50), tbl><table_name, sysname, ThisTable>') WITH NOWAIT<with_log, sysname, , LOG >

        DECLARE @RETURN_6_DIGITS INT
        SET @RETURN_6_DIGITS = 0
        
        DECLARE @sRand NVARCHAR(128)
        SET @sRand = 'TMP_' + CONVERT(NVARCHAR(128), CAST(1000000 * RAND(@@IDLE + @@CPU_BUSY + @@TOTAL_READ) AS INT), @RETURN_6_DIGITS)

        DECLARE @sSchemaTableColumn NVARCHAR(150)
        DECLARE @sColumn            sysname
        
        -- First copy.
        SET @sSchemaTableColumn = '<schema_name, sysname, dbo>.<table_name_prefix, NVARCHAR(50), tbl><table_name, sysname, ThisTable>.<column_name_source, sysname, SourceColumn>'
        SET @sColumn            = @sRand
        
        RAISERROR('Renaming column %s to %s>', 10, 1, @sSchemaTableColumn, @sColumn) WITH NOWAIT<with_log, sysname, , LOG >
        EXECUTE sp_rename @sSchemaTableColumn, @sColumn, 'COLUMN' 

        -- Second copy.
        SET @sSchemaTableColumn = '<schema_name, sysname, dbo>.<table_name_prefix, NVARCHAR(50), tbl><table_name, sysname, ThisTable>.' + @sRand
        SET @sColumn            = '<column_name_target, sysname, TargetColumn>'

        RAISERROR('Renaming column %s to %s>', 10, 1, @sSchemaTableColumn, @sColumn) WITH NOWAIT<with_log, sysname, , LOG >
        EXECUTE sp_rename @sSchemaTableColumn, @sColumn, 'COLUMN' 
    END
END

COMMIT

