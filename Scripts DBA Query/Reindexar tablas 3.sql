SELECT count(TABLE_NAME) FROM INFORMATION_SCHEMA.TABLES


	SELECT * FROM INFORMATION_SCHEMA.TABLES where table_schema = 'dbo' and TABLE_TYPE = 'BASE TABLE' --and table_name like '@xamn%'
		
	--select O.Name as Name, S.Name as schemaName from sys.objects O  inner join sys.schemas S on O.Schema_id=S.Schema_id 
	--Where
	--		O.Type = 'U' 
	--	and O.Name <> 'dtProperties' 
	--	and O.Name not like 'sys%' 
	--	and O.Name like '@XAMN%'
	--	and S.Name ='dbo' 
	--Order by O.name


  --Reindexar la BD
DECLARE @TableName varchar(200)
DECLARE TableCursor CURSOR FOR
SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES
where --table_schema = 'dbo'
--and table_name like '@xamn%'
--and 
TABLE_TYPE = 'BASE TABLE'
OPEN TableCursor
FETCH NEXT FROM TableCursor INTO @TableName
WHILE @@FETCH_STATUS = 0
     BEGIN
     PRINT 'Reindexando ' + @TableName
     DBCC DBREINDEX (@TableName)
     FETCH NEXT FROM TableCursor INTO @TableName
     END
CLOSE TableCursor
DEALLOCATE TableCursor
--Generar las nuevas estadisticas
sp_updatestats

---ver el nivel de fragmentaicon de los inidices

--Script to identify table fragmentation

--Declare variables
DECLARE
@ID int,
@IndexID int,
@IndexName varchar(128)

--Set the table and index to be examined
SELECT @IndexName = 'index_name' --enter name of index
SET @ID = OBJECT_ID('table_name') --enter name of table

--Get the Index Values
SELECT @IndexID = IndID
FROM sysindexes
WHERE id = @ID AND name = @IndexName

--Display the fragmentation
DBCC SHOWCONTIG (@id, @IndexID)





 
SELECT 'ALTER INDEX [' + i.name + '] on NombreBaseDatos.dbo.' + t.name + 
       ' REBUILD;Print ''Tabla ' + i.name + ' indexada;'''
  FROM sys.indexes i,
       sys.tables t
 WHERE i.object_id > 97
   AND isnull(i.name,'x') <> 'x'
   AND i.name not like 'queue%'
   AND i.object_id = t.object_id

   SELECT 'ALTER INDEX [' + i.name + '] on '+ DB_NAME()+'.dbo.' + t.name + ' REBUILD; Print "Tabla ' + i.name + ' indexada;";'
 FROM sys.indexes i,       sys.tables t
WHERE i.object_id > 97
 AND isnull(i.name,'x') <> 'x'
 AND i.name not like 'queue%'
 AND i.object_id = t.object_id