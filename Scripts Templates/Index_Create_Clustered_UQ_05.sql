
CREATE UNIQUE CLUSTERED INDEX IX_<table_name, sysname, ThisTable>_<columns_for_name, NVARCHAR(MAX), ThisColumn_ThatColumn>
    ON <database_name, sysname, MyDB>.<schema_name, sysname, dbo>.<table_name_prefix, NVARCHAR(50), tbl><table_name, sysname, ThisTable> 
       (<columns_for_index, NVARCHAR(MAX), ThisColumn DESC, ThatColumn DESC, OtherColumn DESC>)
  WITH (PAD_INDEX = ON, FILLFACTOR = <fillfactor, INT, 70>)


