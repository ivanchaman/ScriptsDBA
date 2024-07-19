/***********************************************************************
** Script  : DocSQL
** Author  : Carlos Eduardo Abramo Pinto - DBACorp Brasil
** Revised : Ken Hui  van.dba@gmail.com
** Rev Date: 09/11/2006
** E-mail  : ceapinto@hotmail.com
** Date    : 22/04/2003
** Function: create SQL server HTML documentation
** Version : 1.10
************************************************************************/

/************************************************************************
Revise note: 
1. reformat the result into HTML page.
2. added script to find sql server service account, sqlserver agent account.
3. added script to find sql server authentication mode.
4. added script to find sql server startup parameters
5. added table of contents and hyperlinks.
6. add DOS batch script to run the script on all servers. 
	HOW TO CREATE DOS BAT FILE:
	Edit following lines accroding to your environment, 
	Save these lines into bat file and run it from dos window.
	
	FOR %%a in (
	server01, server02, .....
	) DO OSQL -S %%a -E -i"H:\Scripts\maintenance\full server documentation - rev1.1.sql" -o"H:\SQL Server Analysis Report\SQL Server Configuration Report\%%a.html" -x300000 -w2000 -n

TRY IT ! It really works. You will get detailed documentation of all your sql servers in just minutes.
*******************************************************************************************************/
set nocount on
set dateformat dmy

use master
go


