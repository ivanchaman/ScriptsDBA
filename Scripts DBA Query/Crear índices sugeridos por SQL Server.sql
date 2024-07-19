SELECT Db_name( mid.database_id )                                                                                          AS DatabaseID,
       CONVERT ( DECIMAL(28, 1), migs.avg_total_user_cost * migs.avg_user_impact * ( migs.user_seeks + migs.user_scans ) ) AS improvement_measure,
       'CREATE INDEX missing_index_'
       + CONVERT (VARCHAR, mig.index_group_handle)
       + '_' + CONVERT (VARCHAR, mid.index_handle)
       + ' ON ' + mid.statement + ' ('
       + Isnull(mid.equality_columns, '') + CASE WHEN mid.equality_columns IS NOT NULL AND mid.inequality_columns IS NOT NULL THEN ',' ELSE '' END
       + Isnull(mid.inequality_columns, '') + ')'
       + Isnull(' INCLUDE (' + mid.included_columns + ')', '')                                                             AS create_index_statement,
       migs.user_seeks,
       migs.user_scans,
       mig.index_group_handle,
       mid.index_handle,
       migs.*,
       mid.database_id,
       mid.[object_id]
FROM   sys.DM_DB_MISSING_INDEX_GROUPS mig
       INNER JOIN sys.DM_DB_MISSING_INDEX_GROUP_STATS migs
               ON migs.group_handle = mig.index_group_handle
       INNER JOIN sys.DM_DB_MISSING_INDEX_DETAILS mid
               ON mig.index_handle = mid.index_handle
WHERE  CONVERT ( DECIMAL(28, 1), migs.avg_total_user_cost * migs.avg_user_impact * ( migs.user_seeks + migs.user_scans ) ) > 10
ORDER  BY migs.avg_total_user_cost * migs.avg_user_impact * ( migs.user_seeks + migs.user_scans ) DESC;

DECLARE @threshold_table_rows    INT = 1000,--> solo me interesan aquellas con algunas filas
        @threshold_table_updates INT = 10000; --> a partir de estos cambios, se entiende que la tabla sufre muchas actualizaciones 

WITH subquery
     AS ( SELECT Db_name( mid.database_id )                                                                                          AS DatabaseID,
                 CONVERT ( DECIMAL(28, 1), migs.avg_total_user_cost * migs.avg_user_impact * ( migs.user_seeks + migs.user_scans ) ) AS improvement_measure,
                 'CREATE INDEX missing_index_'
                 + CONVERT (VARCHAR, mig.index_group_handle)
                 + '_' + CONVERT (VARCHAR, mid.index_handle)
                 + ' ON ' + mid.statement + ' ('
                 + Isnull(mid.equality_columns, '') + CASE WHEN mid.equality_columns IS NOT NULL AND mid.inequality_columns IS NOT NULL THEN ',' ELSE '' END
                 + Isnull(mid.inequality_columns, '') + ')'
                 + Isnull(' INCLUDE (' + mid.included_columns + ')', '')                                                             AS create_index_statement,
                 migs.user_seeks,
                 migs.user_scans,
                 Isnull( CONVERT ( INT, ( -- Multiple partitions could correspond to one index.
                                        SELECT Sum( rows )
                                          FROM   sys.PARTITIONS s_p
                                          WHERE  mid.object_id = s_p.object_id AND
                                                 s_p.index_id = 1 -- cluster index 
                                         ) ), 0 )                                                                                    AS estimated_table_rows,
                 sus.user_updates + sus.system_updates                                                                               AS rows_updated
          FROM   sys.DM_DB_MISSING_INDEX_GROUPS mig
                 INNER JOIN sys.DM_DB_MISSING_INDEX_GROUP_STATS migs
                         ON migs.group_handle = mig.index_group_handle
                 INNER JOIN sys.DM_DB_MISSING_INDEX_DETAILS mid
                         ON mig.index_handle = mid.index_handle
                 LEFT JOIN sys.DM_DB_INDEX_USAGE_STATS sus
                        ON sus.index_id = 1 --> quiero solo el indice clustered
                           AND
                           sus.object_id = mid.object_id AND
                           sus.database_id = mid.database_id
          WHERE  mid.database_id = Db_id( ) AND
                 CONVERT ( DECIMAL(28, 1), migs.avg_total_user_cost * migs.avg_user_impact * ( migs.user_seeks + migs.user_scans ) ) > 10 )
SELECT *
FROM   subquery
WHERE  SUBQUERY.rows_updated < @threshold_table_updates AND
       SUBQUERY.estimated_table_rows > @threshold_table_rows
ORDER  BY improvement_measure DESC; 
