-- These are my standard template variables.  All are lowercase.
-- Remember that "sysname" MUST be lower-case (will fail on a cs db).

<build_number, int, 15>
<check_constraint_expr, NVARCHAR(MAX), ThisColumn > 0 AND ThatColumn IS NOT NULL>
<check_constraint_key_name, sysname, _Columns or _Usage>
<column_name, sysname, ThisColumn>
<column_name_constraint_is_on, sysname, ThisColumn>
<column_type, sysname, 'INT'>
<column_in_pos_1_in_index, sysname, ThisColumn>
<column_in_pos_2_in_index, sysname, ThisColumn>
<column_in_pos_3_in_index, sysname, ThisColumn>
<columns_for_name, NVARCHAR(MAX), ThisColumn_ThatColumn>
<columns_for_name, NVARCHAR(MAX), ThisColumn_ThatColumn_plus_IncludedColumn>
<columns_for_index, NVARCHAR(MAX), ThisColumn DESC, ThatColumn DESC, OtherColumn DESC>
<columns_for_include, NVARCHAR(MAX), ThisIncludedColumn, ThatIncludedColumn>
<columns_for_insert, NVARCHAR(MAX), ThisInsertColumn, ThatInsertColumn, TheOtherInsertColumn>
<columns_for_output, NVARCHAR(MAX), ThisOutputColumn, ThatOutputColumn, TheOtherOutputColumn>
<columns_for_rename, NVARCHAR(MAX), NewColumn>
<columns_in_primary_key, NVARCHAR(MAX), ThisPkColumn, ThatPkColumn>
<computed_column_expression, NVARCHAR(MAX), 'col1 + col2'>
<cursor_name, sysname, TheCursor>
<cursor_sql_statement, NVARCHAR(4000), SELECT * FROM MyTable>
<database_file, sysname, MyDB>
<database_name, sysname, MyDB>
<datatype,, INT>
<datatype1,, INT>
<datatype2,, INT>
<datatype_return_value,, INT>
<default_constraint_value, DATETIME, GETDATE()>
<default_type_value, NVARCHAR(50), ''>
<default_value_for_param1, , 111>
<default_value_for_param2, , 222>
<delete_this_for_not_unique, NVARCHAR(50), UNIQUE>
<ext_edition_only, NVARCHAR(50), ONLINE = ON>                        -- Because you have multiple WITH clauses.
<ext_edition_only_createindex, NVARCHAR(50), ONLINE = ON>            -- Because you have multiple WITH clauses.
<ext_edition_only_dropindex, NVARCHAR(50), WITH (ONLINE = ON)>       -- Because you have only one WITH clause.
<failure message, NVARCHAR,    *** Failed to ...>
<file_description, NVARCHAR(128), Desc>
<file_extension, NVARCHAR(50), sql>
<file_name_without_ext, NVARCHAR(32), Something>
<fillfactor, INT, 70>
<foreign_key_constraint_name, sysname, FK_>
<function_name, sysname, Function Name (No Prefix)>
<index_description_value, NVARCHAR(4000), Enter description...>
IX_<table_name_prefix, NVARCHAR(50), tbl><table_name, sysname, ThisTable>_<columns_for_name, NVARCHAR(MAX), ThisColumn_ThatColumn>
<index_name, sysname, IX_>
<index_prefix, sysname, IX UQ>
<is_unique_constraint, int, 1>
<guid_is_sequential, NVARCHAR(50), SEQUENTIAL>
<login_name, sysname, Bob>
<login_type_desc, NVARCHAR(60), SQL_LOGIN>
<nullability, NVARCHAR(50), NOT NULL>
<nvarchar_size, INT, 50>
<other_column_name, sysname, OtherColumn>
<other_table_name, sysname, OtherTable>
<password, NVARCHAR(40), 40 chars>
<parameter1, sysname, @MyParam1>
<parameter2, sysname, @MyParam2>
<schema_name, sysname, dbo>
<stored_procedure_name, sysname, usp_>
<table_description_value, NVARCHAR(4000), Enter description...>
<trigger_type, NVARCHAR(3), IUD>
<trigger_purpose, NVARCHAR(50), ShortPhraseDescribingPurposeOfTrigger>
<type_name, sysname, udtNoUnderscore>
<values_for_insert, NVARCHAR(MAX), Value1, Value2, Value3>
<variable_name1, sysname, @MyVar1>
<variable_name2, sysname, @MyVar2>
<view_name, sysname, ThisView>
<with_log, NVARCHAR(50), , LOG>
<with_full_scan, NVARCHAR(50), WITH FULLSCAN>

--Table WITH prefix wart on name:
<table_name_prefix, NVARCHAR(50), tbl><table_name, sysname, ThisTable>

--Table WITHOUT prefix wart on name:
<table_name, sysname, ThisTable>

*****************************************************************************

/* Commonly used phrases. */
The denormalized value necessary to maintain history.
Enforces boolean behavior.

*****************************************************************************

/* Various kinds of lines. */

-----------------------------------------------------------------------------
--
-----------------------------------------------------------------------------

-- ==========================================================================

*****************************************************************************

/* These are my standard colors for all editors.
 
Bookmark                      default       on   Cyan 
Brace Matching                Yellow        on   Black 
Brace Matching (rect)         White         on   Black 
Collapsed Text                255,128,0     on   Black
Collapsible Region            255,128,0     on   Black
Comment                       Black         on   000,196,196 
CSS Comment                   Black         on   000,196,196 
CSS Keyword                   100,180,255   on   Black 
CSS Property Name             255,0,255     on   Black 
CSS Property Value            128,128,255   on   Black 
CSS Selector                  180,96,96     on   Black 
CSS String Value              0,255,64      on   Black 
Current line                  255,255,120   on   Teal 
Error                         Red           on   Black 
HTML Attribute Name           255,128,155   on   Black 
HTML Attribute Value          128,128,255   on   Black   
Identifier                    White         on   Black
Keyword                       255,255,128   on   Black
Literal
Inactive Selected Text        Black         on   191,205,219 
Indicator Margin              0,196,196     on   Black 
Line numbers                  0,196,196     on   Black 
Number                        Red           on   Black 
Operator                      White         on   Black 
Plain Text                    White         on   Black 
Script String                 Lime          on   Black
Selection                     Red           on   Blue 
SQL DML Marker                Blue          on   Black
SQL Identifier                White         on   Black 
SQL Keyword                   100,180,255   on   Black 
SQL Operator                  255,164,72    on   Black 
SQL Stored Procedure          183,255,35    on   Black 
SQL String                    Lime          on   Black 
SQL system function           Magenta       on   Black 
SQL system table              255,128,128   on   Black 
String                        Lime          on   Black 
Track changes after save      Lime          on   Black 
Track changes before save     Yellow        on   Black 
Visible Whitespace            150,150,150   on   Black 
Warning                       Yellow        on   Black 

*/
