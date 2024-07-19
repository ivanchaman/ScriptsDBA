
SET NOCOUNT ON
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON


-- Drop any existing one.
IF EXISTS (SELECT * FROM sys.procedures WHERE name = '<stored_procedure_name, sysname, usp_>')
BEGIN
    RAISERROR ('Dropping stored procedure <stored_procedure_name, sysname, usp_>', 10, 1) WITH NOWAIT, LOG
    DROP PROCEDURE <stored_procedure_name, sysname, usp_>
    RAISERROR ('Dropped  stored procedure <stored_procedure_name, sysname, usp_>', 10, 1) WITH NOWAIT, LOG
END

-- Create stored procedure.
RAISERROR ('Creating stored procedure <stored_procedure_name, sysname, usp_>', 10, 1) WITH NOWAIT, LOG
GO

CREATE PROCEDURE <stored_procedure_name, sysname, usp_>
    <parameter1, sysname, @MyParam1> <datatype1,, INT> = <default_value_for_param1, , 111>,
    <parameter2, sysname, @MyParam2> <datatype2,, INT> = <default_value_for_param2, , 222>
AS
BEGIN

    -- Prevent extra result sets from interfering with SELECT statements.
    SET NOCOUNT ON

    -- Your code here.

END
GO
RAISERROR ('Created  stored procedure <stored_procedure_name, sysname, usp_>', 10, 1) WITH NOWAIT, LOG




        Add extended property?
