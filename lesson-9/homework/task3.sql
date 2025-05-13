DECLARE @N INT = 10;

WITH Fibonacci AS (
    SELECT 1 AS n, 1 AS Fibonacci_Number
    UNION ALL
    SELECT 2, 1
    UNION ALL
    SELECT n + 1, f1.Fibonacci_Number + f2.Fibonacci_Number
    FROM Fibonacci f1
    JOIN Fibonacci f2 ON f1.n = f2.n + 1
    WHERE f1.n + 1 <= 10
)
SELECT *
FROM Fibonacci
ORDER BY n
OPTION (MAXRECURSION 0);
