
-- Declare, use, and deallocate cursor.
DECLARE <variable_name1, sysname, @MyVar1> <datatype1,, INT>
DECLARE <variable_name2, sysname, @MyVar2> <datatype2,, INT>
DECLARE <variable_name3, sysname, @MyVar3> <datatype3,, INT>

DECLARE <cursor_name, sysname, TheCursor> CURSOR FOR
    <cursor_sql_statement, NVARCHAR(4000), SELECT * FROM MyTable>

OPEN <cursor_name, sysname, TheCursor>

FETCH NEXT FROM <cursor_name, sysname, TheCursor>
 INTO <variable_name1, sysname, @MyVar1>,
        <variable_name2, sysname, @MyVar2>,
        <variable_name3, sysname, @MyVar3>

WHILE @@FETCH_STATUS = 0
BEGIN

    -- Your code here.
    
    FETCH NEXT FROM <cursor_name, sysname, TheCursor>
     INTO <variable_name1, sysname, @MyVar1>, <variable_name2, sysname, @MyVar2>
END

-- Your code here, too.

-- Close and deallocate the cursor.
CLOSE <cursor_name, sysname, TheCursor>
DEALLOCATE <cursor_name, sysname, TheCursor>
