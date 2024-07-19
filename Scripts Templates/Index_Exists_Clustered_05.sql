
IF EXISTS (SELECT * FROM sys.indexes
            WHERE name = 'IX_<table_name_prefix, NVARCHAR(50), tbl><table_name, sysname, ThisTable>_<columns_for_name, NVARCHAR(MAX), ThisColumn_ThatColumn>'
              AND type_desc = 'CLUSTERED')
BEGIN

        Your code here.

END

