        <column_name, sysname, ThisColumn>  INT  <nullability, NVARCHAR(16), NOT NULL>
            CONSTRAINT DF_<table_name, sysname, ThisTable>_<column_name, sysname, ThisColumn> DEFAULT (<default_constraint_value, INT, 1>)
            CONSTRAINT FK_<table_name, sysname, ThisTable>_<other_table_name, sysname, OtherTable> FOREIGN KEY 
            REFERENCES <schema_name, sysname, dbo>.<table_name_prefix, NVARCHAR(50), tbl><other_table_name, sysname, OtherTable> (<other_column_name, sysname, OtherColumn>),


            Add extended property for foreign key?

