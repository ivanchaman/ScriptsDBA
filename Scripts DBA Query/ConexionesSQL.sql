SELECT 
      spid,
      master.dbo.sysprocesses.status,
      hostname,
      program_name,
      cmd,
      cpu,
      physical_io,
      blocked,
      master.dbo.sysdatabases.name,
      loginame
FROM   
      master.dbo.sysprocesses INNER JOIN
      master.dbo.sysdatabases ON
            sys.sysprocesses.dbid = sys.sysdatabases.dbid
ORDER BY spid

sp_who


SELECT db_name(dbid) as DatabaseName, count(dbid) as NoOfConnections,
loginame as LoginName
FROM sys.sysprocesses
WHERE dbid > 0
GROUP BY dbid, loginame

SELECT db_name(dbid) as DatabaseName, count(dbid) as NoOfConnections,
loginame as LoginName
FROM sys.sysprocesses
WHERE dbid > 0
GROUP BY dbid, loginame

select * from sys.sysprocesses

--Estadísticas de inicio de sesión
select * from sys.dm_exec_sessions

--número de sesiones de cada usuario
SELECT login_name ,COUNT(session_id) AS session_count 
FROM sys.dm_exec_sessions 
GROUP BY login_name;



--Buscar sesiones inactivas que tienen transacciones abiertas
SELECT s.* 
FROM sys.dm_exec_sessions AS s
WHERE EXISTS 
    (
    SELECT * 
    FROM sys.dm_tran_session_transactions AS t
    WHERE t.session_id = s.session_id
    )
    AND NOT EXISTS 
    (
    SELECT * 
    FROM sys.dm_exec_requests AS r
    WHERE r.session_id = s.session_id
    );



	select *

from master..sysprocesses

where status = 'sleeping' AND loginame like '%sa%' and cpu=0 and hostname like 'servidor%'

-- Elimina conexiones abiertas a la BD
go
CREATE PROCEDURE dbo.KillConexiones
@dbName SYSNAME
AS
BEGIN
SET NOCOUNT ON

DECLARE @spid INT,
@cnt INT,
@sql VARCHAR(255)

SELECT @spid = MIN(spid), @cnt = COUNT(*)
FROM master..sysprocesses
WHERE dbid = DB_ID(@dbname)
AND spid != @@SPID

PRINT 'Eliminando '+RTRIM(@cnt)+' procesos.'

WHILE @spid IS NOT NULL
BEGIN
PRINT 'Eliminando Proceso '+RTRIM(@spid)
SET @sql = 'KILL '+RTRIM(@spid)
EXEC(@sql)
SELECT @spid = MIN(spid), @cnt = COUNT(*)
FROM master..sysprocesses
WHERE dbid = DB_ID(@dbname)
AND spid != @@SPID
PRINT RTRIM(@cnt)+' Procesos por eliminar.'
END
END
GO

--
USE MASTER

GO

DECLARE @dbname sysname

SET @dbname = 'Suscripciones'

DECLARE @spid SMALLINT

DECLARE @KILL nVARCHAR(100)

DECLARE kill_cursor3 CURSOR FOR

select spid

from master..sysprocesses

where status = 'sleeping' AND dbid = db_id(@dbname) and loginame like '%sa%' and cpu=0 and hostname like 'servidor%'

OPEN kill_cursor3

FETCH NEXT FROM kill_cursor3 INTO @spid

WHILE @@FETCH_STATUS = 0

BEGIN

SET @KILL= 'kill '+cast(@spid as nvarchar(10))

EXEC sp_executeSQL @KILL

FETCH NEXT FROM kill_cursor3 INTO @spid

END

Close kill_cursor3

Deallocate kill_cursor3