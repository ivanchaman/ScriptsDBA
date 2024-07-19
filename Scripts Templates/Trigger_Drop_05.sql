
IF EXISTS (SELECT * FROM sys.triggers WHERE name = 'TR_<table_name_prefix, NVARCHAR(50), tbl><table_name, sysname, ThisTable>_<trigger_type, NVARCHAR(3), IUD>_<trigger_purpose, NVARCHAR(50), ShortPhraseDescribingPurposeOfTrigger>')
BEGIN
    RAISERROR('Dropping trigger TR_<table_name_prefix, NVARCHAR(50), tbl><table_name, sysname, ThisTable>_<trigger_type, NVARCHAR(3), IUD>_<trigger_purpose, NVARCHAR(50), ShortPhraseDescribingPurposeOfTrigger>', 10, 1) WITH NOWAIT, LOG
    DROP TRIGGER TR_<table_name_prefix, NVARCHAR(50), tbl><table_name, sysname, ThisTable>_<trigger_type, NVARCHAR(3), IUD>_<trigger_purpose, NVARCHAR(50), ShortPhraseDescribingPurposeOfTrigger>
END