print '<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
 <html>
 <head>
 <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
 <title>SQL Server Full Documentation</title>
 <meta name="Generator" content="TextPad 4.7.3" />
 <meta http-equiv="Content-Style-Type" content="text/css" />
 <style type="text/css">
 .TPtext { color: #000000; background-color: #F3F3F3; }
 </style>
 </head>

 <body class="TPtext">
 <pre>


	  **********************************************************************************************



	   <STRONG><FONT SIZE="4">
 				<FONT SIZE="5"><A HREF="#TOP">SQL SERVER FULL DOCUMENTATION</A></FONT>

 						

 						  BY <A HREF="mailto:VAN.DBA@GMAIL.com?SUBJECT=FEEDBACK">YOUR NAME</A>





'
Print '                                   DATE: ' + convert(varchar(12),getdate(),113) + '


	   </FONT></STRONG>
 			     <B><FONT SIZE="7">YOUR COMPANY NAME HERE</FONT></B>


	  **********************************************************************************************



<A NAME="TOP"></A>

 	  **********************************************************************************************



 			                    <FONT SIZE="5"><B>TABLE OF CONTENTS</B></FONT>
                        <FONT SIZE="4">
 			<A HREF="#1">1. General Info</A>
 				<A HREF="#1.1">1.1  Database and Operational System versions.</A>
 				<A HREF="#1.2">1.2  Miscelaneous</A>
 			<A HREF="#2">2. Server Parameters</A>
 			<A HREF="#3">3. Databases parameters</A>
 			<A HREF="#4">4. LOG utilization</A>
 			<A HREF="#5">5. Datafiles list</A>
 			<A HREF="#6">6. IO per datafile</A>
 			<A HREF="#7">7. List of last backup full </A>
 			<A HREF="#8">8. List of logins</A>
 			<A HREF="#9">9. List of users per role</A>
 			<A HREF="#10">10.List of special users per database </A>
 			<A HREF="#11">11. Information about remote servers </A>
 			<A HREF="#12">12. List of jobs</A>
 			<A HREF="#13">13. Cache Hit Ratio</A>
                        </FONT>




 	  **********************************************************************************************



'

print ''
print '<A Name="1"></A> <B>1. General Info</B>'
print '*********************'
print ''


SET NOCOUNT ON 

IF EXISTS (SELECT [id] FROM tempdb..sysobjects WHERE [id] = OBJECT_ID ('tempdb..#reg'))
DROP TABLE #reg


CREATE TABLE #reg (keyname char(20), value varchar(100))

--print 'MSSQLSERVER Service Account'
INSERT INTO #reg 
EXEC master..xp_regread 'HKEY_LOCAL_MACHINE' ,'SYSTEM\CurrentControlSet\Services\MSSQLSERVER','ObjectName'
UPDATE #reg SET keyname = 'MSSQLSERVER'

--print 'SQLSERVERAGENT Service Account'
INSERT INTO #reg
EXEC master..xp_regread 'HKEY_LOCAL_MACHINE' ,'SYSTEM\CurrentControlSet\Services\SQLSERVERAGENT','ObjectName'
UPDATE #reg SET keyname = 'SQLSERVERAGENT' WHERE keyname = 'ObjectName'

--print 'SQL server authentication mode'
INSERT INTO #reg
EXEC master..xp_regread N'HKEY_LOCAL_MACHINE',N'Software\Microsoft\MSSQLServer\MSSQLServer',N'LoginMode'

--print 'SQL Server Startup Parameters'
INSERT INTO #reg
EXEC master..xp_regread N'HKEY_LOCAL_MACHINE',N'Software\Microsoft\MSSQLServer\MSSQLServer\PARAMETERS',N'SQLArg0'

INSERT INTO #reg
EXEC master..xp_regread N'HKEY_LOCAL_MACHINE',N'Software\Microsoft\MSSQLServer\MSSQLServer\PARAMETERS',N'SQLArg1'

INSERT INTO #reg
EXEC master..xp_regread N'HKEY_LOCAL_MACHINE',N'Software\Microsoft\MSSQLServer\MSSQLServer\PARAMETERS',N'SQLArg2'

INSERT INTO #reg
EXEC master..xp_regread N'HKEY_LOCAL_MACHINE',N'Software\Microsoft\MSSQLServer\MSSQLServer\PARAMETERS',N'SQLArg3'

INSERT INTO #reg
EXEC master..xp_regread N'HKEY_LOCAL_MACHINE',N'Software\Microsoft\MSSQLServer\MSSQLServer\PARAMETERS',N'SQLArg4'

INSERT INTO #reg
EXEC master..xp_regread N'HKEY_LOCAL_MACHINE',N'Software\Microsoft\MSSQLServer\MSSQLServer\PARAMETERS',N'SQLArg5'

DECLARE @SQLSVRACC varchar(30), 
	@SQLAGTACC varchar(30),
	@LOGINMODE varchar(30),
	@STARTPARA0 varchar(100),
	@STARTPARA1 varchar(100),
	@STARTPARA2 varchar(100),
	@STARTPARA3 varchar(100),
	@STARTPARA4 varchar(100),
	@STARTPARA5 varchar(100)


select @SQLSVRACC = value from #reg where keyname = 'MSSQLSERVER'
select @SQLAGTACC = value from #reg where keyname = 'SQLSERVERAGENT'
select @LOGINMODE = case value
			when 1 then 'Windows Authentication Mode'
			when 2 then 'Mixed Mode'
	    	    end
from #reg 
where keyname = 'LOGINMODE'

select @STARTPARA0 = value from #reg where keyname = 'SQLARG0'
select @STARTPARA1 = value from #reg where keyname = 'SQLARG1'
select @STARTPARA2 = value from #reg where keyname = 'SQLARG2'
select @STARTPARA3 = value from #reg where keyname = 'SQLARG3'
select @STARTPARA4 = value from #reg where keyname = 'SQLARG4'
select @STARTPARA5 = value from #reg where keyname = 'SQLARG5'

print 'Server Name............................: ' + convert(varchar(30),@@SERVERNAME)        
print 'Instance...............................: ' + convert(varchar(30),@@SERVICENAME)       
print 'Current Date Time......................: ' + convert(varchar(30),getdate(),113)
print 'User...................................: ' + USER_NAME()
print 'MSSQLSERVER Service account............: ' + @SQLSVRACC
print 'SQLSERVERAGENT Service account.........: ' + @SQLAGTACC
print 'Server Authentication Mode.............: ' + @LOGINMODE
print 'MSSQL Server Startup Parameters........: ' + @STARTPARA0
print '                                         ' + @STARTPARA1
print '                                         ' + @STARTPARA2
print '                                         ' + @STARTPARA3
print '                                         ' + @STARTPARA4
print '                                         ' + @STARTPARA5
print '<A HREF="#TOP"><TOP></A>'
DROP TABLE #reg

go

print ''
print '<A Name="1.1"></A><B>1.1  Database and Operational System versions.</B>'
print '----------------------------------------------'
print ''

select @@version
go

exec master..xp_msver
print '<A HREF="#TOP"><TOP></A>'
go


print ''
print '<A Name="1.2"></A><B>1.2  Miscelaneous</B>'
print '---------------------------'
print ''

print 'Number of connections..: ' + convert(varchar(30),@@connections)        
print 'Language...............: ' + convert(varchar(30),@@language)          
print 'Language Id............: ' + convert(varchar(30),@@langid)            
print 'Lock Timeout...........: ' + convert(varchar(30),@@LOCK_TIMEOUT)      
print 'Maximum of connections.: ' + convert(varchar(30),@@MAX_CONNECTIONS)   
print 'Server Name............: ' + convert(varchar(30),@@SERVERNAME)        
print 'Instance...............: ' + convert(varchar(30),@@SERVICENAME)       
print ''
print 'CPU Busy...........: ' + convert(varchar(30),@@CPU_BUSY/1000)        
print 'CPU Idle...........: ' + convert(varchar(30),@@IDLE/1000)
print 'IO Busy............: ' + convert(varchar(30),@@IO_BUSY/1000)
print 'Packets received...: ' + convert(varchar(30),@@PACK_RECEIVED)
print 'Packets sent.......: ' + convert(varchar(30),@@PACK_SENT)
print 'Packets w errors...: ' + convert(varchar(30),@@PACKET_ERRORS)
print 'TimeTicks..........: ' + convert(varchar(30),@@TIMETICKS)
print 'IO Errors..........: ' + convert(varchar(30),@@TOTAL_ERRORS)
print 'Total Read.........: ' + convert(varchar(30),@@TOTAL_READ)
print 'Total Write.........: ' + convert(varchar(30),@@TOTAL_WRITE)
print '<A HREF="#TOP"><TOP></A>'
go

----------------------------------------------------------------------------------------------------------
print ''
print '<A Name="2"></A><B>2. Server Parameters</B>'
print '*************************'
print ''

--exec sp_configure 'show advanced options',1
exec sp_configure
print '<A HREF="#TOP"><TOP></A>'
go
----------------------------------------------------------------------------------------------------------
print ''
print '<A Name="3"></A><B>3. Databases parameters</B>'
print '***************************'
print ''

exec sp_helpdb
go

SELECT LEFT(name,30) AS DB, 
        SUBSTRING(CASE status & 1 WHEN 0 THEN '' ELSE ',autoclose' END + 
        CASE status & 4 WHEN 0 THEN '' ELSE ',select into/bulk copy' END + 
        CASE status & 8 WHEN 0 THEN '' ELSE ',trunc. log on chkpt' END + 
        CASE status & 16 WHEN 0 THEN '' ELSE ',torn page detection' END + 
        CASE status & 32 WHEN 0 THEN '' ELSE ',loading' END + 
        CASE status & 64 WHEN 0 THEN '' ELSE ',pre-recovery' END + 
        CASE status & 128 WHEN 0 THEN '' ELSE ',recovering' END + 
        CASE status & 256 WHEN 0 THEN '' ELSE ',not recovered' END + 
        CASE status & 512 WHEN 0 THEN '' ELSE ',offline' END + 
        CASE status & 1024 WHEN 0 THEN '' ELSE ',read only' END + 
        CASE status & 2048 WHEN 0 THEN '' ELSE ',dbo USE only' END + 
        CASE status & 4096 WHEN 0 THEN '' ELSE ',single user' END + 
        CASE status & 32768 WHEN 0 THEN '' ELSE ',emergency mode' END + 
        CASE status & 4194304 WHEN 0 THEN '' ELSE ',autoshrink' END + 
        CASE status & 1073741824 WHEN 0 THEN '' ELSE ',cleanly shutdown' END + 
        CASE status2 & 16384 WHEN 0 THEN '' ELSE ',ANSI NULL default' END + 
        CASE status2 & 65536 WHEN 0 THEN '' ELSE ',concat NULL yields NULL' END + 
        CASE status2 & 131072 WHEN 0 THEN '' ELSE ',recursive triggers' END + 
        CASE status2 & 1048576 WHEN 0 THEN '' ELSE ',default TO local cursor' END + 
        CASE status2 & 8388608 WHEN 0 THEN '' ELSE ',quoted identifier' END + 
        CASE status2 & 33554432 WHEN 0 THEN '' ELSE ',cursor CLOSE on commit' END + 
        CASE status2 & 67108864 WHEN 0 THEN '' ELSE ',ANSI NULLs' END + 
        CASE status2 & 268435456 WHEN 0 THEN '' ELSE ',ANSI warnings' END + 
        CASE status2 & 536870912 WHEN 0 THEN '' ELSE ',full text enabled' END, 
2,8000) AS Descr 
FROM master..sysdatabases 
print '<A HREF="#TOP"><TOP></A>'
go
----------------------------------------------------------------------------------------------------------
print ''
print '<A Name="4"></A><B>4. LOG utilization</B>'
print '****************************'
print ''

DBCC sqlperf(logspace)
print '<A HREF="#TOP"><TOP></A>'
go
----------------------------------------------------------------------------------------------------------
print ''
print '<A Name="5"></A>5. Datafiles list'
print '***********************'
print ''

if exists (select [id] from tempdb..sysobjects where [id] = OBJECT_ID ('tempdb..#TempForFileStats '))
DROP TABLE #TempForFileStats 

if exists (select [id] from tempdb..sysobjects where [id] = OBJECT_ID ('tempdb..#TempForDataFile'))
DROP TABLE #TempForDataFile

if exists (select [id] from tempdb..sysobjects where [id] = OBJECT_ID ('tempdb..#TempForLogFile'))
DROP TABLE #TempForLogFile

DECLARE @DBName nvarchar(20)
DECLARE @SQLString nvarchar (2000)
DECLARE c_db CURSOR FOR
    SELECT name
    FROM master.dbo.sysdatabases
    WHERE status&512 = 0 

CREATE TABLE #TempForFileStats([Server Name]          nvarchar(40),
                               [Database Name]        nvarchar(20),
                               [File Name]            nvarchar(128),
                               [Usage Type]           varchar (6),
                               [Size (MB)]            real, 
                               [Space Used (MB)]      real,
                               [MaxSize (MB)]         real,
                               [Next Allocation (MB)] real, 
                               [Growth Type]          varchar (12),
                               [File Id]              smallint,
                               [Group Id]             smallint,
                               [Physical File]        nvarchar (260),
                               [Date Checked]         datetime) 

