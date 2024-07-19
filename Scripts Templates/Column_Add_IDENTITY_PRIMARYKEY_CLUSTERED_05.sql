        <table_name, sysname, ThisTable>Index        INT IDENTITY (1, 1)    NOT NULL
        CONSTRAINT PK_<table_name_prefix, NVARCHAR(50), tbl><table_name, sysname, ThisTable>
        PRIMARY KEY CLUSTERED (<table_name, sysname, ThisTable>Index) WITH FILLFACTOR = <fill_factor, INT, 70>,
