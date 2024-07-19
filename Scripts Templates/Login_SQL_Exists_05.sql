
IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = '<login_name, sysname, Bob>' AND type_desc = '<login_type_desc, NVARCHAR(60), SQL_LOGIN>')
BEGIN
    RAISERROR('Creating <login_type_desc, NVARCHAR(60), SQL_LOGIN> login <login_name, sysname, Bob> on database <database_name, sysname, MyDB>', 10, 1) WITH NOWAIT<with_log, sysname, , LOG>

    CREATE LOGIN [<login_name, sysname, Bob>]
      WITH PASSWORD    = '<password, NVARCHAR(40), 40 chars>',
      DEFAULT_DATABASE = <database_name, sysname, MyDB>
END

