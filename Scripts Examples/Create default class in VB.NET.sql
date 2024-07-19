/* author Peter Livesey
date 17/2/2006
purpose will generate a class with insert update and delete capability on a 
        single table where the stored procs were created by the stored proc creation script
*/



/*first we need the table name*/
SET NOCOUNT ON
DECLARE @TABLENAME  VARCHAR(50)
SET @TABLENAME = 'xtsUsuarios'
/* do not tiouch code beyond this point*/
DECLARE @CRLF char(2)
DECLARE @TAB  char(2)
SET @CRLF = char(13) + char (10)
SET @TAB = '  '





DECLARE @PARAMETERLIST varchar(8000)
SET @PARAMETERLIST = ''

/* get the fieldclassstring*/
DECLARE @FIELDCLASSSTRING  varchar(8000)
SET @FIELDCLASSSTRING=''

DECLARE  @fields TABLE
        (
        name  sysname,
        type  varchar(50),
        length int,
        NULLABLE bit
        )
insert into @fields
SELECT sc.name , st.name , sc.length,isnullable 
FROM
	syscolumns sc
JOIN
	systypes st
	ON(
		sc.xtype = st.xusertype
	)
	
WHERE
	sc.id = OBJECT_ID(@TABLENAME)

ORDER BY
	sc.colorder





SELECT @FIELDCLASSSTRING =   @FIELDCLASSSTRING +  @CRLF + @tab + @tab + 'Public Class ' + name +
      @CRLF + @tab + @tab + @tab + 'Public Const Name As String = "' + name + '"' +
      @CRLF + @tab + @tab + @tab+ 'Public Const Type As sqlDBType = SqlDbType.' + type  +
      @CRLF + @tab + @tab + @tab+ 'Public Const Size As Integer = ' + CONVERT (varchar(10),length)  +
      @CRLF + @tab + @tab+     'End Class'
FROM @fields


/**********************************************
get the type of ID
**********************************************/
DECLARE @IDENTITY bit
SET @IDENTITY = 0


/*check to see whether the key field is an identity*/
IF (exists (SELECT '*'
            FROM
            	syscolumns sc
            JOIN
            	systypes st
            	ON(
            		sc.xtype = st.xusertype
            	)
            	
            WHERE
            	sc.id = OBJECT_ID(@TABLENAME)
              and autoval IS NOT NULL
            )
    )
BEGIN
   SET @IDENTITY= 1
END
DECLARE @GUID bit

SET @GUID = 0
IF (exists (SELECT '*'
            FROM
            	syscolumns sc
            JOIN
            	systypes st
            	ON
            		sc.xtype = st.xusertype
             JOIN 
	            sysindexes si
            ON
	            sc.id = si.id
	            and sc.colid = si.indid
            	
            WHERE
            	sc.id = OBJECT_ID(@TABLENAME)
              and st.name ='uniqueidentifier'
              and indid= 1
            )
    )
BEGIN
   SET @GUID= 1
END

/* get id name*/
DECLARE @IDNAME varchar(100)
DECLARE @IDTYPE varchar(100)
DECLARE @IDVBTYPE varchar (100)
DECLARE @IDVBPREFIX varchar(3)
SELECT  @IDNAME = b.name ,@IDTYPE = st.name,
@IDVBTYPE =CASE st.name
		WHEN 'bigint' 		THEN 'long'
		WHEN 'binary' 		THEN 'object'
		WHEN 'bit' 		THEN 'boolean'
		WHEN 'char' 		THEN 'str'
		WHEN 'datetime' 	THEN 'date'
		WHEN 'decimal' 		THEN 'double'
		WHEN 'float' 		THEN 'real'
		WHEN 'identity' 	THEN 'int'
		WHEN 'image' 		THEN 'object'
		WHEN 'int' 		THEN 'integer'
		WHEN 'money' 		THEN 'double'
		WHEN 'nchar' 		THEN 'string'
		WHEN 'ntext' 		THEN 'string'
		WHEN 'numeric' 		THEN 'double'
		WHEN 'nvarchar' 	THEN 'string'
		WHEN 'real' 		THEN 'single'
		WHEN 'smalldatetime' 	THEN 'date'
		WHEN 'smallint' 	THEN 'integer'
		WHEN 'smallmoney' 	THEN 'double'
		WHEN 'sql_variant' 	THEN 'object'
		WHEN 'text' 		THEN 'string'
		WHEN 'timestamp' 	THEN 'object'
		WHEN 'tinyint' 		THEN 'integer'
		WHEN 'uniqueidentifier'	THEN 'guid'
		WHEN 'varbinary' 	THEN 'object'
		WHEN 'varchar' 		THEN 'string'
	END,

