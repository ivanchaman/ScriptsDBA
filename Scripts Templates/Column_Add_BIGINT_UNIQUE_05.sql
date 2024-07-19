        <column_name, sysname, ThisColumn>  BIGINT  <nullability, NVARCHAR(16), NOT NULL>
            CONSTRAINT UQ_<table_name, sysname, ThisTable>_<column_name, sysname, ThisColumn>  UNIQUE  NONCLUSTERED
            WITH (PAD_INDEX = ON, FILLFACTOR = <fill_factor, INT, 70>),


                    Add extended property for index!
