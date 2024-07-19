set nocount on

declare @DbId smallint
set @DbId = db_id()

  select  db_name()                    as DatabaseName
       , object_name(ips.object_id)   as TableName
       , i.name                       as IndexName
       , ips.page_count                          as PageCount
       , ips.page_count * 8 / 1024               as IndexSizeMB
       , ips.fragment_count                      as FragCount
       , ips.avg_fragmentation_in_percent        as AvgFrag
       , ips.index_type_desc                     as IndexType
    from sys.dm_db_index_physical_stats( db_id(), NULL, NULL, NULL, NULL)   ips
    join sys.indexes                                                     i
      on ips.object_id = i.object_id
     and ips.index_id  = i.index_id
   where i.index_id    <> 0
     and ips.page_count > 0
	 and db_name() = 'GobiernoWeb2014'
order by FragCount desc