-- Obtengo una lista de SPs en la base de datos (SQL 2005 and 2008)
  SELECT p.name AS 'SP Name', p.create_date, p.modify_date      
  FROM sys.procedures AS p
  WHERE p.is_ms_shipped = 0
  ORDER BY p.name;


  -- Obtener una lista de SPs posiblemente no usados (SQL 2008 solamente)
  SELECT p.name AS 'SP Name'        
  FROM sys.procedures AS p
  WHERE p.is_ms_shipped = 0

  EXCEPT

  SELECT p.name AS 'SP Name'        -- Lista de SPs en la base actual
  FROM sys.procedures AS p          -- que están en el procedure cache
  INNER JOIN sys.dm_exec_procedure_stats AS qs
  ON p.object_id = qs.object_id
  WHERE p.is_ms_shipped = 0;

--Adicionalmente usted puede usar el siguiente query (solamente SQL Server 2008)
--para determinar las dependencias de un objeto.

SELECT referencing_schema_name, referencing_entity_name
FROM sys.dm_sql_referencing_entities ('Person.Address', 'OBJECT');