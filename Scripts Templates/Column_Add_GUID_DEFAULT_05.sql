-- This is a galactically unique GUID (as long as the machine has a network card.)

        <column_name, sysname, ThisColumn>  UNIQUEIDENTIFIER  <nullability, NVARCHAR(16), NOT NULL>
            CONSTRAINT DF_<table_name, sysname, ThisTable>_<column_name, sysname, ThisColumn>  DEFAULT NEW<guid_is_sequential, NVARCHAR(16), SEQUENTIAL>ID(),


                Add extended property for default constraint!
