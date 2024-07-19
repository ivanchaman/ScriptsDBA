
IF EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID('<table_name_prefix, NVARCHAR(50), tbl><table_name, sysname, ThisTable>')
                  AND name = '<column_name, sysname, ThisColumn>')
BEGIN
    RAISERROR('Adding <column_type, sysname, INT> column <column_name, sysname, ThisColumn> to table <table_name_prefix, NVARCHAR(50), tbl><table_name, sysname, ThisTable>', 10, 1) WITH NOWAIT, LOG
    
    ALTER TABLE <schema_name, sysname, dbo>.<table_name_prefix, NVARCHAR(50), tbl><table_name, sysname, ThisTable>
      ADD <column_name, sysname, ThisColumn> <column_type, sysname, 'INT'> <nullability, NVARCHAR(16), NOT NULL>
END


            Extended property?
