/* POR BASE DE DATOS OBTIENE EL NOMBRE DE LAS TABLAS Y EL TOTAL DE FILAS(registros) */

EXECUTE master.sys.sp_MSforeachdb 'USE [?];
IF ''?'' NOT IN (''master'',''model'',''msdb'', ''tempdb'') 
BEGIN
SELECT DB_NAME(DB_ID()) AS [Database Name],OBJECT_NAME(object_id) AS [ObjectName], 
SUM(Rows) AS [RowCount] --, data_compression_desc AS [CompressionType]
FROM sys.partitions WITH (NOLOCK)
WHERE index_id < 2 --ignore the partitions from the non-clustered index if any
AND OBJECT_NAME(object_id) NOT LIKE N''sys%''
AND OBJECT_NAME(object_id) NOT LIKE N''queue_%'' 
AND OBJECT_NAME(object_id) NOT LIKE N''filestream_tombstone%'' 
AND OBJECT_NAME(object_id) NOT LIKE N''fulltext%''
AND OBJECT_NAME(object_id) NOT LIKE N''ifts_comp_fragment%''
GROUP BY object_id --, data_compression_desc
ORDER BY SUM(Rows) DESC OPTION (RECOMPILE);
END'


/* el campo: data_compression_desc existe en la version 2008 

EXECUTE master.sys.sp_MSforeachdb 'USE [?];
IF ''?'' NOT IN (''master'',''model'',''msdb'', ''tempdb'') 
BEGIN
SELECT DB_NAME(DB_ID()) AS [Database Name],OBJECT_NAME(object_id) AS [ObjectName], 
SUM(Rows) AS [RowCount], data_compression_desc AS [CompressionType]
FROM sys.partitions WITH (NOLOCK)
WHERE index_id < 2 --ignore the partitions from the non-clustered index if any
AND OBJECT_NAME(object_id) NOT LIKE N''sys%''
AND OBJECT_NAME(object_id) NOT LIKE N''queue_%'' 
AND OBJECT_NAME(object_id) NOT LIKE N''filestream_tombstone%'' 
AND OBJECT_NAME(object_id) NOT LIKE N''fulltext%''
AND OBJECT_NAME(object_id) NOT LIKE N''ifts_comp_fragment%''
GROUP BY object_id, data_compression_desc
ORDER BY SUM(Rows) DESC OPTION (RECOMPILE);
END'
*/

/*
select top 10 * from sys.partitions 
Invalid column name 'data_compression_desc'.
*/
