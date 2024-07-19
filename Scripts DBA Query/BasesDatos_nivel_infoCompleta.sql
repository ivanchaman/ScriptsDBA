EXECUTE master.sys.sp_MSforeachdb 'USE [?];
IF ''?'' NOT IN (''master'',''model'',''msdb'', ''tempdb'') 
BEGIN
exec sp_helpdb ?
END'
