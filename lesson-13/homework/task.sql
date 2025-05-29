DECLARE @StartDate DATE = '2025-05-01';
DECLARE @EndDate DATE = EOMONTH(@StartDate);


WITH Dates AS (
    SELECT @StartDate AS CalendarDate
    UNION ALL
    SELECT DATEADD(DAY, 1, CalendarDate)
    FROM Dates
    WHERE CalendarDate < @EndDate
),
-- Add week number and day of week (Sunday = 1, Saturday = 7)
Formatted AS (
    SELECT 
        CalendarDate,
        DATENAME(WEEKDAY, CalendarDate) AS DayName,
        DATEPART(WEEK, CalendarDate) - DATEPART(WEEK, @StartDate) + 1 AS WeekNum,
        DATEPART(WEEKDAY, CalendarDate) AS DayOfWeek
)
-- Pivot the dates into columns Sunday through Saturday
SELECT 
    MAX(CASE WHEN DATEPART(WEEKDAY, CalendarDate) = 1 THEN DAY(CalendarDate) END) AS Sunday,
    MAX(CASE WHEN DATEPART(WEEKDAY, CalendarDate) = 2 THEN DAY(CalendarDate) END) AS Monday,
    MAX(CASE WHEN DATEPART(WEEKDAY, CalendarDate) = 3 THEN DAY(CalendarDate) END) AS Tuesday,
    MAX(CASE WHEN DATEPART(WEEKDAY, CalendarDate) = 4 THEN DAY(CalendarDate) END) AS Wednesday,
    MAX(CASE WHEN DATEPART(WEEKDAY, CalendarDate) = 5 THEN DAY(CalendarDate) END) AS Thursday,
    MAX(CASE WHEN DATEPART(WEEKDAY, CalendarDate) = 6 THEN DAY(CalendarDate) END) AS Friday,
    MAX(CASE WHEN DATEPART(WEEKDAY, CalendarDate) = 7 THEN DAY(CalendarDate) END) AS Saturday
FROM Formatted
GROUP BY WeekNum
ORDER BY WeekNum
OPTION (MAXRECURSION 100);
