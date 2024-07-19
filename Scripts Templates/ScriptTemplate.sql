-------------------------------------------------------------------------------
-- <filename, nvarchar(260), .sql>                                             
--                                                                             
-- <file description, nvarchar(4000), >                                        
-------------------------------------------------------------------------------
-- Revision: <today, datetime, 2010-01-13>  - Rev. 0                           
-------------------------------------------------------------------------------
-- Copyright 2010  Larry Leonard, Definitive Solutions, Inc.                   
--                 http://www.LarryLeonard.net                                 
--                                                                             
-- Copying and distribution of this file, with or without modification, are    
-- permitted in any medium without royalty provided the copyright notice and   
-- this notice are preserved. This file is offered as-is without any warranty. 
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-- MUST be set as shown to support indexes on computed columns, indexed views. 
SET ANSI_NULLS ON                                 -- Deprecated: leave set ON. 
SET ANSI_PADDING ON                               -- Deprecated: leave set ON. 
SET ANSI_WARNINGS ON                              -- No trailing blanks saved. 
SET ARITHABORT ON                                 -- Math failure not ignored. 
SET CONCAT_NULL_YIELDS_NULL ON                    -- NULL plus string is NULL. 
SET NUMERIC_ROUNDABORT OFF                        -- Allows loss of precision. 
SET QUOTED_IDENTIFIER ON                          -- Allows reserved keywords. 

-- These aren't, strictly speaking, required, but are generally good practice. 
SET NOCOUNT ON                                    -- Minimize network traffic. 
SET ROWCOUNT 0                                    -- Reset in case it got set. 
SET XACT_ABORT ON                                 -- Make transactions behave. 

-- Some additional checks, useful while debugging, but safe in production too. 
IF DB_ID() <= 4                                                        RAISERROR('   $$$ YOU ARE ATTACHED TO A SYSTEM DB $$$',   20, 1) WITH NOWAIT, LOG
IF 10 > CAST(CAST(SERVERPROPERTY('ProductVersion') AS CHAR(2)) AS INT) RAISERROR('   $$$ REQUIRES SQL SERVER 2008 OR LATER $$$', 20, 1) WITH NOWAIT, LOG
IF @@TRANCOUNT <> 0                                                    RAISERROR('   $$$ OPEN TRANSACTION EXISTS $$$',           20, 1) WITH NOWAIT, LOG

-- Optional. Do error capturing with TRY-CATCH blocks, and open a transaction. 
BEGIN TRY                                         -- Indent improperly; we can 
BEGIN TRAN                                        -- have more chars per line. 
-------------------------------------------------------------------------------


-------------------------------------------------------------------------------
--                                                                             
-------------------------------------------------------------------------------






-------------------------------------------------------------------------------
-- Done. Remember that the BEGIN TRAN and the TRY were not indented properly.  
-------------------------------------------------------------------------------

COMMIT TRAN
END TRY
BEGIN CATCH
   IF XACT_STATE() = -1  BEGIN  RAISERROR('Rolling back uncommittable transaction.', 10, 1) WITH LOG  ROLLBACK TRANSACTION  END
   IF @@TRANCOUNT  =  1  BEGIN  RAISERROR('Rolling back non-nested transaction.',    10, 1) WITH LOG  ROLLBACK TRANSACTION  END
   EXEC usp_ErrorHandler
   RETURN
END CATCH

GO
