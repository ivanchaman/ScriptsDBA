-- Creates our standard error-handling routine.  Can be called from inside (or 
-- outside) a CATCH block.  Note if ERROR_PROCEDURE() IS NOT NULL then we are 
-- being called from a stored proc, so we can log the proc name and line number. 
-- Handles nested transactions correctly. 
-- C:\Users\Larry\AppData\Roaming\Microsoft\Microsoft SQL Server\100\Tools\Shell\Templates\Sql\LL_SSMS_SQL_Templates\ErrorHandling_CreateStoredProc_05.sql
--USE <database_name, sysname, MyDB>

SET NOCOUNT ON                                     -- Minimize network traffic.
SET XACT_ABORT ON                                  -- Make transactions behave.
SET ROWCOUNT 0                                     -- Reset in case it got set.

-- Drop any existing one.
IF EXISTS (SELECT * FROM sys.procedures WHERE name = N'usp_ErrorHandler')
BEGIN
    DROP PROCEDURE usp_ErrorHandler
END

-- CREATE PROCEDURE must be first line in batch (so it can't be inside an IF).
IF EXISTS (SELECT * FROM sys.procedures WHERE name = N'usp_ErrorHandler')
BEGIN
    RETURN
END

GO

-- Create the procedure.
CREATE PROCEDURE usp_ErrorHandler
AS
BEGIN
    SET NOCOUNT ON

    DECLARE @ENumber        INT            SET @ENumber      = ISNULL(ERROR_NUMBER(),          -1)
    DECLARE @ESeverity      INT            SET @ESeverity    = ISNULL(ERROR_SEVERITY(),        -1)
    DECLARE @EState         INT            SET @EState       = ISNULL(ERROR_STATE(),            0)  IF @EState = 0 SET @EState = 42
    DECLARE @EProcedure     NVARCHAR(126)  SET @EProcedure   = ISNULL(ERROR_PROCEDURE(), N'{N/A}')
    DECLARE @ELine          INT            SET @ELine        = ISNULL(ERROR_LINE(),            -1)
    DECLARE @EMessageRecv   NVARCHAR(2048) SET @EMessageRecv = ISNULL(ERROR_MESSAGE(),        N'')
    DECLARE @EMessageSent   NVARCHAR(440)  SET @EMessageSent = N''

    IF ERROR_PROCEDURE() IS NOT NULL   SET @EMessageSent = N'Error %d, Level %d, State %d, Procedure %s, Line %d, Message: '
    SET @EMessageSent = @EMessageSent + ERROR_MESSAGE()
    RAISERROR(@EMessageSent, @ESeverity, @EState, @ENumber, @ESeverity, @EState, @EProcedure, @ELine) WITH LOG
END

GO
