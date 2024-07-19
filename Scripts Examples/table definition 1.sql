SELECT 'create table [' + so.NAME + '] (' + o.list + ')'
       + CASE
           WHEN tc.Constraint_Name IS NULL THEN ''
           ELSE 'ALTER TABLE ' + so.NAME + ' ADD CONSTRAINT '
                + tc.Constraint_Name + ' PRIMARY KEY ' + ' ('
                + LEFT(j.List, Len(j.List)-1) + ')'
         END
FROM   sysobjects so
       CROSS apply (SELECT '  [' + column_name + '] ' + data_type
                           + CASE data_type
                               WHEN 'sql_variant' THEN ''
                               WHEN 'text' THEN ''
                               WHEN 'ntext' THEN ''
                               WHEN 'xml' THEN ''
                               WHEN 'decimal' THEN '(' + Cast(numeric_precision AS VARCHAR)
                                                   + ', ' + Cast(numeric_scale AS VARCHAR) + ')'
                               ELSE COALESCE('('
                                             + CASE
                                                 WHEN character_maximum_length = -1 THEN 'MAX'
                                                 ELSE Cast(character_maximum_length AS VARCHAR)
                                               END
                                             + ')', '')
                             END
                           + ' '
                           + CASE
                               WHEN EXISTS (SELECT id
                                            FROM   syscolumns
                                            WHERE  Object_name(id) = so.NAME
                                                   AND NAME = column_name
                                                   AND Columnproperty(id, NAME, 'IsIdentity') = 1) THEN 'IDENTITY('
                                                                                                        + Cast(Ident_seed(so.NAME) AS VARCHAR) + ','
                                                                                                        + Cast(Ident_incr(so.NAME) AS VARCHAR) + ')'
                               ELSE ''
                             END
                           + ' ' + ( CASE
                                       WHEN IS_NULLABLE = 'No' THEN 'NOT '
                                       ELSE ''
                                     END ) + 'NULL ' + CASE
                                                         WHEN information_schema.columns.COLUMN_DEFAULT IS NOT NULL THEN 'DEFAULT '
                                                                                                                         + information_schema.columns.COLUMN_DEFAULT
                                                         ELSE ''
                                                       END + ', '
                    FROM   information_schema.columns
                    WHERE  table_name = so.NAME
                    ORDER  BY ordinal_position
                    FOR XML PATH('')) o (list)
       LEFT JOIN information_schema.table_constraints tc
              ON tc.Table_name = so.NAME
                 AND tc.Constraint_Type = 'PRIMARY KEY'
       CROSS apply (SELECT '[' + Column_Name + '], '
                    FROM   information_schema.key_column_usage kcu
                    WHERE  kcu.Constraint_Name = tc.Constraint_Name
                    ORDER  BY ORDINAL_POSITION
                    FOR XML PATH('')) j (list)
WHERE  xtype = 'U'
       AND NAME NOT IN ( 'dtproperties' ) 
