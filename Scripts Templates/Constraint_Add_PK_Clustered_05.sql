
-------------------------------------------------------------------------------
-- Constraint_Add_PK_Clustered_05.sql - Very careful way to add a Primary Key     
--                 backed by a clustered index.  Checks for an existing        
--                 clustered index that was created by a PRIMARY KEY or UNIQUE 
--                 constraint. Checks whether the column is already in use in  
--                 an existing index.                                          
--                                                                             
-- Note: In SSMS, press Ctrl-Shift-M to pop a dialog box for entering values.  
-------------------------------------------------------------------------------
-- Copyright 2009  Larry Leonard, Definitive Solutions Inc.                    
--                 http://www.DefinitiveSolutions.com                          
--                                                                             
-- Copying and distribution of this file, with or without modification, are    
-- permitted in any medium without royalty provided the copyright notice and   
-- this notice are preserved. This file is offered as-is, without any warranty.
-------------------------------------------------------------------------------

DECLARE @sIndexNameToDrop  sysname
DECLARE @sSql              NVARCHAR(4000)
DECLARE @sMsg              NVARCHAR(440)

-- Check for any existing clustered index that was created by a PRIMARY KEY
-- or UNIQUE constraint.  Must use ALTER TABLE to remove these - can't use
-- DROP INDEX on constraints.

SET @sIndexNameToDrop = NULL

SELECT @sIndexNameToDrop = name
  FROM sys.indexes
 WHERE object_id = OBJECT_ID('<schema_name, sysname, dbo>.<table_name_prefix, sysname, tbl><table_name, sysname, ThisTable>')
   AND type_desc = 'CLUSTERED'
   AND (is_unique_constraint = 1 OR is_primary_key = 1)

IF @sIndexNameToDrop IS NOT NULL
BEGIN
    RAISERROR('Dropping existing PRIMARY KEY or UNIQUE constraint %s on table <table_name_prefix, sysname, tbl><table_name, sysname, ThisTable>', 10, 1, @sIndexNameToDrop ) WITH NOWAIT, LOG

    SET @sSql = 'ALTER TABLE <schema_name, sysname, dbo>.<table_name_prefix, sysname, tbl><table_name, sysname, ThisTable> DROP CONSTRAINT ' + @sIndexNameToDrop
    PRINT @sSql
    EXEC(@sSql)
END

-- If there's a non-clustered index, or a clustered index that was created by 
-- an ADD INDEX, and the column we are wanting to cluster is the *only* column 
-- in the index, we want to drop it - *unless* it's a clustered one, and is 
-- *only* on the column we are wanting to cluster.  Since we're only looking 
-- at indexes with only one column, we don't have to check that the column is 
-- not 'included'.

SET @sIndexNameToDrop = NULL

SELECT @sIndexNameToDrop = si.name
  FROM sys.indexes                    AS si
  JOIN sys.index_columns              AS sic
    ON si.object_id  = sic.object_id
   AND si.index_id   = sic.index_id
  JOIN sys.columns                    AS sc
    ON sic.column_id = sc.column_id
   AND sic.object_id = sc.object_id
 WHERE si.object_id  = OBJECT_ID('<schema_name, sysname, dbo>.<table_name_prefix, sysname, tbl><table_name, sysname, ThisTable>')
   AND NOT (sc.name IN ('<column_name, sysname, Column>') AND si.type_desc = 'CLUSTERED')
   AND (si.is_unique_constraint = 0 AND si.is_primary_key = 0)
   AND 1 =
          (SELECT COUNT(*)
             FROM sys.index_columns
            WHERE object_id    = OBJECT_ID('<schema_name, sysname, dbo>.<table_name_prefix, sysname, tbl><table_name, sysname, ThisTable>')
              AND key_ordinal <> 0
              AND column_id   <> 0)

IF @sIndexNameToDrop IS NOT NULL
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

            
            Add extended property?
            
