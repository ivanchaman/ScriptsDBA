
-------------------------------------------------------------------------------
-- Constraint_Add_Clustered_05.sql - Very careful way to add a Primary Key     
--                 backed by a clustered index.  Checks for an existing        
--                 clustered index that was created by a PRIMARY KEY or UNIQUE 
--                 constraint. Checks whether the column is already in use in  
--                 an existing index. Checks whether an existing Primary Key   
--                 is referenced by a Foreign Key.                             
--                                                                             
-- Note: In SSMS, press Ctrl-Shift-M to pop a dialog box for entering values.  
-------------------------------------------------------------------------------
-- Copyright 2010  Larry Leonard, Definitive Solutions Inc.                    
--                 http://www.DefinitiveSolutions.com                          
--                                                                             
-- Copying and distribution of this file, with or without modification, are    
-- permitted in any medium without royalty provided the copyright notice and   
-- this notice are preserved. This file is offered as-is without any warranty. 
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-- MUST be set as shown to support indexes on computed columns, indexed views. 
SET ANSI_NULLS ON                                 -- Deprecated: leave set ON. 
SET ANSI_PADDING ON                               -- Deprecated: leave set ON. 
SET ANSI_WARNINGS ON                              -- No trailing blanks saved. 
SET ARITHABORT ON                                 -- Math failure not ignored. 
SET CONCAT_NULL_YIELDS_NULL ON                    -- NULL plus string is NULL. 
SET NUMERIC_ROUNDABORT OFF                        -- Allows loss of precision. 
SET QUOTED_IDENTIFIER ON                          -- Allows reserved keywords. 

-- These aren't, strictly speaking, required, but are generally good practice. 
SET NOCOUNT ON                                    -- Minimize network traffic. 
SET ROWCOUNT 0                                    -- Reset in case it got set. 
SET XACT_ABORT ON                                 -- Make transactions behave. 

-- Don't pollute a system db, check version, and look for an open transaction. 
IF DB_ID() < 5                                                         RAISERROR('   $$$ YOU ARE ATTACHED TO A SYSTEM DB $$$',   20, 1) WITH NOWAIT, LOG
IF  9 > CAST(CAST(SERVERPROPERTY('ProductVersion') AS CHAR(2)) AS INT) RAISERROR('   $$$ REQUIRES SQL SERVER 2005 OR LATER $$$', 20, 1) WITH NOWAIT, LOG
IF @@TRANCOUNT <> 0                                                    RAISERROR('   $$$ OPEN TRANSACTION EXISTS $$$',           20, 1) WITH NOWAIT, LOG
-------------------------------------------------------------------------------

DECLARE @sIndexNameToDrop  sysname          SET @sIndexNameToDrop = ''
DECLARE @sSql              NVARCHAR(4000)   SET @sSql             = ''
DECLARE @sMsg              NVARCHAR(440)    SET @sMsg             = ''

-- Check for any existing clustered index that was created by a PRIMARY KEY 
-- or UNIQUE constraint.  Must use ALTER TABLE to remove these - can't use 
-- DROP INDEX on constraints. 
SELECT TOP(1) @sIndexNameToDrop = name
  FROM sys.indexes
 WHERE object_id = OBJECT_ID('<schema_name, sysname, dbo>.<table_name_prefix, sysname, tbl><table_name, sysname, ThisTable>')
   AND type_desc = 'CLUSTERED'
   AND (is_unique_constraint = 1 OR is_primary_key = 1)