@IDVBPREFIX =
CASE st.name
		WHEN 'bigint' 		THEN 'int'
		WHEN 'binary' 		THEN 'obj'
		WHEN 'bit' 		THEN 'bln'
		WHEN 'char' 		THEN 'str'
		WHEN 'datetime' 	THEN 'dt'
		WHEN 'decimal' 		THEN 'dbl'
		WHEN 'float' 		THEN 'dbl'
		WHEN 'identity' 	THEN 'int'
		WHEN 'image' 		THEN 'obj'
		WHEN 'int' 		THEN 'int'
		WHEN 'money' 		THEN 'dbl'
		WHEN 'nchar' 		THEN 'str'
		WHEN 'ntext' 		THEN 'str'
		WHEN 'numeric' 		THEN 'dbl'
		WHEN 'nvarchar' 	THEN 'str'
		WHEN 'real' 		THEN 'sng'
		WHEN 'smalldatetime' 	THEN 'dt'
		WHEN 'smallint' 	THEN 'int'
		WHEN 'smallmoney' 	THEN 'dbl'
		WHEN 'sql_variant' 	THEN 'obj'
		WHEN 'text' 		THEN 'str'
		WHEN 'timestamp' 	THEN 'obj'
		WHEN 'tinyint' 		THEN 'int'
		WHEN 'uniqueidentifier'	THEN 'gui'
		WHEN 'varbinary' 	THEN 'obj'
		WHEN 'varchar' 		THEN 'str'
	END
FROM 
	syscolumns b
INNER JOIN 
	sysindexes si
ON
	b.id = si.id
	and b.colid = si.indid
INNER  JOIN
   systypes st
ON
   b.xtype = st.xusertype
	
where 
  b.id = OBJECT_ID(@TABLENAME)and
  indid = 1

/***********************************************/

PRINT 'Imports System'
PRINT 'Imports System.Web'
PRINT 'Imports System.Data'
PRINT 'Imports System.Data.SqlClient'
PRINT 'Imports System.IO'
PRINT 'Imports System.Xml'

PRINT @CRLF
PRINT 'Namespace DATA'
PRINT @CRLF
PRINT @CRLF
PRINT  @TAB +   'Public Class ' + @TABLENAME  
PRINT @CRLF
PRINT @CRLF

PRINT '''*******************************************************************************'
   
PRINT '''  Class Name:   ' + @TABLENAME  
    
PRINT '''   Description: The class provides all database access functionallity.'
    
PRINT '''   Written By:  Peter Livesey'
    
