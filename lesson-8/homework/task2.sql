WITH Years AS (
    SELECT TOP (DATEDIFF(YEAR, 1975, GETDATE()) + 1)
        YEAR(DATEADD(YEAR, ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) - 1, '1975-01-01')) AS YearValue
    FROM master..spt_values  -- helper table for numbers
),
HiredYears AS (
    SELECT DISTINCT YEAR(HIRE_DATE) AS HireYear
    FROM EMPLOYEES_N
),
MissingYears AS (
    SELECT y.YearValue
    FROM Years y
    LEFT JOIN HiredYears h ON y.YearValue = h.HireYear
    WHERE h.HireYear IS NULL
),
ConsecutiveGroups AS (
    SELECT *,
           YearValue - ROW_NUMBER() OVER (ORDER BY YearValue) AS grp
    FROM MissingYears
)
SELECT 
    MIN(YearValue) AS StartYear,
    MAX(YearValue) AS EndYear,
    CAST(MIN(YearValue) AS VARCHAR) + ' - ' + CAST(MAX(YearValue) AS VARCHAR) AS [Years]
FROM ConsecutiveGroups
GROUP BY grp
ORDER BY StartYear;
