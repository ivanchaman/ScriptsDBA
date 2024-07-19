USE <database_name, sysname, MyDB>

RAISERROR(N'Create temp table for sp_spaceused', 10, 1) WITH NOWAIT, LOG

IF OBJECT_ID(N'tempdb..#SpaceUsed') IS NOT NULL
BEGIN
    DROP TABLE #SpaceUsed
END

IF OBJECT_ID(N'tempdb..#SpaceUsed') IS NULL
BEGIN
    CREATE TABLE #SpaceUsed
    (
        TableName     VARCHAR(128),
        Rows          VARCHAR( 11),
        ReservedKB    VARCHAR( 18),
        DataSpaces    VARCHAR( 18),
        IndexesSpace  VARCHAR( 18),
        UnusedSpace   VARCHAR( 18)
    )
END

INSERT INTO #SpaceUsed
  EXEC sp_spaceused N'<schema_name, sysname, dbo>.<table_name_prefix, sysname, tbl><table_name, sysname, ThisTable>'

UPDATE #SpaceUsed
   SET ReservedKB = REPLACE(ReservedKB, N' KB', N'')

DECLARE @nTableSizeKB INT

SELECT @nTableSizeKB = CAST(ReservedKB AS INT)
  FROM #SpaceUsed

select * from #SpaceUsed    -- ??
 
IF OBJECT_ID(N'tempdb..#SpaceUsed') IS NOT NULL
BEGIN
    DROP TABLE #SpaceUsed
END