PRINT '''   Date:        7 dec 2005'
    
PRINT '''*******************************************************************************'
PRINT @CRLF
PRINT @CRLF
PRINT @CRLF
PRINT @tab + '''make this a static class by making a private constructor'
PRINT @tab + 'Private Function ' + @TABLENAME  + '() As Object'
PRINT @tab + 'End Function'




 PRINT @TAB +'Public Class Field'          

PRINT @FIELDCLASSSTRING

 PRINT @TAB + 'End Class  '' field'   /* end of field class*/
      


/* now I need to write the insert procedure*/
/* work out the parameterlist for the insert proc*/

DECLARE @spname varchar(128)

SET @spname = 'usp_insert'+ @TABLENAME


SELECT
	 @PARAMETERLIST = @PARAMETERLIST + 
'ByVal ' + 

	CASE st.name
		WHEN 'bigint' 		THEN 'vnt'
		WHEN 'binary' 		THEN 'vnt'
		WHEN 'bit' 		THEN 'bln'
		WHEN 'char' 		THEN 'str'
		WHEN 'datetime' 	THEN 'dt'
		WHEN 'decimal' 		THEN 'vnt'
		WHEN 'float' 		THEN 'dbl'
		WHEN 'identity' 	THEN 'lng'
		WHEN 'image' 		THEN 'vnt'
		WHEN 'int' 		THEN 'lng'
		WHEN 'money' 		THEN 'cry'
		WHEN 'nchar' 		THEN 'str'
		WHEN 'ntext' 		THEN 'str'
		WHEN 'numeric' 		THEN 'vnt'
		WHEN 'nvarchar' 	THEN 'str'
		WHEN 'real' 		THEN 'sng'
		WHEN 'smalldatetime' 	THEN 'dt'
		WHEN 'smallint' 	THEN 'int'
		WHEN 'smallmoney' 	THEN 'cry'
		WHEN 'sql_variant' 	THEN 'vnt'
		WHEN 'text' 		THEN 'str'
		WHEN 'timestamp' 	THEN 'vnt'
		WHEN 'tinyint' 		THEN 'byt'
		WHEN 'uniqueidentifier'	THEN 'gui'
		WHEN 'varbinary' 	THEN 'vnt'
		WHEN 'varchar' 		THEN 'str'
	END
	+ REPLACE(REPLACE(sc.name, '_', ' '), ' ', '')
	+ ' As ' +
	CASE st.name
		WHEN 'bigint' 		THEN 'intger'
		WHEN 'binary' 		THEN 'Object'
		WHEN 'bit' 		THEN 'Boolean'
		WHEN 'char' 		THEN 'String'
		WHEN 'datetime' 	THEN 'Date'
		WHEN 'decimal' 		THEN 'real'
		WHEN 'float' 		THEN 'Double'
		WHEN 'identity' 	THEN 'Long'
		WHEN 'image' 		THEN 'object'
		WHEN 'int' 		THEN 'Long'
		WHEN 'money' 		THEN 'String'
		WHEN 'nchar' 		THEN 'String'
		WHEN 'ntext' 		THEN 'String'
		WHEN 'numeric' 		THEN 'String'
		WHEN 'nvarchar' 	THEN 'String'
		WHEN 'real' 		THEN 'Single'
		WHEN 'smalldatetime' 	THEN 'Date'
		WHEN 'smallint' 	THEN 'Integer'
		WHEN 'smallmoney' 	THEN 'Currency'
		WHEN 'sql_variant' 	THEN 'object'
		WHEN 'text' 		THEN 'String'
		WHEN 'timestamp' 	THEN 'object'
		WHEN 'tinyint' 		THEN 'Byte'
		WHEN 'uniqueidentifier'	THEN 'GUID'
		WHEN 'varbinary' 	THEN 'object'
		WHEN 'varchar' 		THEN 'String'
		ELSE 'UNKNOWN'
	END
	+ ', _' + @CRLF
FROM
	syscolumns sc
JOIN
	systypes st
ON
	sc.xtype = st.xusertype
LEFT JOIN 
	sysindexes si
ON
	sc.id = si.id
  and colid = indid
WHERE
	sc.id = OBJECT_ID(@TABLENAME)
  and autoval IS NULL
ORDER BY
	sc.colorder


/* now create the stored proc paramters*/
DECLARE @SPParameters varchar(8000)
set @SPParameters = ''

SELECT @SPParameters = @SPParameters + @tab + @tab +
'.Add(New SqlParameter(' 
	+ '"@" & Field.' + REPLACE(sc.name,'@','') + '.Name ,Field.' + REPLACE(sc.name,'@','') + '.Type,Field.' + REPLACE(sc.name,'@','') + '.size)).value =' +
	CASE st.name
		WHEN 'bigint' 		THEN 'vnt'
		WHEN 'binary' 		THEN 'vnt'
		WHEN 'bit' 		THEN 'bln'
		WHEN 'char' 		THEN 'str'
		WHEN 'datetime' 	THEN 'dt'
		WHEN 'decimal' 		THEN 'vnt'
		WHEN 'float' 		THEN 'dbl'
		WHEN 'identity' 	THEN 'lng'
		WHEN 'image' 		THEN 'vnt'
		WHEN 'int' 		THEN 'lng'
		WHEN 'money' 		THEN 'cry'
		WHEN 'nchar' 		THEN 'str'
		WHEN 'ntext' 		THEN 'str'
		WHEN 'numeric' 		THEN 'vnt'
		WHEN 'nvarchar' 	THEN 'str'
		WHEN 'real' 		THEN 'sng'
		WHEN 'smalldatetime' 	THEN 'dt'
		WHEN 'smallint' 	THEN 'int'
		WHEN 'smallmoney' 	THEN 'cry'
		WHEN 'sql_variant' 	THEN 'vnt'
		WHEN 'text' 		THEN 'str'
		WHEN 'timestamp' 	THEN 'vnt'
		WHEN 'tinyint' 		THEN 'byt'
		WHEN 'uniqueidentifier'	THEN 'gui'
		WHEN 'varbinary' 	THEN 'vnt'
		WHEN 'varchar' 		THEN 'str'
		ELSE 'str'
	END
	+
	REPLACE(REPLACE(SUBSTRING(sc.name, 2, LEN(sc.name) - 1), '_', ' '), ' ', '')
  +@CRLF
	

FROM
	syscolumns sc
INNER JOIN
	systypes st
	ON(
		sc.xtype = st.xusertype
	)
WHERE
	sc.id = OBJECT_ID('usp_insert' +@TABLENAME)-- and st.status = 0
ORDER BY
	sc.colorder





/* rip of last comma */
SET @PARAMETERLIST = LEFT(@PARAMETERLIST,LEN(@PARAMETERLIST) - 5) + ' _' 
PRINT  @tab + 'Public Shared Function Insert' + @TABLENAME  + ' _'
PRINT  @tab + '(  _'
PRINT @PARAMETERLIST
PRINT @tab + ') as string'
/* now we write the body of this function*/
PRINT @CRLF + @CRLF
PRINT @tab + ''' open connection' 
PRINT @tab + 'Dim cn As SqlConnection'
PRINT @tab + 'Dim strConn As String = ConfigurationSettings.AppSettings("ConnectionString")'
PRINT @CRLF + @CRLF
PRINT @tab +  'cn = New SqlConnection(strConn)'
PRINT @CRLF
PRINT @tab + '''create the command object'
PRINT @tab + 'Dim strCommand As String = "usp_Insert' + @tablename + '"'
PRINT @tab + 'Dim scmd As New SqlCommand(strCommand, cn)'
PRINT @tab + 'scmd.CommandType = CommandType.StoredProcedure'
PRINT @CRLF
PRINT @tab + ''' Add all the required SQL parameters.'
PRINT @tab + 'With scmd.Parameters'
PRINT @SPParameters
PRINT @tab + 'End With'
PRINT @tab + 'Try'
PRINT @tab + @tab +'cn.Open()'
PRINT @tab + @tab +'scmd.ExecuteNonQuery()'
PRINT @tab + @tab +'Return "" '' return no errors'
PRINT @tab + 'Catch exp As Exception'
PRINT @tab + @tab +'Return exp.Message'
PRINT @tab + 'Finally'
PRINT @tab + @tab +'cn.Close()'
PRINT @tab + 'End Try'
PRINT 'end function ''Insert' + @TABLENAME 




