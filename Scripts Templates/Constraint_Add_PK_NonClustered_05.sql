
RAISERROR(N'Adding PRIMARY KEY constraint PK_<table_name_prefix, NVARCHAR(50), tbl><table_name, sysname, ThisTable>', 10, 1) WITH NOWAIT<with_log, sysname, , LOG >

ALTER TABLE <schema_name, sysname, dbo>.<table_name_prefix, NVARCHAR(50), tbl><table_name, sysname, ThisTable>
  ADD CONSTRAINT PK_<table_name_prefix, NVARCHAR(50), tbl><table_name, sysname, ThisTable> PRIMARY KEY CLUSTERED
        (<columns_in_primary_key, NVARCHAR(MAX), ThisPkColumn, ThatPkColumn> ASC)