CREATE TABLE #TempForDataFile ([File Id]             smallint,
                               [Group Id]            smallint,
                               [Total Extents]       int,
                               [Used Extents]        int,
                               [File Name]           nvarchar(128),
                               [Physical File]       nvarchar(260))

CREATE TABLE #TempForLogFile  ([File Id]             int, 
                               [Size (Bytes)]        real, 
                               [Start Offset]        varchar(30), 
                               [FSeqNo]              int, 
                               [Status]              int, 
                               [Parity]              smallint, 
                               [CreateTime]          varchar(20))   

OPEN c_db
FETCH NEXT FROM c_db INTO @DBName
WHILE @@FETCH_STATUS = 0
   BEGIN
      SET @SQLString = 'SELECT @@SERVERNAME                     as  ''ServerName'', '          + 
                       '''' + @DBName + '''' + '                as  ''Database'', '            +  
                       '        f.name, '                                                      +
                       '       CASE '                                                          +
                       '          WHEN (64 & f.status) = 64 THEN ''Log'' '                     +
                       '          ELSE ''Data'' '                                              + 
                       '       END                              as ''Usage Type'', '           +
                       '        f.size*8/1024.00                as ''Size (MB)'', '            +
                       '        NULL                            as ''Space Used (MB)'', '      +
                       '        CASE f.maxsize '                                               +
                       '           WHEN -1 THEN  -1 '                                        +
                       '           WHEN  0 THEN  f.size*8/1024.00  '                           +
                       '           ELSE          f.maxsize*8/1024.00 '                         +
                       '        END                             as ''Max Size (MB)'', '        +
                       '        CASE '                                                         +
                       '           WHEN (1048576&f.status) = 1048576 THEN (growth/100.00)*(f.size*8/1024.00) ' + 
                       '           WHEN f.growth =0                 THEN 0 '                +
                       '           ELSE                                   f.growth*8/1024.00 ' +
                       '        END                             as ''Next Allocation (MB)'', ' +
                       '       CASE  '                                                         +
                       '          WHEN (1048576&f.status) = 1048576 THEN ''Percentage'' '      +
                       '          ELSE ''Pages'' '                                             +
                       '       END                              as ''Usage Type'', '           +
                       '       f.fileid, '                                                     +
                       '       f.groupid, '                                                    +
                       '       filename, '                                                     +
                       '       getdate() '                                                     +
                       ' FROM ' + @DBName + '.dbo.sysfiles f' 
      INSERT #TempForFileStats 
      EXECUTE(@SQLString)
      ------------------------------------------------------------------------
      SET @SQLString = 'USE ' + @DBName + ' DBCC SHOWFILESTATS WITH NO_INFOMSGS'
      INSERT #TempForDataFile
      EXECUTE(@SQLString)
      --
      UPDATE #TempForFileStats
      SET [Space Used (MB)] = s.[Used Extents]*64/1024.00
      FROM #TempForFileStats f,
           #TempForDataFile  s
      WHERE f.[File Id]       = s.[File Id]
        AND f.[Group Id]      = s.[Group Id]
        AND f.[Database Name] = @DBName
      --
      TRUNCATE TABLE #TempForDataFile
      -------------------------------------------------------------------------
      SET @SQLString = 'USE ' + @DBName + ' DBCC LOGINFO WITH NO_INFOMSGS'
      INSERT #TempForLogFile
      EXECUTE(@SQLString)      
      --
      UPDATE #TempForFileStats 
      SET [Space Used (MB)] = (SELECT (MIN(l.[Start Offset]) + 
                                       SUM(CASE 
                                              WHEN l.Status <> 0 THEN  l.[Size (Bytes)] 
                                              ELSE           0 
                                           END))/1048576.00
                               FROM #TempForLogFile l
                               WHERE l.[File Id] = f.[File Id])
      FROM #TempForFileStats f
      WHERE f.[Database Name] = @DBName
        AND f.[Usage Type]    = 'Log'
      --
      TRUNCATE TABLE #TempForLogFile 
      -------------------------------------------------------------------------
      FETCH NEXT FROM c_db INTO @DBName
   END
