-- These lines must appear at the top of every batch for error-handling.
DECLARE @nMyErr        INT             SET @nMyErr        = 0
DECLARE @nRowsAffected INT             SET @nRowsAffected = 0
DECLARE @sMsg          NVARCHAR(400)   SET @sMsg          = N''

