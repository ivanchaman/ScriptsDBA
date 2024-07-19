EXECUTE master.sys.sp_MSforeachdb 'USE [?];
IF ''?'' NOT IN (''master'',''model'',''msdb'', ''tempdb'') 
BEGIN
SELECT TOP(25) DB_NAME(DB_ID()) AS [Database Name], OBJECT_NAME(objectid) AS [ObjectName], 
               query_plan, cp.objtype, cp.usecounts
FROM sys.dm_exec_cached_plans AS cp WITH (NOLOCK)
CROSS APPLY sys.dm_exec_query_plan(cp.plan_handle) AS qp
WHERE CAST(query_plan AS NVARCHAR(MAX)) LIKE N''%MissingIndex%''
AND dbid = DB_ID()
ORDER BY cp.usecounts DESC OPTION (RECOMPILE);
END'