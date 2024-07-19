            <column_name, sysname, ThisColumn>  SMALLDATETIME  <nullability, NVARCHAR(16), NOT NULL>
                CONSTRAINT DF_<table_name, sysname, ThisTable>_<column_name, sysname, ThisColumn> DEFAULT (<default_constraint_value, SMALLDATETIME, GETDATE()>),

