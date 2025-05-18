CREATE PROCEDURE sp_GetProceduresAndFunctions
    @DatabaseName SYSNAME = NULL
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @sql NVARCHAR(MAX) = N'';

    IF @DatabaseName IS NOT NULL
    BEGIN
        
        IF NOT EXISTS (
            SELECT 1 FROM sys.databases 
            WHERE name = @DatabaseName 
              AND name NOT IN ('master', 'tempdb', 'model', 'msdb')
              AND state_desc = 'ONLINE'
        )
        BEGIN
            RAISERROR('Invalid or inaccessible database name.', 16, 1);
            RETURN;
        END

        SET @sql = '
        USE [' + QUOTENAME(@DatabaseName) + '];
        SELECT 
            ROUTINE_SCHEMA AS SchemaName,
            ROUTINE_NAME AS RoutineName,
            ROUTINE_TYPE,
            PARAMETER_NAME,
            DATA_TYPE,
            CHARACTER_MAXIMUM_LENGTH
        FROM INFORMATION_SCHEMA.ROUTINES r
        LEFT JOIN INFORMATION_SCHEMA.PARAMETERS p 
            ON r.SPECIFIC_NAME = p.SPECIFIC_NAME AND r.SPECIFIC_SCHEMA = p.SPECIFIC_SCHEMA
        ORDER BY ROUTINE_SCHEMA, ROUTINE_NAME, PARAMETER_NAME;';
    END
    ELSE
    BEGIN
        SELECT @sql += '
        USE [' + name + '];
        SELECT 
            DB_NAME() AS DatabaseName,
            ROUTINE_SCHEMA AS SchemaName,
            ROUTINE_NAME AS RoutineName,
            ROUTINE_TYPE,
            PARAMETER_NAME,
            DATA_TYPE,
            CHARACTER_MAXIMUM_LENGTH
        FROM INFORMATION_SCHEMA.ROUTINES r
        LEFT JOIN INFORMATION_SCHEMA.PARAMETERS p 
            ON r.SPECIFIC_NAME = p.SPECIFIC_NAME AND r.SPECIFIC_SCHEMA = p.SPECIFIC_SCHEMA
        ORDER BY SchemaName, RoutineName, PARAMETER_NAME;
        ' + CHAR(13)
        FROM sys.databases
        WHERE name NOT IN ('master', 'tempdb', 'model', 'msdb')
          AND state_desc = 'ONLINE';
    END

    EXEC sp_executesql @sql;
END;
