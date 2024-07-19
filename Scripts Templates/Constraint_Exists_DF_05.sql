
IF NOT EXISTS (SELECT * FROM sys.default_constraints    dc
                 JOIN sys.columns                       c
                   ON dc.parent_object_id = c.object_id
                  AND dc.parent_column_id = c.column_id
                WHERE dc.parent_object_id = OBJECT_ID('<table_name_prefix, NVARCHAR(50), tbl><table_name, sysname, ThisTable>')
                  AND c.name = '<column_name_constraint_is_on, sysname, ThisColumn>')
BEGIN
    RAISERROR('Default constraint exists on table DF_<table_name_prefix, NVARCHAR(50), tbl><table_name, sysname, ThisTable>, column <column_name_constraint_is_on, sysname, ThisColumn>', 10, 1) WITH NOWAIT<with_log, sysname, , LOG>

END

