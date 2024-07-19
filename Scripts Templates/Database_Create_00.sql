CREATE DATABASE <database_name, sysname, >
RAISERROR(N'Creating database "<database_name, sysname, >"', 10, 1) WITH NOWAIT, LOG
SET @nMyErr = @@ERROR, @nRowsAffected = @@ROWCOUNT IF @nMyErr != 0 BEGIN RAISERROR('     <Failure Message, NVARCHAR, *** Failed to ...> - @@ERROR: %d', 16, 1, @nMyErr) IF 0 < @@TRANCOUNT ROLLBACK RETURN END