DEALLOCATE c_db

SELECT * FROM #TempForFileStats
------------
DROP TABLE #TempForFileStats 
DROP TABLE #TempForDataFile
DROP TABLE #TempForLogFile
print '<A HREF="#TOP"><TOP></A>'
go
----------------------------------------------------------------------------------------------------------
print ''
print '<A Name="6"></A><B>6. IO per datafile</B>'
print '******************'
print ''


if exists (select [id] from tempdb..sysobjects where [id] = OBJECT_ID ('tempdb..#TBL_DATABASEFILES'))
   DROP TABLE #TBL_DATABASEFILES


if exists (select [id] from tempdb..sysobjects where [id] = OBJECT_ID ('tempdb..#TBL_FILESTATISTICS'))
   DROP TABLE #TBL_FILESTATISTICS


DECLARE @INT_LOOPCOUNTER INTEGER
DECLARE @INT_MAXCOUNTER INTEGER
DECLARE @INT_DBID INTEGER
DECLARE @INT_FILEID INTEGER
DECLARE @SNM_DATABASENAME SYSNAME
DECLARE @SNM_FILENAME SYSNAME
DECLARE @NVC_EXECUTESTRING NVARCHAR(500)

DECLARE @MTB_DATABASES TABLE ( 
ID INT IDENTITY,
DBID INT,
DBNAME SYSNAME )

