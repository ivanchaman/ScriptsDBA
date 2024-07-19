
IF NOT EXISTS (SELECT * FROM sys.types WHERE name = '<type_name, sysname, udtNoUnderscore>' AND is_user_defined = 1)
BEGIN
    RAISERROR('Creating user-defined type <type_name, sysname, udtNoUnderscore>.', 10, 1) WITH NOWAIT, LOG
    
    CREATE TYPE <schema_name, sysname, dbo>.<type_name, sysname, udtNoUnderscore>
      FROM <datatype, sysname, NVARCHAR(100)>) <nullability, NVARCHAR(50), NOT NULL> <default_type_value, NVARCHAR(50), ''>

END

