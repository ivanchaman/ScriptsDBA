        <column_name, sysname, ThisColumn> AS <computed_column_expression, NVARCHAR(MAX), 'col1 + col2'> PERSISTED <nullability, NVARCHAR(50), NOT NULL>
            CONSTRAINT CK_<table_name, sysname, ThisTable>_<column_name, sysname, ThisColumn> CHECK (<check_constraint_expr, NVARCHAR(MAX), ThisColumn IN (0, 1)>),


            Add extended property for check constraint?