CREATE TABLE  #TBL_DATABASEFILES (
ID INT IDENTITY,
DBID INT,
FILEID INT,
FILENAME SYSNAME,
DATABASENAME SYSNAME)

INSERT INTO @MTB_DATABASES (DBID,DBNAME) SELECT DBID,NAME FROM MASTER.DBO.SYSDATABASES ORDER BY DBID
SET @INT_LOOPCOUNTER = 1
SELECT @INT_MAXCOUNTER=MAX(ID) FROM @MTB_DATABASES
WHILE @INT_LOOPCOUNTER <= @INT_MAXCOUNTER
BEGIN
   SELECT @INT_DBID = DBID,@SNM_DATABASENAME=DBNAME FROM @MTB_DATABASES WHERE ID = @INT_LOOPCOUNTER
   SET @NVC_EXECUTESTRING = 'INSERT INTO #TBL_DATABASEFILES(DBID,FILEID,FILENAME,DATABASENAME) SELECT '+STR(@INT_DBID)+',FILEID,NAME,'''+@SNM_DATABASENAME+''' AS DATABASENAME FROM ['+@SNM_DATABASENAME+'].DBO.SYSFILES'
   EXEC SP_EXECUTESQL @NVC_EXECUTESTRING
   SET @INT_LOOPCOUNTER = @INT_LOOPCOUNTER + 1
END
--'OK WE NOW HAVE ALL THE DATABASES AND FILENAMES ETC....

CREATE TABLE #TBL_FILESTATISTICS (
ID INT IDENTITY,
DBID INT,
FILEID INT,
DATABASENAME SYSNAME,
FILENAME SYSNAME,
SAMPLETIME DATETIME,
NUMBERREADS BIGINT,
NUMBERWRITES BIGINT,
BYTESREAD BIGINT,
BYTESWRITTEN BIGINT,
IOSTALLMS BIGINT)

SELECT @INT_MAXCOUNTER=MAX(ID) FROM #TBL_DATABASEFILES
SET @INT_LOOPCOUNTER = 1
WHILE @INT_LOOPCOUNTER <= @INT_MAXCOUNTER
BEGIN
   SELECT @INT_DBID = DBID,@INT_FILEID=FILEID,@SNM_DATABASENAME=DATABASENAME,@SNM_FILENAME=FILENAME FROM #TBL_DATABASEFILES WHERE ID = @INT_LOOPCOUNTER
   INSERT INTO #TBL_FILESTATISTICS(DBID,FILEID,SAMPLETIME,NUMBERREADS,NUMBERWRITES,BYTESREAD,BYTESWRITTEN,IOSTALLMS,DATABASENAME,FILENAME)
   SELECT DBID,FILEID,GETDATE(),NUMBERREADS,NUMBERWRITES,BYTESREAD,BYTESWRITTEN,IOSTALLMS,@SNM_DATABASENAME AS DATABASENAME,@SNM_FILENAME AS FILENAME FROM :: FN_VIRTUALFILESTATS(@INT_DBID,@INT_FILEID)
   SET @INT_LOOPCOUNTER = @INT_LOOPCOUNTER + 1
END
select * from #TBL_FILESTATISTICS

drop table #TBL_DATABASEFILES
drop table #TBL_FILESTATISTICS
print '<A HREF="#TOP"><TOP></A>'
go
---------------------------------------------------------------------------------------
print ''
print '<A Name="7"></A><B>7. List of last backup full''s</B>'
print '*************************************'
print ''

select 	SUBSTRING(s.name,1,40)			AS	'Database',
	CAST(b.backup_start_date AS char(11)) 	AS 	'Backup Date  ',
	CASE WHEN b.backup_start_date > DATEADD(dd,-1,getdate())
		THEN 'Backup is current within a day'
	     WHEN b.backup_start_date > DATEADD(dd,-7,getdate())
		THEN 'Backup is current within a week'
	     ELSE '*****CHECK BACKUP!!!*****'
		END
						AS 'Comment'

from 	master..sysdatabases	s
LEFT OUTER JOIN	msdb..backupset b
	ON s.name = b.database_name
	AND b.backup_start_date = (SELECT MAX(backup_start_date)
					FROM msdb..backupset
					WHERE database_name = b.database_name
						AND type = 'D')		-- full database backups only, not log backups
WHERE	s.name <> 'tempdb'

ORDER BY 	s.name
go
print '<A HREF="#TOP"><TOP></A>'
---------------------------------------------------------------------------------------------------------- 
print ''
print '<A Name="8"></A><B>8. List of logins</B>'
print '********************'
print ''

exec sp_helplogins
go
print '<A HREF="#TOP"><TOP></A>'
----------------------------------------------------------------------------------------------------------
print ''
print '<A Name="9"></A><B>9. List of users per role</B>'
print '*******************************'
print ''

exec sp_helpsrvrolemember
go
print '<A HREF="#TOP"><TOP></A>'
----------------------------------------------------------------------------------------------------------
print ''
print '<A Name="10"></A><B>10.List of special users per database</B>'
print '*************************************'
print ''


declare @name sysname,
	@SQL  nvarchar(600)

if exists (select [id] from tempdb..sysobjects where [id] = OBJECT_ID ('tempdb..#tmpTable'))
	drop table #tmpTable
	
CREATE TABLE #tmpTable (
	[DATABASE_NAME] sysname NOT NULL ,
	[USER_NAME] sysname NOT NULL,
	[ROLE_NAME] sysname NOT NULL)

declare c1 cursor for 
	select name from master.dbo.sysdatabases
			
open c1
fetch c1 into @name
while @@fetch_status >= 0
begin
	select @SQL = 
		'insert into #tmpTable
		 select N'''+ @name + ''', a.name, c.name
		from ' + QuoteName(@name) + '.dbo.sysusers a 
		join ' + QuoteName(@name) + '.dbo.sysmembers b on b.memberuid = a.uid
		join ' + QuoteName(@name) + '.dbo.sysusers c on c.uid = b.groupuid
		where a.name != ''dbo'''

		/* 	Insert row for each database */
		execute (@SQL)
	fetch c1 into @name
