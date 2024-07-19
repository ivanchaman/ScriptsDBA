 -----------------------------------------------------------------------------
-- Detalle: Se listan lo objetos que se encuentran fragmentados
-- acorde a lo seteado en el wheare    
-- Detalle 2 (podemos hacer a nivel de Servidor/ Base de Datos / Tabla)                          
-- Autor: GH - Octubre 2013                                                                      
-- --------------------------------------------------------------------------


SELECT
db.name as 'Database',
o.name as 'Table',
case when I.name is null then 'Heap' else I.name end as 'Indice',
left(avg_fragmentation_in_percent,4) as '% frag'
--FROM sys.dm_db_index_physical_stats (NULL, NULL, NULL, NULL, NULL) AS a   
FROM sys.dm_db_index_physical_stats (DB_ID('NOMBRE BASE DE DATOS'), NULL, NULL, NULL, NULL) AS a  
--FROM sys.dm_db_index_physical_stats (DB_ID('NOMBRE BASE DE DATOS'), OBJECT_ID('NOMBRE DE TABLA'), NULL, NULL, NULL) AS a  
-- left para obtener nombre db --
LEFT JOIN Sys.Databases as DB    on A.Database_Id = DB.Database_Id
-- left para obtener nombre del idx --
LEFT JOIN sys.indexes AS I ON a.object_id = I.object_id AND a.index_id = I.index_id
-- left para obtener nombre tabla --
LEFT JOIN sys.objects as o on I.[object_id] = o.[object_id]
----------------
WHERE avg_fragmentation_in_percent > 20 -- % de fragmentación en este caso > 20
and index_level = 0 --> analizando la rama principal de los índices
and page_count > 1000 --> mas de 1000 hojas
order by o.name 