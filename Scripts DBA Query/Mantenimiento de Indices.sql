 SELECT
b.name as 'database',
c.name as 'name',
index_type_desc,
avg_fragmentation_in_percent,
page_count
FROM sys.dm_db_index_physical_stats (9, NULL, NULL, NULL, 'limited')AS A
LEFT JOIN SYS.DATABASES B ON A.DATABASE_iD = B.DATABASE_ID
LEFT JOIN SYS.OBJECTS C ON A.OBJECT_iD = C.OBJECT_iD
WHERE avg_fragmentation_in_percent > 20 -- buscando % de fragmentaci�n en este caso > 20
and index_level = 0 --> analizando la rama principal de los �ndices
and page_count > 1000 --> mas de 1000 hojas

order by name