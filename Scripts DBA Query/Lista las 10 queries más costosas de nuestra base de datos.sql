 SELECT
TOP 10
SUBSTRING(qt.TEXT, (qs.statement_start_offset/2)+1,((CASE qs.statement_end_offset WHEN -1 THEN DATALENGTH(qt.TEXT)ELSE qs.statement_end_offset END - qs.statement_start_offset)/2)+1) as query,
qs.execution_count as 'cantidad de ejecuciones',
qs.total_logical_reads as 'total_lecturas_l�gicas',
qs.total_logical_writes as 'total_escrituras_l�gicas',
qs.total_worker_time 'total_CPU_consumida_ms',
qs.total_elapsed_time/1000000/60 'total_mts_consumidos_x_la_ejecuci�n',
qs.max_elapsed_time/1000000/60 'm�xima_tardanza_en_la_ejecuci�n_mts',
qp.query_plan 'link_plan_ejecucion'
FROM sys.dm_exec_query_stats qs
CROSS APPLY sys.dm_exec_sql_text(qs.sql_handle) qt
CROSS APPLY sys.dm_exec_query_plan(qs.plan_handle) qp

ORDER BY qs.last_elapsed_time DESC