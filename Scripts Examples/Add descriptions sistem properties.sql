
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Empresa' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Personal', @level2type=N'COLUMN',@level2name=N'PerD000'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Num. Empleado' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Personal', @level2type=N'COLUMN',@level2name=N'PerD001'
GO

EXEC sys.sp_updateextendedproperty  @name=N'MS_Description', @value=N'Estatus' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Personal', @level2type=N'COLUMN',@level2name=N'PerD015'

EXEC sys.sp_updateextendedproperty  @name=N'MS_Description', @value=N'Desconocido' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Personal', @level2type=N'COLUMN',@level2name=N'PerD016'


 SELECT  C.name,SEP.value 
 FROM sys.columns C     
 INNER JOIN sys.objects O ON (C.object_id = O.object_id)     
 INNER JOIN sys.types ST ON (C.system_type_id = ST.system_type_id AND C.user_type_id = ST.user_type_id)     
 left join  sys.extended_properties SEP on(C.object_id = SEP.major_id and  C.column_id = SEP.minor_id and SEP.name = 'MS_Description') 
 WHERE O.name = 'Personal' and C.name = 'PerD015'



select 
        st.name [Table],
        sc.name [Column],
        sep.value [Description]
    from sys.tables st
    inner join sys.columns sc on st.object_id = sc.object_id
    left join sys.extended_properties sep on st.object_id = sep.major_id
                                         and sc.column_id = sep.minor_id
                                         and sep.name = 'MS_Description'
	  where st.name = 'Personal'
    and sc.name = 'PerD015'


	SELECT objtype, objname, name, value FROM fn_listextendedproperty (NULL, 'schema', 'dbo', 'table', 'Personal', 'column', 'PerD015');


	if not Exists(SELECT objtype, objname, name, value FROM fn_listextendedproperty (NULL, 'schema', 'dbo', 'table', 'Personal', 'column', 'PerD015'))
begin 
	EXEC sys.sp_addextendedproperty 
		@name=N'MS_Description', 
		@value=N'Empresa' , 
		@level0type=N'SCHEMA',
		@level0name=N'dbo', 
		@level1type=N'TABLE',
		@level1name=N'Personal',		
		@level2type=N'COLUMN',
		@level2name=N'PerD000'
	end
else
begin
	EXEC sys.sp_updateextendedproperty  
	@name=N'MS_Description', 
	@value=N'Estatus' , 
	@level0type=N'SCHEMA',
	@level0name=N'dbo', 
	@level1type=N'TABLE',
	@level1name=N'Personal', @level2type=N'COLUMN',@level2name=N'PerD015'

end