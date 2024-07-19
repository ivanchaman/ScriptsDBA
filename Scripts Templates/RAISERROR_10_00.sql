Need these files in 2000 and 2005 for 10, 16, 20, and 25, with comments on what each error level does


DECLARE @sMsg NVARCHAR(400)

SET @sMsg = N'<message, NVARCHAR(400), >'
RAISERROR(@sMsg, 10, 1) WITH NOWAIT<with_log, sysname, , LOG>

