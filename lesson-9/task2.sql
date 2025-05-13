DECLARE @N INT = 10;

WITH Factorials AS (
    SELECT 1 AS Num, 1 AS Factorial
    UNION ALL
    SELECT Num + 1, Factorial * (Num + 1)
    FROM Factorials
    WHERE Num < @N
)
SELECT *
FROM Factorials
OPTION (MAXRECURSION 0);
