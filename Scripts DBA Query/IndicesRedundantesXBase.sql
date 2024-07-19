EXECUTE master.sys.sp_MSforeachdb 'USE [?];
IF ''?'' NOT IN (''master'',''model'',''msdb'') 
BEGIN
;WITH IndexColumns as(
SELECT DISTINCT
schema_name (o.schema_id) AS ''SchemaName''
,object_name(o.object_id) AS TableName
,i.Name AS IndexName
,o.object_id
,i.index_id
,i.type
,(SELECT CASE key_ordinal WHEN 0 THEN NULL ELSE ''[''+col_name(k.object_id,column_id) +'']'' END AS [data()]
FROM sys.index_columns AS k WHERE k.object_id = i.object_id AND k.index_id = i.index_id
ORDER BY key_ordinal, column_id FOR XML PATH('''')) AS cols
FROM sys.indexes AS i INNER JOIN sys.objects o ON i.object_id =o.object_id 
INNER JOIN sys.index_columns ic ON ic.object_id =i.object_id AND ic.index_id =i.index_id
INNER JOIN sys.columns c ON c.object_id = ic.object_id AND c.column_id = ic.column_id
WHERE i.object_id in (SELECT object_id FROM sys.objects WHERE type =''U'') AND i.index_id <>0 AND i.type <>3 AND i.type <>6
GROUP BY o.schema_id,o.object_id,i.object_id,i.Name,i.index_id,i.type
) 
SELECT db_name(),
ic1.SchemaName,ic1.TableName,ic1.IndexName,ic1.cols AS IndexCols,ic2.IndexName AS RedundantIndexName, ic2.cols AS RedundantIndexCols
FROM IndexColumns ic1
JOIN IndexColumns ic2 ON ic1.object_id = ic2.object_id
AND ic1.index_id <> ic2.index_id
AND ic1.cols <> ic2.cols
AND ic2.cols LIKE REPLACE(ic1.cols,''['',''[[]'') + '' %''
ORDER BY 1,2,3,5
END'