
IF EXISTS (SELECT * FROM <database_name, sysname, MyDB>.sys.extended_properties
            WHERE class_desc IN ('DATABASE', 'OBJECT_OR_COLUMN', 'PARAMETER', 'SCHEMA',
                                 'DATABASE_PRINCIPAL', 'ASSEMBLY', 'TYPE', 'INDEX',
                                 'XML_SCHEMA_COLLECTION', 'MESSAGE_TYPE', 'SERVICE_CONTRACT',
                                 'SERVICE', 'REMOTE_SERVICE_BINDING', 'ROUTE', 'DATASPACE',
                                 'PARTITION_FUNCTION', 'DATABASE_FILE')
              AND major_id = OBJECT_ID(<table_name_prefix, NVARCHAR(50), tbl><table_name, sysname, ThisTable>))
              AND minor_id = INDEXPROPERTY (major_id, '<index_name, sysname, IX_>', 'IndexID'))
BEGIN

END

