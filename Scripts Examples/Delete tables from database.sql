----Elimina tablas
DECLARE @Sql NVARCHAR(500) DECLARE @Cursor CURSOR

SET @Cursor = CURSOR FAST_FORWARD FOR 
--Query to select and build DROP TABLE sentence
SELECT 
	'delete from  '+ FLD AS FIELD 
		FROM (	SELECT '['+TABLE_CATALOG+'].['+TABLE_SCHEMA+'].['+TABLE_NAME+']' AS FLD FROM INFORMATION_SCHEMA.TABLES
	WHERE TABLE_TYPE = 'BASE TABLE' 
	--AND tABLE_NAME LIKE '[_]%' 
	--AND tABLE_NAME LIKE 'xts%' 
	) AS TBL

OPEN

@Cursor FETCH NEXT FROM @Cursor INTO @Sql

PRINT 'THE FOLLOWING TABLES WERE DELETED:'
PRINT '---------------------------------'

WHILE
	(@@FETCH_STATUS = 0)
BEGIN
	Exec SP_EXECUTESQL @Sql
	PRINT '- ' + @Sql
FETCH NEXT FROM @Cursor INTO @Sql
END
CLOSE
@Cursor DEALLOCATE @Cursor


--go
----Elimina vistas

--DECLARE @Sql NVARCHAR(500) DECLARE @Cursor CURSOR

--SET @Cursor = CURSOR FAST_FORWARD FOR 
----Query to select and build DROP TABLE sentence
--SELECT 
--	'DROP view '+ FLD AS FIELD 
--		FROM (	SELECT '['+TABLE_SCHEMA+'].['+TABLE_NAME+']' AS FLD FROM INFORMATION_SCHEMA.TABLES
--	WHERE TABLE_TYPE = 'VIEW' 	
--	AND tABLE_NAME LIKE 'cstAg_FacturasConPeriodos_%' 
--	) AS TBL

--UNion

--SELECT 
--	'DROP view '+ FLD AS FIELD 
--		FROM (	SELECT '['+TABLE_SCHEMA+'].['+TABLE_NAME+']' AS FLD FROM INFORMATION_SCHEMA.TABLES
--	WHERE TABLE_TYPE = 'VIEW' 	
--	AND tABLE_NAME LIKE 'cstCom_EstadoCuenta_%' 
--	) AS TBL
--UNion

--SELECT 
--	'DROP view '+ FLD AS FIELD 
--		FROM (	SELECT '['+TABLE_SCHEMA+'].['+TABLE_NAME+']' AS FLD FROM INFORMATION_SCHEMA.TABLES
--	WHERE TABLE_TYPE = 'VIEW' 	
--	AND tABLE_NAME LIKE 'cstCOM_FacturaEncabezado_%' 
--	) AS TBL

--UNion

--SELECT 
--	'DROP view '+ FLD AS FIELD 
--		FROM (	SELECT '['+TABLE_SCHEMA+'].['+TABLE_NAME+']' AS FLD FROM INFORMATION_SCHEMA.TABLES
--	WHERE TABLE_TYPE = 'VIEW' 	
--	AND tABLE_NAME LIKE 'tmpCuentas_%' 
--	) AS TBL
--UNion

--SELECT 
--	'DROP view '+ FLD AS FIELD 
--		FROM (	SELECT '['+TABLE_SCHEMA+'].['+TABLE_NAME+']' AS FLD FROM INFORMATION_SCHEMA.TABLES
--	WHERE TABLE_TYPE = 'VIEW' 	
--	AND tABLE_NAME LIKE 'tmpPolizas_%' 
--	) AS TBL
--	UNion

--SELECT 
--	'DROP view '+ FLD AS FIELD 
--		FROM (	SELECT '['+TABLE_SCHEMA+'].['+TABLE_NAME+']' AS FLD FROM INFORMATION_SCHEMA.TABLES
--	WHERE TABLE_TYPE = 'VIEW' 	
--	AND tABLE_NAME LIKE '[_]%' 
--	) AS TBL
--	UNion

--SELECT 
--	'DROP view '+ FLD AS FIELD 
--		FROM (	SELECT '['+TABLE_SCHEMA+'].['+TABLE_NAME+']' AS FLD FROM INFORMATION_SCHEMA.TABLES
--	WHERE TABLE_TYPE = 'VIEW' 	
--	AND tABLE_NAME LIKE '2%' 
--	) AS TBL
--	UNion

