

-- Declaro Variable
Declare @object_name as varchar(50)

-- Declaro Tabla Temporal
CREATE TABLE results
  (name varchar(50),
   filas integer,
   reserved varchar(50),
   data varchar(50),
   index_size varchar(50),
   Unused varchar(50))


/* Cursor_Tablas -Guarda en la tabla #result
 el resultado de la ejecución del sp_spaceused
sobre c/u de las tablas de usuario de la BD */

DECLARE Cursor_Tablas
Cursor For

Select  distinct(s.name + '.' + o.name)
      from sys.schemas s
INNER JOIN sys.objects o  
ON o.schema_id = s.schema_id
Where
      type = 'U'  --Tablas de usuario

OPEN Cursor_Tablas
Fetch Next From  Cursor_Tablas
Into @object_name

WHILE @@FETCH_STATUS = 0
 BEGIN
   Insert Into results
   EXEC sp_spaceused @object_name
   Fetch Next From cursor_tablas
   Into @object_name
 END;

Close Cursor_Tablas;
Deallocate Cursor_Tablas;

-- Se quita el "KB" de la tabla #result --
UPDATE
results
SET
reserved = LEFT(reserved,LEN(reserved)-3),
data = LEFT(data,LEN(data)-3),
index_size = LEFT(index_size,LEN(index_size)-3),
unused = LEFT(unused,LEN(unused)-3)

-- Se listan las tablas ordenadas descendentemente por la cantidad de registros --
SELECT
distinct(t.Name) AS 'Table',
reserved/1024 as '[Disco (MB)]',
data/1024 as '[Datos (MB)]',
case when (data/1024) = 0 then 0.00 else (((data/1024)*100)/(reserved/1024)) end as '[% Datos (MB)]',
index_size/1024 as '[Idx (MB)]',
case when (data/1024) = 0 then 0.00 else 100-(((data/1024)*100)/(reserved/1024)) end as '[% Index (MB)]',
filas AS  'Records'
FROM results as t
Inner Join sys.objects o
ON o.name =  t.name
Where
reserved is not null and
o.Type <> 'S' AND 
O.Type <> 'IT'     
order by
filas desc

--Eliminar la tabla temporal
Drop Table results
