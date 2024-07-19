-- List unused indexes
2.SELECT OBJECT_NAME(i.[object_id]) AS [Table Name] ,
3.i.name
4.FROM sys.indexes AS i 
5.INNER JOIN sys.objects AS o ON i.[object_id] = o.[object_id]
6.WHERE i.index_id NOT IN ( SELECT s.index_id 
7.FROM sys.dm_db_index_usage_stats AS s 
8.WHERE s.[object_id] = i.[object_id] 
9.AND i.index_id = s.index_id 
10.AND database_id = DB_ID() ) 
11.AND o.[type] = ‘U’
12.ORDER BY OBJECT_NAME(i.[object_id]) ASC ;
