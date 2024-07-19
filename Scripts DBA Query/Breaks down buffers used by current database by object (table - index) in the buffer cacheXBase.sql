
EXECUTE master.sys.sp_MSforeachdb 'USE [?];
IF ''?'' NOT IN (''master'',''model'',''msdb'', ''tempdb'') 
BEGIN
SELECT DB_NAME(DB_ID()) AS [Database Name], OBJECT_NAME(p.[object_id]) AS [ObjectName], 
p.index_id, COUNT(*)/128 AS [Buffer size(MB)],  COUNT(*) AS [BufferCount], 
p.data_compression_desc AS [CompressionType], a.type_desc, p.[rows]
FROM sys.allocation_units AS a WITH (NOLOCK)
INNER JOIN sys.dm_os_buffer_descriptors AS b WITH (NOLOCK)
ON a.allocation_unit_id = b.allocation_unit_id
INNER JOIN sys.partitions AS p WITH (NOLOCK)
ON a.container_id = p.partition_id
WHERE b.database_id = CONVERT(int,DB_ID())
AND p.[object_id] > 100
GROUP BY p.[object_id], p.index_id, p.data_compression_desc, a.type_desc, p.[rows]
ORDER BY [BufferCount] DESC OPTION (RECOMPILE);
END'
