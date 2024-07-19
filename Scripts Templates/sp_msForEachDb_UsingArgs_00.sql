
SET NOCOUNT ON                                     -- Minimize network traffic.
SET XACT_ABORT ON                                  -- Make transactions behave.
SET ROWCOUNT 0                                     -- Reset in case it got set.

-- Exclude specific databases (full version).
DECLARE @sPreCommand  NVARCHAR(2000)
DECLARE @sCommand1    NVARCHAR(2000)
DECLARE @sCommand2    NVARCHAR(2000)
DECLARE @sCommand3    NVARCHAR(2000)
DECLARE @sPostCommand NVARCHAR(2000)
DECLARE @sReturn      NVARCHAR(2000)
DECLARE @cReplace     NCHAR(1)

SET @sPreCommand  = N'PRINT ''Pre Command'''
SET @sCommand1    = N'IF ''#'' <> ''tempdb'' PRINT '' ''  PRINT ''   Begin Processing DB #'''
SET @sCommand2    = N'IF ''#'' <> ''tempdb'' DBCC CHECKDB (N''#'') WITH ALL_ERRORMSGS'
SET @sCommand3    = N'IF ''#'' <> ''tempdb'' PRINT ''   End Processing DB #'' '
SET @cReplace     = N'#'
SET @sReturn      = N''
SET @sPostCommand = N'PRINT ''Post Command'' PRINT '' '' '

EXEC @sReturn = sp_MSforeachdb
     @sCommand1, @cReplace, @sCommand2, @sCommand3, @sPreCommand, @sPostCommand

PRINT N'@sReturn: N' + @sReturn
PRINT N' '

GO

-------------------------------------------------------------------------------

SET NOCOUNT ON                                     -- Minimize network traffic.
SET XACT_ABORT ON                                  -- Make transactions behave.
SET ROWCOUNT 0                                     -- Reset in case it got set.

-- Process all non-Microsoft databases (simplest version).
DECLARE @sMaxSysDbId  NVARCHAR(  32)
DECLARE @sCommand1    NVARCHAR(4000)
DECLARE @sCommand2    NVARCHAR(4000)
DECLARE @sCommand3    NVARCHAR(4000)

SET @sMaxSysDbId = N'4'
SET @sCommand1   = N'PRINT ''Begin Processing ?'' '

SET @sCommand2 =
    '
    USE ?

    -- Exclude system databases (those with an ID less than or equal to @sMaxSysDbId).
    IF DB_ID(N''?'') > ' + @sMaxSysDbId + '
    BEGIN
        PRINT ''   Processing database ?''
    END
    '
SET @sCommand3   = N'PRINT ''End Processing ?'' PRINT '' '' '

EXEC sp_MSforeachdb 
    @command1 = @sCommand1,
    @command2 = @sCommand2,
    @command3 = @sCommand3

GO
