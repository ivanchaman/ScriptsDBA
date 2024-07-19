use DatabaseName

-- SOLAMENTE LISTA EN DONDE TIENE EL RESPALDO DIRIGIDO SUS ARCHIVOS
RESTORE FILELISTONLY  FROM DISK = 'Path\DatabaseName.bak'

RESTORE DATABASE TestDB 
   FROM DISK = 'Path\DatabaseName.bak'
   With
   MOVE 'DatabaseName_Data' TO 'path\DatabaseName.mdf',
   MOVE 'DatabaseName_Log' TO 'payh\DatabaseName.ldf'
