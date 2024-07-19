--Borramos la tabla de LOG
IF EXISTS (SELECT * FROM sysobjects WHERE name = 'fraglist' AND TYPE = 'U')
BEGIN
    DROP TABLE fraglist
END
GO
 
--Declaramos las variables
SET NOCOUNT ON
DECLARE @tablename VARCHAR (128)
DECLARE @execstr       VARCHAR (255)
DECLARE @objectid      INT
DECLARE @indexid       INT
DECLARE @indexname VARCHAR(128)
DECLARE @frag            DECIMAL
DECLARE @maxfrag     DECIMAL
 
-- EStablecemos el porcenataje maximo permitido de fragmentacion.
SELECT @maxfrag = 10.0
 
-- Declaramos el cursos.
DECLARE TABLES CURSOR FOR
   SELECT TABLE_NAME
   FROM INFORMATION_SCHEMA.TABLES
   WHERE TABLE_TYPE = 'BASE TABLE'
--and table_name like 'crmpun_3%'
 
-- Creamos la tabla de LOG.
CREATE TABLE fraglist (
   ObjectName CHAR (255),
   ObjectId INT,
   IndexName CHAR (255),
   IndexId INT,
   Lvl INT,
   CountPages INT,
   CountRows INT,
   MinRecSize INT,
   MaxRecSize INT,
   AvgRecSize INT,
   ForRecCount INT,
   Extents INT,
   ExtentSwitches INT,
   AvgFreeBytes INT,
   AvgPageDensity INT,
   ScanDensity DECIMAL,
   BestCount INT,
   ActualCount INT,
   LogicalFrag DECIMAL,
   ExtentFrag DECIMAL)
 
-- Abrimos el cursor.
OPEN TABLES
 
-- Hacemos un ciclo por todas las tablas de la BD.
FETCH NEXT
   FROM TABLES
   INTO @tablename
WHILE @@FETCH_STATUS = 0
BEGIN
 
-- Se jecuta el comando DBCC SHOWCONTIG command para obtener
-- informacion de fragmentacion de todas los indices de todas las tablas.
   INSERT INTO fraglist
   EXEC ('DBCC SHOWCONTIG (''' + @tablename + ''')
      WITH FAST, TABLERESULTS, ALL_INDEXES, NO_INFOMSGS')
   FETCH NEXT
      FROM TABLES
      INTO @tablename
END
 
-- Cerramos y borramos el cursor.
CLOSE TABLES
DEALLOCATE TABLES
 
-- Declaramos un cursor para obtener una lista de los indices fragmentados.
DECLARE indexes CURSOR FOR
   SELECT ObjectName, ObjectId, IndexId, LogicalFrag, IndexName
   FROM fraglist
   WHERE INDEXPROPERTY (ObjectId, IndexName, 'IndexDepth') > 0
--   WHERE LogicalFrag >= @maxfrag
--      AND INDEXPROPERTY (ObjectId, IndexName, 'IndexDepth') > 0
 
-- Abrimos el cursor.
OPEN indexes
 
-- Hacemos un ciclo por todos los indices.
FETCH NEXT
   FROM indexes
   INTO @tablename, @objectid, @indexid, @frag, @indexname
WHILE @@FETCH_STATUS = 0
BEGIN
   IF @frag >= @maxfrag
   BEGIN
    --Si se paso del 10% de fargmentacion, desfragmentalo
       PRINT 'Ejecutando DBCC INDEXDEFRAG (0, ' + RTRIM(@tablename) + ',
          ' + RTRIM(@indexid) + ') - fragmentation es del : '
           + RTRIM(CONVERT(VARCHAR(15),@frag)) + '%'
       SELECT @execstr = 'DBCC INDEXDEFRAG (0, ' + RTRIM(@objectid) + ',
           ' + RTRIM(@indexid) + ')'
       EXEC (@execstr)
   END
 
   --Reindexamos el indice
   PRINT 'Ejecutando DBCC DBREINDEX (''' + RTRIM(@tablename) + ''', '
      + RTRIM(@indexname) + ', 0)'
   SELECT @execstr = 'DBCC DBREINDEX (''' + RTRIM(@tablename) +  ''', '
        + RTRIM(@indexname) + ', 0 )'
   EXEC (@execstr)
 
   FETCH NEXT
      FROM indexes
      INTO @tablename, @objectid, @indexid, @frag, @indexname
END
-- Cierra y elimina el cursor.
CLOSE indexes
DEALLOCATE indexes
 
GO