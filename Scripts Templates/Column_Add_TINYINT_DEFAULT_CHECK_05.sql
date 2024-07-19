            <column_name, sysname, ThisColumn>  TINYINT  <nullability, NVARCHAR(16), NOT NULL>
                CONSTRAINT DF_<table_name, sysname, ThisTable>_<column_name, sysname, ThisColumn> DEFAULT (<default_constraint_value, TINYINT, 1>)
                CONSTRAINT CK_<table_name, sysname, ThisTable>_<column_name, sysname, ThisColumn> CHECK (<check_constraint_expr, NVARCHAR(MAX), ThisColumn IN (0, 1)>),

