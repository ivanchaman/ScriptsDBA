    -- Only 16 columns at a time.
    RAISERROR(N'Creating statistics on <table_name_prefix, sysname, tbl><table_name, sysname, ThisTable>', 10, 1) WITH NOWAIT

    CREATE STATISTICS <table_name_prefix, sysname, tbl><table_name, sysname, ThisTable>
        ON <schema_name, sysname, dbo>.<table_name_prefix, sysname, tbl><table_name, sysname, ThisTable>
           (<column_name1, sysname, column1>,
            <column_name2, sysname, column2>) 
      WITH FULLSCAN

    EXEC sp_autostats <table_name_prefix, sysname, tbl><table_name, sysname, ThisTable>, N'ON', <index_name, sysname, NULL>
