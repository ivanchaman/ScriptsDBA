
INSERT INTO <schema_name, sysname, dbo>.<table_name_prefix, NVARCHAR(50), tbl><insert_into_table, sysname, InsertIntoTable>
    (<columns_for_insert, NVARCHAR(MAX), ThisInsertColumn, ThatInsertColumn, TheOtherInsertColumn>)
VALUES
    (<values_for_insert, NVARCHAR(MAX), InsertValue1, InsertValue2, InsertValue3>)
OUTPUT inserted.<columns_for_output, NVARCHAR(MAX), ThisOutputColumn, ThatOutputColumn, TheOtherOutputColumn>,
       <values_for_output, NVARCHAR(MAX), OutputValue1, OutputValue2, OutputValue3>
  INTO <schema_name, sysname, dbo>.<table_name_prefix, NVARCHAR(50), tbl><into_table, sysname, OutputIntoTable>
    (<columns_for_into, NVARCHAR(MAX), ThisIntoColumn,
     ThatIntoColumn, TheOtherIntoColumn>)
