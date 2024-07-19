
-----------------------------------------------------------------------------
-- Create trigger TR_<table_name_prefix, sysname, tbl><table_name, sysname, ThisTable>_<trigger_type, nvarchar(4), IUD>.
-----------------------------------------------------------------------------

USE <database_name, sysname, MyDB>
SET ANSI_NULLS ON

-- Drop any existing one.
IF EXISTS (SELECT * FROM sys.triggers
            WHERE name = 'TR_<table_name_prefix, sysname, tbl><table_name, sysname, ThisTable>_<trigger_type, nvarchar(4), IUD>'
              AND parent_id = OBJECT_ID('<table_name_prefix, sysname, tbl><table_name, sysname, ThisTable>'))
BEGIN
    RAISERROR('Dropping trigger TR_<table_name_prefix, sysname, tbl><table_name, sysname, ThisTable>_<trigger_type, nvarchar(4), IUD>', 10, 1) WITH NOWAIT, LOG
    DROP TRIGGER <schema_name, sysname, dbo>.TR_<table_name_prefix, sysname, tbl><table_name, sysname, ThisTable>_<trigger_type, nvarchar(4), IUD>
END

-- Guarantees idempotency.
IF EXISTS (SELECT * FROM sys.triggers
            WHERE name = 'TR_<table_name_prefix, sysname, tbl><table_name, sysname, ThisTable>_<trigger_type, nvarchar(4), IUD>'
              AND parent_id = OBJECT_ID('<table_name_prefix, sysname, tbl><table_name, sysname, ThisTable>'))
BEGIN
    RAISERROR('Trigger TR_<table_name_prefix, sysname, tbl><table_name, sysname, ThisTable>_<trigger_type, nvarchar(4), IUD> does exist - DROP TRIGGER failed', 16, 1) WITH NOWAIT, LOG
END

-- Create new one.
RAISERROR('Creating trigger TR_<table_name_prefix, sysname, tbl><table_name, sysname, ThisTable>_<trigger_type, nvarchar(4), IUD>', 10, 1) WITH NOWAIT, LOG
GO

CREATE TRIGGER <schema_name, sysname, dbo>.TR_<table_name_prefix, sysname, tbl><table_name, sysname, ThisTable>_<trigger_type, nvarchar(4), IUD>
    ON <schema_name, sysname, dbo>.<table_name_prefix, sysname, tbl><table_name, sysname, ThisTable> AFTER <trigger_after, nvarchar(50), INSERT, UPDATE, DELETE> AS
BEGIN
    SET NOCOUNT ON

    Trigger Code Goes Here!

END
GO

-- Only way to check if CREATE TRIGGER statement failed.
IF NOT EXISTS (SELECT * FROM sys.triggers
                WHERE name = 'TR_<table_name_prefix, sysname, tbl><table_name, sysname, ThisTable>_<trigger_type, nvarchar(4), IUD>'
                  AND parent_id = OBJECT_ID('<table_name_prefix, sysname, tbl><table_name, sysname, ThisTable>'))
BEGIN
    RAISERROR('   *** Failed to create trigger TR_<table_name_prefix, sysname, tbl><table_name, sysname, ThisTable>_<trigger_type, nvarchar(4), IUD>', 16, 1)
END

