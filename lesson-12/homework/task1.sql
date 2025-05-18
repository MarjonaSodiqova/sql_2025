DECLARE @sql NVARCHAR(MAX) = N'';

SELECT @sql += '
USE [' + name + '];
SELECT 
    DB_NAME() AS DatabaseName,
    s.name AS SchemaName,
    t.name AS TableName,
    c.name AS ColumnName,
    ty.name AS DataType
FROM sys.tables t
JOIN sys.schemas s ON t.schema_id = s.schema_id
JOIN sys.columns c ON t.object_id = c.object_id
JOIN sys.types ty ON c.user_type_id = ty.user_type_id
' + CHAR(13) + 'UNION ALL' + CHAR(13)
FROM sys.databases
WHERE name NOT IN ('master', 'tempdb', 'model', 'msdb')
  AND state_desc = 'ONLINE';


SET @sql = LEFT(@sql, LEN(@sql) - 10);

EXEC sp_executesql @sql;
