SELECT 
	CAMPOS.TABLE_NAME AS TABLA
	,CAMPOs.ORDINAL_POSITION as NroCampo
	,CAMPOS.COLUMN_NAME AS NOMBRE_CAMPO
	,ISNULL(CAMPOS.COLUMN_DEFAULT, N'') AS VALOR_X_DEFECTO
	,CAMPOS.DATA_TYPE AS TIPO_DATO
	,ISNULL( ISNULL(CAMPOS.CHARACTER_MAXIMUM_LENGTH,CAMPOS.NUMERIC_PRECISION),'') AS LONGITUD
	,ISNULL(CAMPOS.COLLATION_NAME,'') AS COLLATION 
	,ISNULL(ep.value,CAMPOS.COLUMN_NAME) AS DESCRIPCION 
	,IS_NULLABLE ESNULO
FROM 
	INFORMATION_SCHEMA.COLUMNS AS CAMPOS 
	inner JOIN sys.tables AS TABLAS ON TABLAS.name = CAMPOS.TABLE_NAME
	LEFT JOIN sys.extended_properties ep ON tablas.object_id = ep.major_id AND ep.minor_id = campos.ORDINAL_POSITION
WHERE (CAMPOS.TABLE_NAME NOT IN ('sysdiagrams')) and not CAMPOS.TABLE_NAME like '[_]%'
ORDER BY TABLA, CAMPOs.ORDINAL_POSITION

--C.Name Nombre ,ST.Name TipoDato ,STNativo.Name TipoNativo  ,C.max_Length Longitud  ,C.precision Precision  ,C.column_id Orden 
--                ,CASE IsNull(PKC.Columna,'NULA') when 'NULA' then 0 else 1 END EsPK  ,C.Is_Nullable PermiteNulo 
--                ,CASE ST.Name 
--                   WHEN 'int' THEN 'Int32'
--                   WHEN 'bit' THEN 'Boolean'
--                   WHEN 'binary' THEN 'Byte'
--                   WHEN 'varbinary' THEN 'Byte[]'
--                   WHEN 'image' THEN 'Byte[]'
--                   WHEN 'char' THEN 'string'
--                   WHEN 'nchar' THEN 'string'
--                   WHEN 'bigint' THEN 'Int64'
--                   WHEN 'smallint' THEN 'Int16'
--                   WHEN 'tinyint' THEN 'Byte'
--                   WHEN 'ntext' THEN 'string'
--                   WHEN 'varchar' THEN 'string'
--                   WHEN 'nvarchar' THEN 'string'
--                   WHEN 'text' THEN 'string'
--                   WHEN 'datetime' THEN 'DateTime'
--                   WHEN 'time' THEN 'DateTime'
--                   WHEN 'datetime2' THEN 'DateTime'
--                   WHEN 'datetimeoffset' THEN 'DateTimeOffset'               
--                   WHEN 'smalldatetime' THEN 'DateTime'
--                   WHEN 'decimal' THEN 'Double'
--                   WHEN 'numeric' THEN 'Double'
--                   WHEN 'smallmoney' THEN 'Double'
--                   WHEN 'money' THEN 'Double'
--                   WHEN 'real' THEN 'Single'
--                   WHEN 'float' THEN 'Double'
--                   WHEN 'sql_variant' THEN 'object'
--                ELSE 'string'
--                END TipoCSharp
--                ,CASE ST.Name 
--                   WHEN 'datetime' THEN 1
--                   WHEN 'time' THEN 1
--                   WHEN 'datetime2' THEN 1
--                   WHEN 'datetimeoffset' THEN 1
--                   WHEN 'smalldatetime' THEN 0
--                ELSE 0
--                END IncluyeHoras
--                , replace(replace(isnull(CO.definition,'NULL'),'(',''),')','') ValorPredeterminado ,SEP.value Descripcion
--                 ,C.is_identity EsIdentity
--				 ,CASE IsNull(PKC.Columna,'NULA') when 'NULA' then 'NO' else 'SI' END EsPK

				SELECT  
					CASE IsNull(PKC.Columna,'NULA') when 'NULA' then 'NO' else 'SI' END EsPK
					,o.name Tabla
					,z.name Propietario
					,C.Name Columna 
					,ST.Name TipoDato 
					,C.max_Length Longitud  
					,C.precision Precision  
					,C.column_id Orden 
					,C.is_identity EsIdentity
				,isnull(SEP.value,'') Descripcion
                FROM sys.columns C                
                   INNER JOIN sys.objects O ON (C.object_id = O.object_id) 
                   INNER JOIN sys.types ST ON (C.system_type_id = ST.system_type_id AND C.user_type_id = ST.user_type_id)                    
					LEFT JOIN (		
					select o1.name, c1.name as Columna 
					from   sys.indexes i1 
					join   sys.objects o1  ON i1.object_id = o1.object_id 
					join   sys.objects pk1 ON i1.name = pk1.name AND pk1.parent_object_id = i1.object_id AND pk1.type = 'PK' 
					join   sys.index_columns ik on i1.object_id = ik.object_id and i1.index_id = ik.index_id 
					join   sys.columns c1 ON ik.object_id = c1.object_id AND ik.column_id = c1.column_id INNER JOIN sys.schemas z ON o1.schema_id = Z.schema_id 	
					--where  o1.name = o.name and z.name = 'dbo'
					) PKC on PKC.Columna=C.Name and pkc.name = o.name
                left join  sys.extended_properties SEP on(C.object_id = SEP.major_id and  C.column_id = SEP.minor_id and SEP.name = 'MS_Description')
                INNER JOIN sys.schemas z ON o.schema_id = Z.schema_id 

               WHERE o.type = 'U' and not o.name like '[_]%' --O.name = '{0}' and z.name = 'dbo' 
			   order by o.name,  c.column_id 


			   