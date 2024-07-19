Use GobiernoWeb2014
SELECT 
DISTINCT OBJECT_NAME(sis.OBJECT_ID) TableName,
si.name AS IndexName,
sc.Name AS ColumnName,
sis.user_seeks,  
sis.user_scans,  
sis.user_lookups, 
sis.user_updates 
FROM sys.dm_db_index_usage_stats sis
INNER JOIN sys.indexes si  on sis.object_id = si.object_id and sis.index_id = si.Index_id
INNER JOIN sys.index_columns sic on sis.object_id = sic.object_id and sic.Index_id = si.Index_id
INNER JOIN sys.columns sc on sis.object_id = sc.object_id and sic.Column_id = sc.Column_id
INNER JOIN  sys.objects o on si.object_id = o.object_id
WHERE sis.database_id = DB_ID('GobiernoWeb2014') and o.type = 'U' ;