IF -3 != CURSOR_STATUS('local', '<cursor_name, sysname, TheCursor>') 
BEGIN
    RAISERROR ('Dropping cursor <cursor_name, sysname, TheCursor>', 10, 1) WITH NOWAIT
    CLOSE <cursor_name, sysname, TheCursor>
    DEALLOCATE <cursor_name, sysname, TheCursor>
END