end
close c1
deallocate c1
	
select * from #tmpTable

drop table #tmpTable
go
print '<A HREF="#TOP"><TOP></A>'
----------------------------------------------------------------------------------------------------------
print ''
print '<A Name="11"></A><B>11. Information about remote servers </B>'
print '*****************************************'
print ''

exec sp_helplinkedsrvlogin
exec sp_helpremotelogin
print '<A HREF="#TOP"><TOP></A>'
go
----------------------------------------------------------------------------------------------------------
print ''
print '<A Name="12"></A><B>12. List of jobs </B>'
print '*******************'
print ''

exec msdb..sp_help_job
go
print '<A HREF="#TOP"><TOP></A>'
----------------------------------------------------------------------------------------------------------

print ''
print '<A Name="13"></A><B>13. Cache Hit Ratio </B>'
print '*******************'
print ''

select 	distinct counter_name,
	(select isnull(sum(convert(dec(15,0),B.cntr_value)),0) 
	from 	master..sysperfinfo as B (nolock) 
	where 	Lower(B.counter_name) like '%hit ratio%'
	and	A.counter_name = B.counter_name) as CurrHit,
	(select isnull(sum(convert(dec(15,0),B.cntr_value)),0) 
	from 	master..sysperfinfo as B (nolock) 
	where 	Lower(B.counter_name) like '%hit ratio base%'
	and	lower(B.counter_name) = (lower(ltrim(rtrim(A.counter_name))) + ' base')) as CurrBase,
	(select isnull(sum(convert(dec(15,0),B.cntr_value)),0) 
	from 	master..sysperfinfo as B (nolock) 
	where 	Lower(B.counter_name) like '%hit ratio%'
	and	A.counter_name = B.counter_name) / 
	(select isnull(sum(convert(dec(15,0),B.cntr_value)),0) 
	from 	master..sysperfinfo as B (nolock) 
	where 	Lower(B.counter_name) like '%hit ratio base%'
	and	lower(B.counter_name) = (lower(ltrim(rtrim(A.counter_name))) + ' base')) as HitRatio
from 	master..sysperfinfo as A (nolock) 
where 	Lower(A.counter_name) like '%hit ratio%'
and 	Lower(A.counter_name) not like '%hit ratio base%' 

-- Audit list as a double verification
/*
select counter_name,isnull(sum(convert(dec(15,0),cntr_value)),0) as Value
from 	master..sysperfinfo (nolock) 
where 	Lower(counter_name) like '%hit ratio%'
or 	Lower(counter_name) like '%hit ratio base%' 
group by counter_name
print '<A HREF="#TOP"><TOP></A>'
--go



----------------------------------------------------------------------------------------------------------

print ''
print '14. SP_WHO '
print '***********'
print ''
exec sp_who
exec sp_who2
--go

----------------------------------------------------------------------------------------------------------

print ''
print '14. SP_LOCKS '
print '***********'
print ''
exec sp_lock

--go

print '******************************************************************'
print '                              FIM                                 ' 
print '******************************************************************'
----------------------------------------------------------------------------------------------------------
*/
set nocount off

