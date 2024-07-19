
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


-----------------------------------------------------------------------------
-- Create function.
-----------------------------------------------------------------------------

RAISERROR('Creating user-defined function <function_name, sysname, Function Name (No Prefix)>', 10, 1) WITH NOWAIT<with_log, sysname, , LOG >

GO

CREATE FUNCTION <schema_name, sysname, dbo>.<function_name, sysname, Function Name (No Prefix)>
    (<parameter1, sysname, @MyParam1> <datatype1,, INT>,
     <parameter2, sysname, @MyParam2> <datatype2,, INT>)
RETURNS <datatype_return_value,, INT> WITH EXECUTE AS CALLER AS
BEGIN
    DECLARE <@ResultVar, sysname, @Result> <datatype_return_value,, INT>

    Your code here.

    RETURN <@ResultVar, sysname, @Result>
END

GO

RAISERROR('Created  user-defined function <function_name, sysname, Function Name (No Prefix)>', 10, 1) WITH NOWAIT<with_log, sysname, , LOG >


        Add extended property for function?
        