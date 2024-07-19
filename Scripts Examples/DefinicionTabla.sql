 SELECT C.Name Nombre ,ST.Name TipoDato ,STNativo.Name TipoNativo  ,C.max_Length Longitud  ,C.precision Precision  ,C.column_id Orden  ,CASE IsNull(PKC.Columna,'NULA') when 'NULA' then 0 else 1 END EsPk,C.Is_Nullable PermiteNulo  ,CASE ST.Name     WHEN 'int' THEN 'Int32'    WHEN 'bit' THEN 'Boolean'    WHEN 'binary' THEN 'Byte'    WHEN 'varbinary' THEN 'Byte[]'    WHEN 'image' THEN 'Byte[]'    WHEN 'char' THEN 'string'    WHEN 'nchar' THEN 'string'    WHEN 'bigint' THEN 'Int64'    WHEN 'smallint' THEN 'Int16'    WHEN 'tinyint' THEN 'Byte'    WHEN 'ntext' THEN 'string'    WHEN 'varchar' THEN 'string'    WHEN 'nvarchar' THEN 'string'    WHEN 'text' THEN 'string'    WHEN 'datetime' THEN 'DateTime'    WHEN 'date' THEN 'DateTime'    WHEN 'smalldatetime' THEN 'DateTime'    WHEN 'decimal' THEN 'Double'    WHEN 'numeric' THEN 'Double'    WHEN 'smallmoney' THEN 'Double'    WHEN 'money' THEN 'Double'    WHEN 'real' THEN 'Single'    WHEN 'float' THEN 'Double'    WHEN 'sql_variant' THEN 'object' ELSE 'string' END TipoCSharp , replace(replace(isnull(CO.definition,'NULL'),'(',''),')','') ValorPredeterminado 
 ,SEP.value Descripcion
 FROM sys.columns C     
 INNER JOIN sys.objects O ON (C.object_id = O.object_id)     
 INNER JOIN sys.types ST ON (C.system_type_id = ST.system_type_id AND C.user_type_id = ST.user_type_id)     
 INNER JOIN sys.types STNativo ON (C.system_type_id = STNativo.system_type_id  AND STNativo.system_type_id = STNativo.user_type_id)  
 LEFT JOIN (		 select c.name as Columna  from   sys.indexes i  
 join   sys.objects o  ON i.object_id = o.object_id  
 join   sys.objects pk ON i.name = pk.name AND pk.parent_object_id = i.object_id AND pk.type = 'PK'  
 join   sys.index_columns ik on i.object_id = ik.object_id and i.index_id = ik.index_id  
 join   sys.columns c ON ik.object_id = c.object_id AND ik.column_id = c.column_id where  o.name = 'personal')  PKC on PKC.Columna=C.Name  
 Left join sys.default_constraints CO on (C.object_id = CO.object_id) 
 left join  sys.extended_properties SEP on(C.object_id = SEP.major_id and  C.column_id = SEP.minor_id and SEP.name = 'MS_Description')
 WHERE O.name = 'personal'

-- select * from sys.extended_properties