IF ISNULL(@sIndexNameToDrop, '') != ''
BEGIN
    -- If there are foreign keys depending on any of the columns in this index, 
    -- we must abort, because we can't drop the index in that case.
    IF EXISTS (SELECT *
                 FROM sys.foreign_key_columns fkc
                WHERE fkc.referenced_object_id = OBJECT_ID('<table_name_prefix, sysname, tbl><table_name, sysname, ThisTable>')
                  AND fkc.referenced_column_id IN
                        (SELECT column_id
                           FROM sys.index_columns  ic
                          WHERE ic.object_id = fkc.referenced_object_id
                            AND ic.column_id = fkc.referenced_column_id))

    IF EXISTS (SELECT *
                 FROM sys.foreign_keys
                WHERE referenced_object_id = OBJECT_ID('<table_name_prefix, NVARCHAR(50), tbl><table_name, sysname, ThisTable>')
                  AND schema_id = SCHEMA_ID('<schema_name, sysname, dbo>')
                  AND type_desc = 'FOREIGN_KEY_CONSTRAINT')
    BEGIN
        RAISERROR('Table <schema_name, sysname, dbo>.<table_name_prefix, NVARCHAR(50), tbl><table_name, sysname, ThisTable> is depended upon by foreign key constraint(s)', 10, 1) WITH NOWAIT<with_log, sysname, , LOG>
        RAISERROR('Cannot drop constraint %s', 10, 1, @sIndexNameToDrop) WITH NOWAIT<with_log, sysname, , LOG>
    END
    ELSE
    BEGIN
        RAISERROR('Dropping existing PRIMARY KEY or UNIQUE constraint %s on table <schema_name, sysname, dbo>.<table_name_prefix, NVARCHAR(50), tbl><table_name, sysname, ThisTable>', 10, 1, @sIndexNameToDrop) WITH NOWAIT, LOG
        SET @sSql = 'ALTER TABLE <schema_name, sysname, dbo>.<table_name_prefix, NVARCHAR(50), tbl><table_name, sysname, ThisTable> DROP CONSTRAINT ' + @sIndexNameToDrop
        PRINT @sSql
        EXEC(@sSql)
    END
END

-- If we succeeded in dropping the , continue; else fail.
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_<table_name_prefix, sysname, tbl><table_name, sysname, ThisTable>_<column_name, sysname, ThisColumn>')
BEGIN
split this into two
    -- If there's a non-clustered index, or a clustered index that was created by 
    -- a CREATE INDEX (that is, not by PRIMARY KEY), and the column we are wanting to cluster is the *only* column 
    -- in the index, we want to drop it - *unless* it's a clustered one, and is 
    -- *only* on the column we are wanting to cluster.  Since we're only looking 
    -- at indexes with only one column, we don't have to check that the column is 
    -- not 'included'.
    SET @sIndexNameToDrop = ''

    SELECT TOP(1) @sIndexNameToDrop = si.name
      FROM sys.indexes                    si
      JOIN sys.index_columns              sic
        ON si.object_id  = sic.object_id
       AND si.index_id   = sic.index_id
      JOIN sys.columns                    sc
        ON sic.column_id = sc.column_id
       AND sic.object_id = sc.object_id
 WHERE si.object_id  = OBJECT_ID('<schema_name, sysname, dbo>.<table_name_prefix, sysname, tbl><table_name, sysname, ThisTable>')
       AND NOT (sc.name IN ('<column_name, sysname, Column>') AND si.type_desc = 'CLUSTERED')
       AND (si.is_unique_constraint = 0 AND si.is_primary_key = 0)
       AND 1 =
              (SELECT COUNT(*)
                 FROM sys.index_columns 
            WHERE object_id    = OBJECT_ID('<schema_name, sysname, dbo>.<table_name_prefix, sysname, tbl><table_name, sysname, ThisTable>')
                  AND index_id     = si.index_id
                  AND key_ordinal <> 0
                  AND column_id   <> 0)

    IF ISNULL(@sIndexNameToDrop, '') != ''
    BEGIN
        RAISERROR('Dropping existing index on table <schema_name, sysname, dbo>.<table_name_prefix, sysname, tbl><table_name, sysname, ThisTable>, column <column_name, sysname, Column>', 10, 1) WITH NOWAIT, LOG

        SET @sSql = 'DROP INDEX ' + @sIndexNameToDrop + ' ON <schema_name, sysname, dbo>.<table_name_prefix, sysname, tbl><table_name, sysname, ThisTable>'
        PRINT @sSql
        EXEC(@sSql)
    END

    -- Now add the clustered index.
    RAISERROR('Adding <set_as_primary_key, NVARCHAR, PRIMARY KEY> clustered index to <database_name, sysname, MyDB>''s <table_name_prefix, sysname, tbl><table_name, sysname, ThisTable> table', 10, 1) WITH NOWAIT, LOG

    ALTER TABLE <schema_name, sysname, dbo>.<table_name_prefix, sysname, tbl><table_name, sysname, ThisTable> WITH CHECK
      ADD CONSTRAINT PK_<table_name, sysname, ThisTable> <set_as_primary_key, NVARCHAR, PRIMARY KEY> CLUSTERED (<column_name, sysname, Column>)
     WITH (PAD_INDEX = ON, FILLFACTOR = <fill_factor, INT, 70>)
END


 