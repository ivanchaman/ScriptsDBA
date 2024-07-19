USE <database_name, sysname, Asset_Diag>


DECLARE @dtStart DATETIME
SET @dtStart = GETDATE()

UPDATE STATISTICS <schema_name, sysname, dbo>.<table_name, sysname, ThisTable>
                  <index_name, sysname, IX_> <with_full_scan, NVARCHAR(50), WITH FULLSCAN>                  

DECLARE @nSecs INT
SET @nSecs = DATEDIFF(second, @dtStart, GETDATE())
RAISERROR('%d seconds', 10, 1, @nSecs) WITH NOWAIT

