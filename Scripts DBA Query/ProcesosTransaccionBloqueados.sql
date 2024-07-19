--SELECT * FROM master.dbo.sysprocesses WHERE spid IN (SELECT blocked FROM master.dbo.sysprocesses)

--SELECT spid, blocked, waittime FROM master.dbo.sysprocesses WHERE blocked > 0
--exec sp_who 131
--exec sp_who 115
--exec sp_who 113
--Execute sp_lock 53

--dbcc inputbuffer(53)

--SELECT * FROM [GobiernoWeb2012].[dbo].[Com_FacturaE_Electronica] WHERE FechaTimbrado > '2015-10-30T11:57:24' order by FechaTimbrado

SET nocount ON

DECLARE @blocker_spid    INT,
        @blockee_spid    INT,
        @blockee_blocker INT
DECLARE @blockee_waitime INT

IF EXISTS
   ( SELECT *
     FROM   master.dbo.SYSPROCESSES
     WHERE  spid IN
            ( SELECT blocked
              FROM   master.dbo.SYSPROCESSES ) ) BEGIN
      DECLARE blocker_cursor CURSOR FOR
        SELECT spid
        FROM   master.dbo.SYSPROCESSES
        WHERE  spid IN
               ( SELECT blocked
                 FROM   master.dbo.SYSPROCESSES ) AND
               blocked = 0
      DECLARE blockee_cursor CURSOR FOR
        SELECT spid,
               blocked,
               waittime
        FROM   master.dbo.SYSPROCESSES
        WHERE  blocked > 0

      OPEN blocker_cursor

      FETCH next FROM blocker_cursor INTO @blocker_spid

      WHILE ( @@FETCH_STATUS = 0 ) BEGIN
            SELECT 'Spid Bloqueador: ',
                   @blocker_spid

            EXEC Sp_who @blocker_spid

            EXEC Sp_who2 @blocker_spid

            EXEC Sp_executesql N'dbcc inputbuffer(@Param)',N'@Param int',@blocker_spid

            --SELECT Blocked = spid FROM master.dbo.sysprocesses WHERE blocked = @blocker_spid
            OPEN blockee_cursor

            FETCH next FROM blockee_cursor INTO @blockee_spid, @blockee_blocker, @blockee_waitime

            WHILE ( @@fetch_status = 0 ) BEGIN
                  --SELECT Blocked = spid FROM master.dbo.sysprocesses WHERE blocked = @blocker_spid
                  --Select 'EE: ', @blockee_blocker, ' Er: ',@blocker_spid
                  IF ( @blockee_blocker = @blocker_spid ) BEGIN
                        SELECT 'Blockee: Waittime:',
                               @blockee_spid,
                               @blockee_waitime

                        EXEC Sp_executesql N'dbcc inputbuffer(@Param)',N'@Param int',@blockee_spid
                    END

                  FETCH next FROM blockee_cursor INTO @blockee_spid, @blockee_blocker, @blockee_waitime
              END

            CLOSE blockee_cursor

            FETCH next FROM blocker_cursor INTO @blocker_spid
        END

      CLOSE blocker_cursor

      DEALLOCATE blockee_cursor

      DEALLOCATE blocker_cursor
  --go
  END
ELSE
  SELECT 'No hay procesos bloqueados!' AS Resultado

go

--kill 75   
