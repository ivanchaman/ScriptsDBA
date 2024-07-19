
-----------------------------------------------------------------------------
-- Create trigger <trigger_name, sysname, TR_tablename_IUD> on table <table_name_prefix, sysname, tbl><table_name, sysname, ThisTable>.
-----------------------------------------------------------------------------

-- These lines must appear at the top of every batch, for error-handling.
DECLARE @nMyErr        INT             SET @nMyErr        = 0
DECLARE @nRowsAffected INT             SET @nRowsAffected = 0
DECLARE @sMsg          NVARCHAR(400)   SET @sMsg          = N''

USE <database_name, sysname, MyDB>
SET ANSI_NULLS ON

-- Drop any existing one.
IF OBJECT_ID(N'<schema_name, sysname, dbo>.<trigger_name, sysname, TR_tablename_IUD>', N'TR') IS NOT NULL
BEGIN
    RAISERROR(N'Dropping trigger <trigger_name, sysname, TR_tablename_IUD>', 10, 1) WITH NOWAIT, LOG
    DROP TRIGGER <schema_name, sysname, dbo>.<trigger_name, sysname, TR_tablename_IUD> 
    SELECT @nMyErr = @@ERROR, @nRowsAffected = @@ROWCOUNT  IF @nMyErr != 0  BEGIN  SET @sMsg = N'   *** Failed to create trigger <trigger_name, sysname, TR_tablename_IUD> - @@ERROR: ' + CAST(@nMyErr AS NVARCHAR)   RAISERROR(@sMsg, 16, 1)   IF 0 < @@TRANCOUNT ROLLBACK   RETURN  END
END

-- Guarantees idempotency.
IF OBJECT_ID(N'<schema_name, sysname, dbo>.<trigger_name, sysname, TR_tablename_IUD>', N'TR') IS NOT NULL
BEGIN
    RAISERROR(N'Trigger <trigger_name, sysname, TR_tablename_IUD> does not exist - should be impossible to get here', 10, 1) WITH NOWAIT, LOG
    RETURN
END

-- Create new one.
RAISERROR(N'Creating trigger <trigger_name, sysname, TR_tablename_IUD>', 10, 1) WITH NOWAIT, LOG
GO

CREATE TRIGGER <trigger_name, sysname, TR_tablename_IUD>
     ON <schema_name, sysname, dbo>.<table_name_prefix, sysname, tbl><table_name, sysname, ThisTable> AFTER <trigger_after, , INSERT, UPDATE, DELETE> AS
BEGIN
    SET NOCOUNT ON

    Trigger Code Goes Here!

END
GO

-- Only way to check if CREATE TRIGGER statement failed.
IF OBJECT_ID(N'<schema_name, sysname, dbo>.<trigger_name, sysname, TR_tablename_IUD>', N'TR') IS NULL
BEGIN
    RAISERROR(N'     *** Failed to create trigger <trigger_name, sysname, TR_tablename_IUD>', 16, 1)
    IF 0 < @@TRANCOUNT BEGIN ROLLBACK RETURN END
END
