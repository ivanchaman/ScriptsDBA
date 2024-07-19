-- LOG DE TRANSACCIONES ��

--VERIFICAR USO DEL LOG DE TRANSACCIONES ESPACIOS DISPONIBLES

DBCC SQLPERF( LOGSPACE )

--TRUNCAR EL LOG DE TRANSACCIONES EN SQL SERVER 2000 Y 2005

use DB

CHECKPOINT

GO

BACKUP LOG Exercise WITH
TRUNCATE_ONLY

DBCC SHRINKFILE('Exercise_log', 10) --Dejamos el archivo de log con un tama�o de 10 Mb

DBCC sqlperf(logspace)

 

--TRUNCAR EL LOG DE TRANSACCION EN SQL SERVER 2008�

USE DB;

GO

ALTER DATABASE AdventureWorks2008R2

SET RECOVERY SIMPLE;

GO

-- Deja el log en 1 MB.

DBCC SHRINKFILE(AdventureWorks2008R2_Log, 1);

GO

-- Regresar el modelo de recuperacion a FULL.

ALTER DATABASE DB

SET RECOVERY FULL;

GO

--


--A�ADIR ARCHIVOS LOG A UNA BASE DE DATOS

USE master;

GO

ALTER DATABASE DB

ADD LOG FILE

(

    NAME = DB_test1log2,

    FILENAME = 'RUTA\DB2log.ldf',

    SIZE = 5MB,

    MAXSIZE = 100MB,

    FILEGROWTH = 5MB

),

(

    NAME = DB_test1log3,

    FILENAME = 'RUTA\DB3log.ldf',

    SIZE = 5MB,

    MAXSIZE = 100MB,

    FILEGROWTH =
5MB

);

GO

 

 

--VERIFICAR EL ESTATUS DEL LOG DE TRANSACCIONES CUANDO ESTE LLENO

Select name as base_datos,
log_reuse_wait, log_reuse_wait_desc,

case
log_reuse_wait

when 0 then 'Hay actualmente uno o
m�s archivos de registro virtual reutilizables.'

when 1 then 'No se ha producido
ning�n punto de comprobaci�n desde el �LTIMO AVISO! para Ganar $$$$Se Buscan
Personas para Trabajar desde sus Casas por Internet � +Info�ltimo truncamiento
o el encabezado del registro no se ha movido m�s all� de un archivo de registro
virtual (todos los modelos de recuperaci�n). �ste es un motivo habitual para
retrasar el truncamiento.'

when 2 then 'Se necesita una copia
de seguridad del registro para hacer avanzar el encabezado del registro
(modelos de recuperaci�n completos o registrados de forma masiva s�lo). Cuando
se completa la copia de seguridad del registro, se avanza el encabezado del
registro y alg�n espacio del registro podr�a convertirse en reutilizable.'

when 3 then 'Existe una recuperaci�n
o copia de seguridad de datos en curso (todos los modelos de recuperaci�n).

La copia de seguridad
de datos funciona como una transacci�n activa y, cuando se ejecuta, la copia de
seguridad impide el truncamiento.'

when 4 then 'Podr�a existir una
transacci�n de larga duraci�n en el inicio de la copia de seguridad del
registro. En este caso, para liberar espacio se podr�a requerir otra copia de
seguridad del registro.

Se difiere una
transacci�n. Una transacci�n diferida es efectivamente una transacci�n activa
cuya reversi�n se bloquea debido a alg�n recurso no disponible.'

when 5 then 'Se realiza una pausa en
la creaci�n de reflejo de la base de datos o, en el modo de alto rendimiento,
la base de datos reflejada est� notablemente detr�s de la base de datos de la
entidad de seguridad (s�lo para el modelo de recuperaci�n completa).'

when 6 then 'Durante las
replicaciones transaccionales, las transacciones relevante para las
publicaciones no se han entregado a�n a la base de datos de distribuci�n (s�lo
para el modelo de recuperaci�n completa).'

when 7 then 'Se est� creando una
instant�nea de base de datos (todos los modelos de recuperaci�n). �ste es un
motivo habitual, por lo general breve, para retrasar el truncamiento del
registro.'

when 8 then 'Se est� produciendo un
recorrido del registro (todos los modelos de recuperaci�n). �ste es un motivo
habitual, por lo general breve, para retrasar el truncamiento del registro.'

when 9 then 'No se utiliza este
valor actualmente.'

end as columna,

recovery_model_desc as
modo_recuperacion_log, page_verify_option_desc as page_verify_bbdd,
user_access_desc as user_access,

state_desc as estado_bbdd from sys.databases