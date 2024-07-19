-- Possible Bad NC Indexes (writes > reads)
2.SELECT OBJECT_NAME(s.[object_id]) AS [Table Name] , 
3.i.name AS [Index Name] , 
4.i.index_id , 
5.user_updates AS [Total Writes] , 
6.user_seeks + user_scans + user_lookups AS [Total Reads] , 
7.user_updates - ( user_seeks + user_scans + user_lookups ) 
8.AS [Difference]
9.FROM sys.dm_db_index_usage_stats AS s WITH ( NOLOCK ) 
10.INNER JOIN sys.indexes AS i WITH ( NOLOCK ) 
11.ON s.[object_id] = i.[object_id] 
12.AND i.index_id = s.index_id
13.WHERE OBJECTPROPERTY(s.[object_id], ‘IsUserTable’) = 1 
14.AND s.database_id = DB_ID() 
15.AND user_updates > ( user_seeks + user_scans + user_lookups ) 
16.AND i.index_id > 1
17.ORDER BY [Difference] DESC , 
18.[Total Writes] DESC , 
19.[Total Reads] ASC ;
