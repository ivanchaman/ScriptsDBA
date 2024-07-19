
    -- Framework for TRY...CATCH.  Real work done in usp_ErrorHandler().


BEGIN TRY
    BEGIN TRAN
    RAISERROR('VERBing ... on ...', 10, 1) WITH NOWAIT, LOG
    
                    Your code here.
    
    RAISERROR('VERBed  ... on ...', 10, 1) WITH NOWAIT, LOG
    COMMIT TRAN
END TRY
BEGIN CATCH
    -- Annoyingly, only *last* error can be caught.  This is not a bug.
    -- See  http://blogs.msdn.com/sqlprogrammability/archive/2006/04/03/567550.aspx
    IF XACT_STATE() = -1  BEGIN  RAISERROR(N'Rolling back uncommittable transaction.', 10, 1) WITH LOG  ROLLBACK TRANSACTION  END
    IF @@TRANCOUNT  =  1  BEGIN  RAISERROR(N'Rolling back non-nested transaction.',    10, 1) WITH LOG  ROLLBACK TRANSACTION  END
    EXEC usp_ErrorHandler
    RETURN
END CATCH
