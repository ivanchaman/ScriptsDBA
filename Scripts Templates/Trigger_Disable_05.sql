
-----------------------------------------------------------------------------
-- Disable trigger <trigger_name, sysname, TR_tablename_IUD> on table <table_name, sysname, ThisTable>.
-----------------------------------------------------------------------------

-- These lines must appear at the top of every batch, for error-handling.
DECLARE @nMyErr        INT             SET @nMyErr        = 0
DECLARE @nRowsAffected INT             SET @nRowsAffected = 0
DECLARE @sMsg          NVARCHAR(400)   SET @sMsg          = N''

USE <database_name, sysname, MyDB>
SET ANSI_NULLS ON

IF OBJECT_ID(N'<schema_name, sysname, dbo>.<trigger_name, sysname, TR_tablename_IUD>', N'TR') IS NOT NULL
BEGIN
    RAISERROR(N'Disabling trigger <trigger_name, sysname, TR_tablename_IUD>', 10, 1) WITH NOWAIT, LOG

    -- Microsoft glitch: DISABLE is not yet a keyword, so the previous statement
    -- MUST end with a semi-colon.  Putting it here is clearer.
    -- https://connect.microsoft.com/SQLServer/feedback/ViewFeedback.aspx?FeedbackID=307937&wa=wsignin1.0
    ;DISABLE TRIGGER <schema_name, sysname, dbo>.<trigger_name, sysname, TR_tablename_IUD>
          ON <table_name_prefix, NVARCHAR(50), tbl><table_name, sysname, ThisTable>

    SELECT @nMyErr = @@ERROR, @nRowsAffected = @@ROWCOUNT  IF @nMyErr != 0  BEGIN  SET @sMsg = N'   *** Failed to disable trigger <trigger_name, sysname, TR_tablename_IUD> - @@ERROR: ' + CAST(@nMyErr AS NVARCHAR)   RAISERROR(@sMsg, 16, 1)   IF 0 < @@TRANCOUNT ROLLBACK   RETURN  END
     
    RAISERROR(N'Disabled  trigger <trigger_name, sysname, TR_tablename_IUD>', 10, 1) WITH NOWAIT, LOG
END

