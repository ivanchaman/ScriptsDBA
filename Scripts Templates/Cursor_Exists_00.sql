IF -3 != CURSOR_STATUS('local', '<cursor_name, sysname, TheCursor>') 
BEGIN
    PRINT 'Cursor <cursor_name, sysname, TheCursor> exists!'
END
