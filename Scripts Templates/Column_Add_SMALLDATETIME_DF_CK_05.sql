
        <column_name, sysname, ThisColumn> SMALLDATETIME <nullability, NVARCHAR(16), NOT NULL>
            CONSTRAINT DF_<table_name, sysname, ThisTable>_<column_name, sysname, ThisColumn> DEFAULT (GETDATE(),
            CONSTRAINT CK_<table_name, sysname, ThisTable>_<column_name, sysname, ThisColumn> CHECK   (<check_constraint_expr, NVARCHAR(MAX), ThisColumn >= <date_start_GE, SMALLDATETIME, '2010-01-01 00:00:00'> AND ThisColumn <date_end_LT, SMALLDATETIME, '2010-01-01 00:00:00'>),

