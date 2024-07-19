
USE <database_name, sysname, MyDB>


-----------------------------------------------------------------------------
-- Drop any existing function.
-----------------------------------------------------------------------------

IF OBJECT_ID('<schema_name, sysname, dbo>.<function_name, sysname, Function Name (No Prefix)>') IS NOT NULL
BEGIN
    RAISERROR('Dropping user-defined function <function_name, sysname, Function Name (No Prefix)>', 10, 1) WITH NOWAIT<with_log, sysname, , LOG >
    DROP FUNCTION <schema_name, sysname, dbo>.<function_name, sysname, Function Name (No Prefix)>
    RAISERROR('Dropped  user-defined function <function_name, sysname, Function Name (No Prefix)>', 10, 1) WITH NOWAIT<with_log, sysname, , LOG >
END