/* now we need the update proc*/
/* rip of last comma */
PRINT  @tab + 'Public Shared Function Update' + @TABLENAME  + ' _'
PRINT  @tab + '(  _'
PRINT @PARAMETERLIST
PRINT @tab + ') as string'
/* now we write the body of this function*/
PRINT @CRLF + @CRLF
PRINT @tab + ''' open connection' 
PRINT @tab + 'Dim cn As SqlConnection'
PRINT @tab + 'Dim strConn As String = ConfigurationSettings.AppSettings("ConnectionString")'
PRINT @CRLF + @CRLF
PRINT @tab +  'cn = New SqlConnection(strConn)'
PRINT @CRLF
PRINT @tab + '''create the command object'
PRINT @tab + 'Dim strCommand As String = "usp_Update' + @tablename + '"'
PRINT @tab + 'Dim scmd As New SqlCommand(strCommand, cn)'
PRINT @tab + 'scmd.CommandType = CommandType.StoredProcedure'
PRINT @CRLF
PRINT @tab + ''' Add all the required SQL parameters.'
PRINT @tab + 'With scmd.Parameters'
PRINT @SPParameters
PRINT @tab + 'End With'
PRINT @tab + 'Try'
PRINT @tab + @tab +'cn.Open()'
PRINT @tab + @tab +'scmd.ExecuteNonQuery()'
PRINT @tab + @tab +'Return "" '' return no errors'
PRINT @tab + 'Catch exp As Exception'
PRINT @tab + @tab +'Return exp.Message'
PRINT @tab + 'Finally'
PRINT @tab + @tab +'cn.Close()'
PRINT @tab + 'End Try'
PRINT 'end function ''update' + @TABLENAME 




/* now we need the update proc*/
/* rip of last comma */
PRINT  @tab + 'Public Shared Function Delete' + @TABLENAME  + ' _'
PRINT  @tab + '(  _'
PRINT @IDVBPrefix + @IDname + ' as ' + @IDVBTYPE + ' _'
PRINT @tab + ') as string'
/* now we write the body of this function*/
PRINT @CRLF + @CRLF
PRINT @tab + ''' open connection' 
PRINT @tab + 'Dim cn As SqlConnection'
PRINT @tab + 'Dim strConn As String = ConfigurationSettings.AppSettings("ConnectionString")'
PRINT @CRLF + @CRLF
PRINT @tab +  'cn = New SqlConnection(strConn)'
PRINT @CRLF
PRINT @tab + '''create the command object'
PRINT @tab + 'Dim strCommand As String = "usp_Delete' + @tablename + '"'
PRINT @tab + 'Dim scmd As New SqlCommand(strCommand, cn)'
PRINT @tab + 'scmd.CommandType = CommandType.StoredProcedure'
PRINT @CRLF
PRINT @tab + ''' Add all the required SQL parameters.'
PRINT @tab + 'With scmd.Parameters'
PRINT @TAB + @TAB + '.add(New SqlParameter("@" & Field.' + @IDNAME + '.Name, Field.' + @IDNAME + '.Type, Field.' + @IDNAME + '.size)).value = ' + @IDVBPREFIX + @IDNAME

      
PRINT @tab + 'End With'
PRINT @tab + 'Try'
PRINT @tab + @tab +'cn.Open()'
PRINT @tab + @tab +'scmd.ExecuteNonQuery()'
PRINT @tab + @tab +'Return "" '' return no errors'
PRINT @tab + 'Catch exp As Exception'
PRINT @tab + @tab +'Return exp.Message'
PRINT @tab + 'Finally'
PRINT @tab + @tab +'cn.Close()'
PRINT @tab + 'End Try'
PRINT 'end function ''delete' + @TABLENAME 


PRINT @CRLF
PRINT 'End Class ''' + @TABLENAME  /*end of main class*/        
PRINT 'End NameSpace '' data' 

