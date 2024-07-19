--*************************************************************  
--* Elimina las conexiones que esten en SLEEPING y tengan mas *
--* de 24 horas sin actividad en su ultimo LAST_BATCH         *
--*-----------------------------------------------------------*
--* Ing. Isaias Islas G.                                      *
--************************************************************* 
DECLARE @spid INT  
DECLARE @SQLString NVARCHAR(50)
     
USE master   
WHILE EXISTS(SELECT spid
			FROM master..sysprocesses
			WHERE status = 'sleeping' AND
			last_batch <= DATEADD(DD, -1, GETDATE())
			AND spid > 50 and spid <> @@spid)  -- Los spids del 1 al 50, son del sistema
	BEGIN
		SELECT TOP 1 @spid = spid FROM master..sysprocesses
			WHERE status = 'sleeping' AND
			last_batch <= DATEADD(DD, -1, GETDATE())
			AND spid > 50 and spid <> @@spid
		SET @SQLString = N'KILL ' + CONVERT(VARCHAR(10), @spid)
		EXECUTE sp_executesql @SQLString
		CONTINUE
	END
	
		