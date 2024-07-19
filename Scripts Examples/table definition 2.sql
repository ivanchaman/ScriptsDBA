SELECT Table_Name,Column_Name,Data_Type = 
CASE Data_Type
WHEN 'int' THEN 'int'
			WHEN 'bit' THEN 'bool'
			WHEN 'binary' THEN 'byte'
			WHEN 'varbinary' THEN 'byte[]'
			WHEN 'char' THEN 'string'
			WHEN 'nchar' THEN 'string'
			WHEN 'bigint' THEN 'Int64'
			WHEN 'smallint' THEN 'Int16'
			WHEN 'tinyint' THEN 'byte'
			WHEN 'ntext' THEN 'string'
			WHEN 'varchar' THEN 'string'
			WHEN 'nvarchar' THEN 'string'
			WHEN 'text' THEN 'string'
			WHEN 'datetime' THEN 'DateTime'
			WHEN 'smalldatetime' THEN 'DateTime'
			WHEN 'decimal' THEN 'decimal'
			WHEN 'numeric' THEN 'decimal'
			WHEN 'smallmoney' THEN 'decimal'
			WHEN 'money' THEN 'decimal'
			WHEN 'real' THEN 'single'
			WHEN 'float' THEN 'double'
			WHEN 'sql_variant' THEN 'object'	
ELSE 'String'
END
FROM INFORMATION_SCHEMA.COLUMNS
WHERE 
TABLE_NAME='Personal'

        SELECT		
        C.Name Columna
        ,ST.Name Tipo
        ,STNativo.Name TipoNativo
        ,C.Length Longitud
        ,C.Prec Precision
        ,C.ColOrder Orden
        ,CASE IsNull(PKC.Columna,'NULA') when 'NULA' then 0 else 1 END PK
        ,C.IsNullable PermiteNulo
		,CASE ST.Name
			WHEN 'int' THEN 'int'
			WHEN 'bit' THEN 'bool'
			WHEN 'binary' THEN 'byte'
			WHEN 'varbinary' THEN 'byte[]'
			WHEN 'char' THEN 'string'
			WHEN 'nchar' THEN 'string'
			WHEN 'bigint' THEN 'Int64'
			WHEN 'smallint' THEN 'Int16'
			WHEN 'tinyint' THEN 'byte'
			WHEN 'ntext' THEN 'string'
			WHEN 'varchar' THEN 'string'
			WHEN 'nvarchar' THEN 'string'
			WHEN 'text' THEN 'string'
			WHEN 'datetime' THEN 'DateTime'
			WHEN 'smalldatetime' THEN 'DateTime'
			WHEN 'decimal' THEN 'decimal'
			WHEN 'numeric' THEN 'decimal'
			WHEN 'smallmoney' THEN 'decimal'
			WHEN 'money' THEN 'decimal'
			WHEN 'real' THEN 'single'
			WHEN 'float' THEN 'double'
			WHEN 'sql_variant' THEN 'object'									
		ELSE 'string'
		END TipoCSharp
        FROM syscolumns C
        INNER JOIN sysobjects O ON (C.id = O.id)
        INNER JOIN systypes ST ON (C.xtype = ST.xtype AND C.XUsertype = ST.xusertype)
        INNER JOIN systypes STNativo ON (C.xtype = STNativo.xtype  AND STNativo.Xtype = STNativo.xusertype)
        LEFT JOIN (
          Select c.name as Columna
          from   sysindexes i
          join   sysobjects o  ON i.id = o.id
          join   sysobjects pk ON i.name = pk.name
          AND pk.parent_obj = i.id
          AND pk.xtype = 'PK'
          join   sysindexkeys ik on i.id = ik.id
          and i.indid = ik.indid
          join   syscolumns c ON ik.id = c.id
          AND ik.colid = c.colid        
          where  o.name = 'Personal'

        ) PKC on PKC.Columna=C.Name
		
		WHERE O.name ='Personal'
        Order by C.ColOrder


		SELECT 	 
		C.Name Columna  
		,ST.Name Tipo 
		,STNativo.Name TipoNativo 
		,C.max_Length Longitud 
		,C.precision Prec 
		,C.column_id Orden 
		,CASE IsNull(PKC.Columna,'NULA') when 'NULA' then 0 else 1 END PK 
		,C.Is_Nullable PermiteNulo 
		,CASE ST.Name
			WHEN 'int' THEN 'int'
			WHEN 'bit' THEN 'bool'
			WHEN 'binary' THEN 'byte'
			WHEN 'varbinary' THEN 'byte[]'
			WHEN 'char' THEN 'string'
			WHEN 'nchar' THEN 'string'
			WHEN 'bigint' THEN 'Int64'
			WHEN 'smallint' THEN 'Int16'
			WHEN 'tinyint' THEN 'byte'
			WHEN 'ntext' THEN 'string'
			WHEN 'varchar' THEN 'string'
			WHEN 'nvarchar' THEN 'string'
			WHEN 'text' THEN 'string'
			WHEN 'datetime' THEN 'DateTime'
			WHEN 'smalldatetime' THEN 'DateTime'
			WHEN 'decimal' THEN 'decimal'
			WHEN 'numeric' THEN 'decimal'
			WHEN 'smallmoney' THEN 'decimal'
			WHEN 'money' THEN 'decimal'
			WHEN 'real' THEN 'single'
			WHEN 'float' THEN 'double'
			WHEN 'sql_variant' THEN 'object'									
		ELSE 'string'
		END TipoCSharp
		, replace(replace(isnull(CO.definition,'NULL'),'(',''),')','') ValorPrede
		FROM sys.columns C 
		INNER JOIN sys.objects O ON (C.object_id = O.object_id) 
		INNER JOIN sys.types ST ON (C.system_type_id = ST.system_type_id AND C.user_type_id = ST.user_type_id) 
		INNER JOIN sys.types STNativo ON (C.system_type_id = STNativo.system_type_id  AND STNativo.system_type_id = STNativo.user_type_id) 
		LEFT JOIN (		
		select c.name as Columna 
		from   sys.indexes i 
		join   sys.objects o  ON i.object_id = o.object_id 
		join   sys.objects pk ON i.name = pk.name AND pk.parent_object_id = i.object_id AND pk.type = 'PK' 
		join   sys.index_columns ik on i.object_id = ik.object_id and i.index_id = ik.index_id 
		join   sys.columns c ON ik.object_id = c.object_id AND ik.column_id = c.column_id where  o.name = 'Personal') 
		PKC on PKC.Columna=C.Name 
		Left join sys.default_constraints CO on (C.default_object_id = CO.object_id)
        
		WHERE O.name = 'Personal'