--SELECT 
--	'DROP view '+ FLD AS FIELD 
--		FROM (	SELECT '['+TABLE_SCHEMA+'].['+TABLE_NAME+']' AS FLD FROM INFORMATION_SCHEMA.TABLES
--	WHERE TABLE_TYPE = 'VIEW' 	
--	AND tABLE_NAME LIKE 'cstCom_factura_%' 
--	) AS TBL
--	UNion

--SELECT 
--	'DROP view '+ FLD AS FIELD 
--		FROM (	SELECT '['+TABLE_SCHEMA+'].['+TABLE_NAME+']' AS FLD FROM INFORMATION_SCHEMA.TABLES
--	WHERE TABLE_TYPE = 'VIEW' 	
--	AND tABLE_NAME LIKE 'cstCom_CobranzaEstadisticoDeLaEmpresa%' 
--	) AS TBL
--	UNion

--SELECT 
--	'DROP view '+ FLD AS FIELD 
--		FROM (	SELECT '['+TABLE_SCHEMA+'].['+TABLE_NAME+']' AS FLD FROM INFORMATION_SCHEMA.TABLES
--	WHERE TABLE_TYPE = 'VIEW' 	
--	AND tABLE_NAME LIKE 'cstCom_AnticiposPorClienteEmpresa%' 
--	) AS TBL
--	UNion

--SELECT 
--	'DROP view '+ FLD AS FIELD 
--		FROM (	SELECT '['+TABLE_SCHEMA+'].['+TABLE_NAME+']' AS FLD FROM INFORMATION_SCHEMA.TABLES
--	WHERE TABLE_TYPE = 'VIEW' 	
--	AND tABLE_NAME LIKE 'cstCom_CobranzaSaldosDeLaEmpresa%' 
--	) AS TBL
--	UNion

--SELECT 
--	'DROP view '+ FLD AS FIELD 
--		FROM (	SELECT '['+TABLE_SCHEMA+'].['+TABLE_NAME+']' AS FLD FROM INFORMATION_SCHEMA.TABLES
--	WHERE TABLE_TYPE = 'VIEW' 	
--	AND tABLE_NAME LIKE 'cstCom_CobranzaFacturasDeLaEmpresa%' 
--	) AS TBL
--	UNion

--SELECT 
--	'DROP view '+ FLD AS FIELD 
--		FROM (	SELECT '['+TABLE_SCHEMA+'].['+TABLE_NAME+']' AS FLD FROM INFORMATION_SCHEMA.TABLES
--	WHERE TABLE_TYPE = 'VIEW' 	
--	AND tABLE_NAME LIKE 'cstCom_AnticiposDeLaEmpresa%' 
--	) AS TBL
--OPEN

--@Cursor FETCH NEXT FROM @Cursor INTO @Sql

--PRINT 'THE FOLLOWING TABLES WERE DELETED:'
--PRINT '---------------------------------'

--WHILE
--	(@@FETCH_STATUS = 0)
--BEGIN
--	Exec SP_EXECUTESQL @Sql
--	PRINT '- ' + @Sql
--FETCH NEXT FROM @Cursor INTO @Sql
--END
--CLOSE
--@Cursor DEALLOCATE @Cursor


--exec sp_refreshview 'cstCom_CobranzaEstadisticoDeLaEmpresa140'



--DECLARE @Sql NVARCHAR(500) DECLARE @Cursor CURSOR

--SET @Cursor = CURSOR FAST_FORWARD FOR 
----Query to select and build DROP TABLE sentence
--SELECT 
--	'exec sp_refreshview  '+ FLD AS FIELD 
--		FROM (	SELECT ''''+TABLE_NAME+'''' AS FLD,* FROM INFORMATION_SCHEMA.TABLES
--	WHERE TABLE_TYPE = 'VIEW' and TABLE_NAME like 'cst%' and not Table_Name in ('cstRm_ValeSalInventario','cstReporteadorCuentasPre') 	
--	) AS TBL
--	order by table_name	

--OPEN

--@Cursor FETCH NEXT FROM @Cursor INTO @Sql

--PRINT 'THE FOLLOWING TABLES WERE DELETED:'
--PRINT '---------------------------------'

--WHILE
--	(@@FETCH_STATUS = 0)
--BEGIN
--	Exec SP_EXECUTESQL @Sql
--	PRINT '- ' + @Sql
--FETCH NEXT FROM @Cursor INTO @Sql
--END
--CLOSE
--@Cursor DEALLOCATE @Cursor

--select * from cstCOM_FacturaEncabezado