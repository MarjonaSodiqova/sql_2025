
DECLARE @IndexHTML NVARCHAR(MAX);

WITH IndexInfo AS (
    SELECT 
        t.name AS TableName,
        i.name AS IndexName,
        i.type_desc AS IndexType,
        ic.is_included_column,
        c.name AS ColumnName,
        CASE WHEN ic.is_included_column = 0 THEN 'Key Column' ELSE 'Included Column' END AS ColumnType
    FROM sys.indexes i
    INNER JOIN sys.index_columns ic ON i.object_id = ic.object_id AND i.index_id = ic.index_id
    INNER JOIN sys.columns c ON ic.object_id = c.object_id AND ic.column_id = c.column_id
    INNER JOIN sys.tables t ON i.object_id = t.object_id
    WHERE i.type_desc <> 'HEAP' 
)
-- Step 2: Convert to HTML format
SELECT @IndexHTML = 
    N'<style>
        table { border-collapse: collapse; width: 100%; font-family: Arial, sans-serif; }
        th, td { border: 1px solidrgb(123, 48, 48); text-align: left; padding: 8px; }
        th { background-color:rgb(157, 11, 11); }
     </style>
     <h3>Index Metadata Report</h3>
     <table>
        <tr>
            <th>Table Name</th>
            <th>Index Name</th>
            <th>Index Type</th>
            <th>Column Name</th>
            <th>Column Type</th>
        </tr>' +
    STRING_AGG(
        N'<tr><td>' + TableName + N'</td><td>' + IndexName + N'</td><td>' + IndexType + N'</td><td>' + ColumnName + N'</td><td>' + ColumnType + N'</td></tr>',
        N''
    ) + 
    N'</table>'
FROM IndexInfo;
