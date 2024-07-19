-- Missing Indexes in current database by Index Advantage 
2.SELECT user_seeks * avg_total_user_cost * ( avg_user_impact * 0.01 ) 
3.AS [index_advantage] ,
4.migs.last_user_seek , 
5.mid.[statement] AS [Database.Schema.Table] ,
6.mid.equality_columns , 
7.mid.inequality_columns , 
8.mid.included_columns , migs.unique_compiles , 
9.migs.user_seeks , 
10.migs.avg_total_user_cost , 
11.migs.avg_user_impact
12.FROM sys.dm_db_missing_index_group_stats AS migs WITH ( NOLOCK ) 
13.INNER JOIN sys.dm_db_missing_index_groups AS mig WITH ( NOLOCK ) 
14.ON migs.group_handle = mig.index_group_handle 
15.INNER JOIN sys.dm_db_missing_index_details AS mid WITH ( NOLOCK ) 
16.ON mig.index_handle = mid.index_handle
17.WHERE mid.database_id = DB_ID()
18.ORDER BY index_advantage DESC ;
