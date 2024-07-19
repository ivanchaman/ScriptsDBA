SELECT 
      spid,
      master.dbo.sysprocesses.status,
      hostname,
      program_name,
      cmd,
      cpu,
      physical_io,
      blocked,
      master.dbo.sysdatabases.name,
      loginame
FROM   
      master.dbo.sysprocesses INNER JOIN
      master.dbo.sysdatabases ON
            sys.sysprocesses.dbid = sys.sysdatabases.dbid