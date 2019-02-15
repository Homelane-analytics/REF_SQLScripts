/*
DELETE MULTIPLE TABLES
----------------------------
*/
DECLARE @sql NVARCHAR(MAX) = N'';
SELECT @sql += 'DROP TABLE '+ QUOTENAME(s.name)+ '.' + QUOTENAME(t.name) + ';'+char(10)FROM sys.tables AS t INNER JOIN sys.schemas AS s ON t.[schema_id] = s.[schema_id] 
WHERE t.name LIKE 'z_ps%';
PRINT @sql
EXEC sp_executesql @sql;

/*
COPY MULTIPLE TABLES TO OTHER DB
----------------------------
*/
DECLARE @sql NVARCHAR(MAX) = N'';
SELECT @sql += 'SELECT * into DummyDB.dbo.'+ QUOTENAME(t.name)+' FROM '+ QUOTENAME(t.name) + ';'+char(10) FROM sys.tables AS t INNER JOIN sys.schemas AS s ON t.[schema_id] = s.[schema_id] 
WHERE t.name LIKE 'RAW_%'  ;
PRINT @sql
EXEC sp_executesql @sql;


/*
RENAME  MULTIPLE TABLES 
----------------------------
*/
DECLARE @sql NVARCHAR(MAX) = N'';
SELECT @sql += 'exec sp_rename ''' + QUOTENAME(t.name) + ''', ''STG_'+left(right(QUOTENAME(t.name),len(QUOTENAME(t.name))-1),len(QUOTENAME(t.name))-6)+''''+char(10)FROM sys.tables AS t INNER JOIN sys.schemas AS s ON t.[schema_id] = s.[schema_id] 
WHERE t.name LIKE '%_STG';
PRINT @sql
EXEC sp_executesql @sql;


/*
IMPORT DATA FROM EXCEL FILE
----------------------------
*/
SELECT * FROM OPENROWSET('Microsoft.ACE.OLEDB.12.0','Excel 12.0; Database=C:\\Excel_Files\\REF_Dummy_excel_file.xlsx'
, [Sheet1$])
