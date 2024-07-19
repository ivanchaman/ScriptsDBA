
IF EXISTS (SELECT * FROM sys.default_constraints
            WHERE name = 'DF_<table_name_prefix, NVARCHAR(50), tbl><table_name, sysname, ThisTable>_<column_name_constraint_is_on, sysname, ThisColumn>'
              AND parent_object_id = OBJECT_ID('<table_name_prefix, NVARCHAR(50), tbl><table_name, sysname, ThisTable>'))
BEGIN
    RAISERROR('Dropping default constraint DF_<table_name_prefix, NVARCHAR(50), tbl><table_name, sysname, ThisTable>_<column_name_constraint_is_on, sysname, ThisColumn> on table <table_name_prefix, NVARCHAR(50), tbl><table_name, sysname, ThisTable>', 10, 1) WITH NOWAIT<with_log, sysname, , LOG >
    
    ALTER TABLE <schema_name, sysname, dbo>.<table_name_prefix, NVARCHAR(50), tbl><table_name, sysname, ThisTable>
     DROP CONSTRAINT DF_<table_name_prefix, NVARCHAR(50), tbl><table_name, sysname, ThisTable>_<column_name_constraint_is_on, sysname, ThisColumn>
END

