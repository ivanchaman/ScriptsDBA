
SET NOCOUNT ON                                     -- Minimize network traffic.
SET XACT_ABORT ON                                  -- Make transactions behave.
SET ROWCOUNT 0                                     -- Reset in case it got set.

-- Process all non-Microsoft databases.
DECLARE @sMaxSysDbId NVARCHAR(  32)
DECLARE @sCommand    NVARCHAR(4000)

SET @sMaxSysDbId = N'4'

SET @sCommand =
    '
    USE ?

    -- Exclude system databases (those with an ID less than or equal to @sMaxSysDbId).
    IF DB_ID(N''?'') > ' + @sMaxSysDbId + '
    BEGIN
        PRINT N''Processing database ?''
    END
    '

EXEC sp_MSforeachdb @sCommand

GO

-------------------------------------------------------------------------------

SET NOCOUNT ON                                     -- Minimize network traffic.
SET XACT_ABORT ON                                  -- Make transactions behave.
SET ROWCOUNT 0                                     -- Reset in case it got set.

-- Exclude specific databases.
DECLARE @sCommand NVARCHAR(4000)

SET @sCommand =
    '
    IF   ''?'' != ''master''
    AND  ''?'' != ''model''
    AND  ''?'' != ''msdb''
    AND  ''?'' != ''pubs''
    AND  ''?'' != ''Northwind''
    AND  ''?'' != ''tempdb''
    BEGIN
            PRINT ''Processing database ?''
    END
'

EXEC sp_MSforeachdb @sCommand

GO
