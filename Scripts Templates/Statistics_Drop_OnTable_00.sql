    
    USE <database_name, sysname, MyDB>

    RAISERROR(N'Dropping statistics on <table_name_prefix, sysname, tbl><table_name, sysname, ThisTable>', 10, 1) WITH NOWAIT

    DECLARE @sStatisticsName sysname
    DECLARE @sCmdStatistics  NVARCHAR(400)

    WHILE EXISTS (SELECT *
                    FROM sysobjects
                    JOIN sysindexes
                      ON sysobjects.id   = sysindexes.id
                   WHERE sysobjects.name = N'<table_name_prefix, sysname, tbl><table_name, sysname, ThisTable>'
                     AND INDEXPROPERTY(sysobjects.id, sysindexes.name, N'IsStatistics') = 1)
    BEGIN
        SELECT @sStatisticsName = sysindexes.name
          FROM sysobjects
          JOIN sysindexes
            ON sysobjects.id   = sysindexes.id
         WHERE sysobjects.name = N'<table_name_prefix, sysname, tbl><table_name, sysname, ThisTable>'
           AND INDEXPROPERTY(sysobjects.id, sysindexes.name, N'IsStatistics') = 1

        SET @sCmdStatistics = N'DROP STATISTICS ' + N'<table_name_prefix, sysname, tbl><table_name, sysname, ThisTable>.' + @sStatisticsName

        PRINT @sCmdStatistics
        EXEC(@sCmdStatistics)
    END
