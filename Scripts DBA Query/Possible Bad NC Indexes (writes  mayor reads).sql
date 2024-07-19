EXECUTE master.sys.sp_MSforeachdb 'USE [?];
IF ''?'' NOT IN (''master'',''model'',''msdb'', ''tempdb'') 
BEGIN
SELECT TOP(25) db_name() as ''Database'',OBJECT_NAME(s.[object_id]) AS [Table Name], i.name AS [Index Name], 
o.[type_desc], o.create_date, i.index_id, i.is_disabled,
user_updates AS [Total Writes], user_seeks + user_scans + user_lookups AS [Total Reads],
user_updates - (user_seeks + user_scans + user_lookups) AS [Difference]
FROM sys.dm_db_index_usage_stats AS s WITH (NOLOCK)
INNER JOIN sys.indexes AS i WITH (NOLOCK)
ON s.[object_id] = i.[object_id]
AND i.index_id = s.index_id
INNER JOIN sys.objects AS o WITH (NOLOCK) 
ON i.[object_id] = o.[object_id]
WHERE OBJECTPROPERTY(s.[object_id],''IsUserTable'') = 1
AND s.database_id = DB_ID()
AND user_updates > (user_seeks + user_scans + user_lookups)
AND i.index_id > 1
ORDER BY [Difference] DESC, [Total Writes] DESC, [Total Reads] ASC OPTION (RECOMPILE);
END'