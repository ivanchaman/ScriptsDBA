select o.name                                as 'Table Name'
       , i.name                                as 'Index Name'
       , stats_date(i.object_id, i.index_id)   as 'Statistics Date'
       , s.auto_created
       , s.no_recompute
       , s.user_created
    from sys.objects   o
    join sys.indexes   i
      on o.object_id = i.object_id
    join sys.stats     s
      on i.object_id = s.object_id
     and i.index_id    = s.stats_id
   where o.type = 'U'
     and datediff(Day, stats_date(i.object_id, i.index_id), getdate()) > 7
order by [Statistics Date] desc
