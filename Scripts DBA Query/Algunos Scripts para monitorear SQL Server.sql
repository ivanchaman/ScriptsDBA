--Para monitorear el estado de los jobs que fallaron en su última ejecución:

SELECT name FROM msdb.dbo.sysjobs A, msdb.dbo.sysjobservers B
                           WHERE A.job_id = B.job_id AND B.last_run_outcome = 0
--Espacio en cada disco para la instancia SQL:

EXEC master..xp_fixeddrives
Para ver un listado de Jobs Deshabilitados:
SELECT name FROM msdb.dbo.sysjobs
           WHERE enabled = 0 ORDER BY name
--Para ver un listado de los jobs que están actualmente en ejecución:

msdb.dbo.sp_get_composite_job_info  NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL
--Para ver logines que son miembros de los roles de servidor:
SELECT 'ServerRole' = A.name, 'MemberName' =  B.name
      FROM master.dbo.spt_values A, master.dbo.sysxlogins B
              WHERE A.low = 0 AND A.type = 'SRV' AND B.srvid IS NULL
--Para ver la última vez que las bases de datos fueron backupeadas:

SELECT  B.name as Database_Name, ISNULL(STR(ABS(DATEDIFF(day, GetDate(),
MAX(Backup_finish_date)))),
'NEVER') as DaysSinceLastBackup,
ISNULL(Convert(char(10), MAX(backup_finish_date), 101), 'NEVER')
as LastBackupDate
FROM master.dbo.sysdatabases B
LEFT OUTER JOIN msdb.dbo.backupset A
ON A.database_name = B.name AND A.type = 'D'
GROUP BY B.Name
ORDER BY B.name

--Para leer las ultimas entradas del archivo de log (NO el transaction log):

CREATE TABLE #Errors (vchMessage varchar(255), ID int)
CREATE INDEX idx_msg ON #Errors(ID, vchMessage)
INSERT #Errors EXEC xp_readerrorlog
SELECT vchMessage
FROM #Errors
WHERE vchMessage
NOT LIKE '%Log backed up%' AND vchMessage
NOT LIKE '%.TRN%' AND vchMessage
NOT LIKE '%Database backed up%' AND vchMessage
NOT LIKE '%.BAK%' AND vchMessage
NOT LIKE '%Run the RECONFIGURE%' AND
vchMessage NOT LIKE '%Copyright (c)%'
ORDER BY ID

DROP TABLE #Errors