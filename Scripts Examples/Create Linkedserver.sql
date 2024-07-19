
--sp_droplinkedsrvlogin 'CUENCA',NULL

--// Ahora hace el DropServer
--sp_DropServer  'CUENCA'
sp_AddLinkedServer 'sql174','','SQLOLEDB','132.200.192.174'
-- Por último el ADDLink
sp_addlinkedsrvlogin 'sql174', 'false',null,'sia','p@ssw0rd'



USE [master]
GO

/****** Object:  LinkedServer [sql172]    Script Date: 03/12/2015 11:59:58 a.m. ******/
EXEC master.dbo.sp_addlinkedserver @server = N'sql172', @srvproduct=N'', @provider=N'SQLNCLI', @datasrc=N'132.200.192.172'
 /* For security reasons the linked server remote logins password is changed with ######## */
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N'sql172',@useself=N'False',@locallogin=NULL,@rmtuser='sa',@rmtpassword='p@ssw0rd'

GO

EXEC master.dbo.sp_serveroption @server=N'sql172', @optname=N'collation compatible', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'sql172', @optname=N'data access', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'sql172', @optname=N'dist', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'sql172', @optname=N'pub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'sql172', @optname=N'rpc', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'sql172', @optname=N'rpc out', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'sql172', @optname=N'sub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'sql172', @optname=N'connect timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'sql172', @optname=N'collation name', @optvalue=null
GO

EXEC master.dbo.sp_serveroption @server=N'sql172', @optname=N'lazy schema validation', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'sql172', @optname=N'query timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'sql172', @optname=N'use remote collation', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'sql172', @optname=N'remote proc transaction promotion', @optvalue=N'true'
GO


