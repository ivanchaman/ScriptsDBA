-- Obtiene la fecha del ultimo restart 
SELECT
crdate 
FROM
 sysdatabases 
WHERE name = 'tempdb'
go

-- Obtiene la fecha del ultimo accesso (Null = no accesada desde el ultimo reboot) 
SELECT name, last_access = (select X1= max(LA.xx)
from ( select xx =
max(last_user_seek)
where max(last_user_seek)is not null
union all
select xx = max(last_user_scan)
where max(last_user_scan)is not null
union all
select xx = max(last_user_lookup)
where max(last_user_lookup) is not null
union all
select xx =max(last_user_update)
where max(last_user_update) is not null) LA)
FROM master.dbo.sysdatabases sd 
left outer join sys.dm_db_index_usage_stats s 
on sd.dbid= s.database_id 
group by sd.name

-- Cuando fue la ultima vez que un usuario acceso a una base de datos
SELECT DatabaseName, MAX(LastAccessDate) DatabaseLastAccessedOn
FROM
 (SELECT
 DB_NAME(database_id) DatabaseName
 , last_user_seek
 , last_user_scan
 , last_user_lookup
 , last_user_update
 FROM sys.dm_db_index_usage_stats) AS Pvt
UNPIVOT
 (LastAccessDate FOR last_user_access IN
 (last_user_seek
 , last_user_scan
 , last_user_lookup
 , last_user_update)
 ) AS Unpvt
GROUP BY DatabaseName
HAVING DatabaseName NOT IN ('master', 'tempdb', 'model', 'msdb')
ORDER BY 2